#include "GPUQueue.h"

#include <thread>

GPUQueue::GPUQueue(int gpu_id)
    : m_gpu_id(gpu_id)
    , m_exception(nullptr)
    , m_worker(m_gpu_id, m_conditional_var, m_safe_queue, m_exception, m_exceptionMutex)
    , m_thread(&ThreadWorker::operator(), &m_worker) {}

GPUQueue::~GPUQueue() {
    m_worker.stopWorker();
    m_thread.join();
}

void GPUQueue::reset() {
    m_exception = nullptr;
}
