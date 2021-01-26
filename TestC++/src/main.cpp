#include <iostream>

#include "GPUQueue.h"


int foo(int val) {
    return val * 3;
}

class Foo {
public:
    Foo()
        : m_multiplier(3){};
    ~Foo(){};
    int foo(int val) {
        return val * m_multiplier;
    }

private:
    int m_multiplier;
};


int main() {
    std::cout << "Hello World!" << std::endl;

    GPUQueue queue(0);

    auto fResult1 = queue.enqueueTask(
        // We enqueue a lambda, that could contain any code
        []() {
            int a = 25 * 3;
            return a;
        });
    std::cout << "Result 1 is " << fResult1.get() << std::endl;

    // We enqueue a function
    auto fResult2 = queue.enqueueTask(&foo, 25);
    std::cout << "Result 2 is " << fResult2.get() << std::endl;

    Foo instance;

    // We enqueue a class method, from an specific class instance
    auto fResult3 = queue.enqueueTask(&Foo::foo, &instance, 25);
    std::cout << "Result 3 is " << fResult3.get() << std::endl;

    try {
        auto result1 = queue.enqueueTask([]() { throw std::exception("CUDA error"); });
        result1.wait();
        auto result2 = queue.enqueueTask([]() { return 75; });
        std::cout << "Result 4 is " << result2.get() << std::endl;
    } catch (const std::exception& e) {
        std::cout << "Captured exception: " << e.what() << std::endl;
    }

    return 0;
}
