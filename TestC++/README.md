# C++ test
In this test you will find a CMake-based project with sources inside `src` folder. You should be able to compile and run this project. We don't require you to use CMake, it's only there for convenience.

The project implements what we call a GPUQueue - component a version of which we use in order to have a single CPU thread interacting with a single GPU. If we have 3 GPU's, we will have an instance of GPUQueue for each GPU. We do that in order to avoid performance penalties when having a CPU thread changing from one GPU to another. Those penalties come mainly from using Windows 10 and WDDM NVIDIA drivers.

You will find some usage examples in main.cpp. As we said in the main page, the project contains **race conditions** (yes, more than one), that we would like you to work on finding. *They are related to exception handling in the code and also to the producer-consumer pattern implemented.*

We don't expect you to devote more than 2h to this part. Depending on your multithreaded debugging experience, it could take you much more time to find it, but we prefer that you instead spend time showing us how to debug and fix it.

---

Now, here is a list of specific questions and actions we would like you to do:

- Tell us about your CMake experience. We'd like to know what modern CMake features you have used.
- Tell us what do you understand about how the C++ code works.
- Tell us whatever you know about CPU and GPU performance, that this code might positively or negatively affect.
- If you don't see any (or more than one) race conditions looking at the code, then what would you do in order to find them? Explain your reasoning.
