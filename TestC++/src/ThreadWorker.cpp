#include "ThreadWorker.h"

#include <cassert>

#include <cuda_runtime.h>


ThreadWorker::ThreadWorker(const int gpu_id, std::condition_variable& cond_var, SafeQueue<std::function<void()>>& queue,
                           std::exception_ptr& exception, std::mutex& exceptionMutex)
    : m_gpu_id(gpu_id)
    , m_running(true)
    , m_external_cond_var(cond_var)
    , m_external_queue(queue)
    , m_exception(exception)
    , m_exceptionMutex(exceptionMutex) {
    assert(m_gpu_id >= 0 && "Invalid device id");
}

ThreadWorker::~ThreadWorker() {}

void ThreadWorker::stopWorker() {
    m_running = false;
    m_external_cond_var.notify_one();
}

void ThreadWorker::operator()() {
    cudaSetDevice(m_gpu_id);

    while (m_running) {
        if (m_external_queue.empty()) {
            std::unique_lock<std::mutex> lock(m_mutex);
            m_external_cond_var.wait(lock, [&] { return !m_external_queue.empty() || !m_running; });
        }

        std::function<void()> func;
        bool dequeued = m_external_queue.dequeue(func);
        if (dequeued) {
            try {
                // The execution of the packaged_task inside the func may generate an
                // exception. This exception is explicitly propagated to the current
                // thread so we can do some error-handling actions
                func();
            } catch (...) {
                // Actions to do:
                // 1- We store the exception at the level of the GPUQueue, so the thread
                // that enqueues work knows
                //    that something went wrong, stops enqueueing more work and
                //    propagates the error
                // 2- We empty the queue of tasks without executing them. Note that this
                // implies that all non-executed
                //    tasks will have a std::future_errc::broken_promise exception in
                //    their state
                {
                    std::unique_lock<std::mutex> lock(m_exceptionMutex);
                    m_exception = std::current_exception();
                }
                m_external_queue.clear();
            }
        }
    }
}
