# Threaded C++ test
In this test you will find a CMakeLists.txt file, a cmake folder and a src folder. We don't require you to use CMake but if you are familiar with it, we'd like to know what you think about our cmake files.

In the src folder you will find several C++ source files. They implement what we call a GPUQueue, that we use in order to have a single CPU thread to interact with a single GPU.

We do that in order to avoid performance penalties when having a CPU thread changing from one GPU to another. That penalties come mainly from using Windows 10 and WDDM NVIDIA drivers.

So, with this GPUQueue, we can "send code" to the Queue thread, so that it executes it in the GPU it has assigned. If we have 3 GPU's, we will have an instance of GPUQueue for each GPU.

Along with the code you will find some usage examples in main.cpp

As we said in the main page, we have added a race condition to the code, that we would like you to work on finding. We don't expect you to devote more than 2h. It could take you a week to find it, depending on your multithreaded debugging experience, but we preffer that you spend time showing us how you would try to find the race condition.

Now, here is a list of especific questions and actions we ask you to do:
<ol>
<li>Tell us about our cmake files, if you are familiar with cmake. Would you do things differently? If you don't use cmake, how are you compiling our code?</li>
<li>Tell us what you understand about how the C++ code works.</li>
<li>Tell us whatever you know about CPU and GPU performance, that this code might positively or negatively affect.</li>
<li>If you don't see the race condition looking at the code, then what would you do in order to find it? Write the code you would do to find it, and explain your reasoning.</li>
</ol>
