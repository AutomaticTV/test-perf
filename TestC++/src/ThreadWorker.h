#pragma once

#include <atomic>
#include <exception>
#include <functional>
#include <mutex>

#include "SafeQueue.h"

class ThreadWorker {
public:
  ThreadWorker(const int gpu_id, std::condition_variable &cond_var,
               SafeQueue<std::function<void()>> &queue,
               std::exception_ptr &exception, std::mutex &exceptionMutex);
  ~ThreadWorker();

  void stopWorker();

  void operator()();

private:
  int m_gpu_id;
  std::atomic_bool m_running;
  std::condition_variable &m_external_cond_var;
  std::mutex m_mutex;
  SafeQueue<std::function<void()>> &m_external_queue;
  std::exception_ptr &m_exception;
  std::mutex &m_exceptionMutex;
};
