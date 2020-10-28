# CUDA and C++ Test

The maing goal of this test is to understand and explain the provided codes, and their interaction with the hardware. The first test is a C++ CPU threaded code, that has a race condition we want you to try to find, and the second one is a CUDA kernel that we want you to optimize and execute in order to know the speedup you achieved. The CUDA discussion is limited to Maxwell, Pascal or Turing architectures. The host code is done in C++.

Please clone the repository into your github account, and give us acces so we can see your way of working with Git.

You can use that cloned version to add the discussion or you can use a separate document or an email.

Your version of the code should be available on the repository you created and shared with us.

## First test, threaded C++ code

We provide a CPU code that we know it has a race condition. 

We consider that the race condition is quite tricky to find, and that is why we don't expect you to necessarily find it. But at least, we would like to see how you try to find it. Which steps, which experiments, and the reasoning behind them. Of course, if you find it just by looking at the code, just write down an explanation.

You will find some more explanation in the TestC++ folder.

## Second test, kernel optimization

In the folder kernelColorConversion you can find some code with a description.

The goal of this test is to identify the most important performance problems, explain them and implement a version that improves the execution times. It does matter what's the final speed of the code, but what matters the most is the discussion you provide, and that any minimal improvement works.

Finally, on the Host code side, create 5 std::threads. Each thread execute's the same host code provided in the main function, N times in a loop. The goal is to allow the runtime to execute the 5xN kernel executions concurrently if possible.

Use NSIGHT to see the results if possible.

If you don't own an NVIDIA GPU, you can use google colab, seting a GPU runtime type.

To run cuda code more easily in google colab, execute this code:

!pip install git+git://github.com/andreinechaev/nvcc4jupyter.git

%load_ext nvcc_plugin
