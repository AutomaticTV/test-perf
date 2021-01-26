# Color conversion kernel

This code executes a kernel that converts BGR images to RGBA images. The algorithm is very simple, but can be optimized with both simple and complex changes. We also constantly work with this kind of problems, so it is very interesting for us to see which problems do you see in this code, what's the limiting factor for performance, and which kind of changes can be performed in order to improve that performance.

In case you are not familiar with CUDA compilers and GPU architectures, just expect no optimization from the compiler in the memory access patterns and memory alignment. Imagine that what you see, is what you get in assembler. Then, which are the main problems for performance in the code?

The code contains a CMakeFile ready to generate a project for Microsoft Visual Studio 2017. If you want to use Linux, you can use the typical nvcc commands for compiling.

Any bad practice or error you detect on the code, either CMake or C++ or CUDA, it's interesting for us that you mention.
