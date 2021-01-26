#pragma once

#include <exception>
#include <functional>
#include <future>
#include <mutex>
#include <type_traits>

#include "SafeQueue.h"
#include "ThreadWorker.h"

//! It represents a thread-safe queue of callable objects. Those objects are
//! executed by an extra worker thread created for that purpose. If the worker
//! thread yields an exception, it will store it in 'm_exception' and will empty
//! the queue. Any subsequent enqueue to that queue will rethrow the exception,
//! propagating the exception of the worker thread to the current thread. Note
//! also that you can explicitly check whether there was some errors through
//! 'checkException'. You can reset the status of GPUQueue, making it usable
//! again.
class GPUQueue {
public:
    explicit GPUQueue(int gpu_id);
    GPUQueue(const GPUQueue& other) = delete;
    ~GPUQueue();

    template <typename F, typename... Args>
    auto enqueueTask(F&& f, Args&&... args) {
        // We will stop enqueueing work if a task of the queue emitted an exception
        checkException();

        // std::result_of_t was deprecated in C++17 but nvcc only supports up to
        // C++14.
        //  using ResultType = std::invoke_result_t<F,Args...>;
        using ResultType = std::result_of_t<F(Args...)>;

        // Create a function with bounded parameters ready to execute
        std::function<ResultType()> func = std::bind(std::forward<F>(f), std::forward<Args>(args)...);

        // Encapsulate it into a shared ptr in order to be able to copy construct /
        // assign
        auto task_ptr = std::make_shared<std::packaged_task<ResultType()>>(func);

        // Building the shared_future: note that std::packaged_task<...>::get_future
        // should only be called once
        std::shared_future<ResultType> sh_future(task_ptr->get_future());

        // Wrap packaged task into void function
        std::function<void()> wrapper_func = [task_ptr, sh_future]() {
            // Execute the task code
            (*task_ptr)();
            // We ask for the results of the previously-executed task here. This is
            // done to propagate the exceptions of the packaged_task to the current
            // thread
            sh_future.get();
        };

        // Enqueue generic wrapper function
        m_safe_queue.enqueue(wrapper_func);

        // Wake up one thread if its waiting
        // The lock does not need to be held for notification
        m_conditional_var.notify_one();

        // Even if we explicitly waited for the execution of the task, we should
        // return a valid shared_future because it may be used from other places
        return sh_future;
    }

    void reset();

    void checkException() const {
        std::unique_lock<std::mutex> lock(m_exceptionMutex);
        if (m_exception)
            std::rethrow_exception(m_exception);
    }

private:
    int m_gpu_id;

    std::exception_ptr m_exception;
    mutable std::mutex m_exceptionMutex;

    std::condition_variable m_conditional_var;

    SafeQueue<std::function<void()>> m_safe_queue;

    ThreadWorker m_worker;
    std::thread m_thread;
};

using PAGPUQueue_ptr = std::shared_ptr<GPUQueue>;
