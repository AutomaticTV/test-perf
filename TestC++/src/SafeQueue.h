#pragma once

#include <mutex>
#include <queue>


// Thread safe implementation of a Queue using a std::queue
template <typename T>
class SafeQueue {
private:
    std::queue<T> m_queue;
    mutable std::mutex m_mutex;

public:
    SafeQueue() {}
    ~SafeQueue() {}

    bool empty() const;
    int size() const;

    void enqueue(const T& t);
    bool dequeue(T& t);
    void clear();
};

template <typename T>
inline bool SafeQueue<T>::empty() const {
    std::unique_lock<std::mutex> lock(m_mutex);
    return m_queue.empty();
}

template <typename T>
inline int SafeQueue<T>::size() const {
    std::unique_lock<std::mutex> lock(m_mutex);
    return m_queue.size();
}

template <typename T>
inline void SafeQueue<T>::enqueue(const T& t) {
    std::unique_lock<std::mutex> lock(m_mutex);
    m_queue.push(t);
}

template <typename T>
inline bool SafeQueue<T>::dequeue(T& t) {
    std::unique_lock<std::mutex> lock(m_mutex);

    if (m_queue.empty())
        return false;

    t = std::move(m_queue.front());

    m_queue.pop();
    return true;
}

template <typename T>
inline void SafeQueue<T>::clear() {
    std::unique_lock<std::mutex> lock(m_mutex);
    m_queue = {};
}
