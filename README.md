# CUDA and C++ Test

The maing goal of this test is to understand and explain the provided codes, and their interaction with the hardware. The first test is a CPU code, that we want to parallelize with CUDA, and the second one is a CUDA kernel that we want you to optimize and execute in order to know the speedup you achieved. The CUDA discussion is limited to Kepler, Maxwell, Pascal or Turing architectures. The host code is done in C++.

Please clone the repository into your github account, and give us acces so we can see your way of working with Git.

You can use that cloned version to add the discussion or you can use a separeta document or an email.

Your version of the code should be available on the repository you created and shared with us.

## First test, code discussion

We provide a CPU code (which is not complete, and may contain errors) that we want to parallelize on a GPU with CUDA. 

You can assume that the defined values will always be the same, and the missing information is something that can change on each execution of the code. You can also assume that all data will fit on GPU device memory.

We don't ask you to compile or execute this code, neither to write the CUDA code. Instead we want you to discuss:

- Any comments on coding style C/C++.
- Most importantly, which things do you see in the code, and which can be good or bad for the GPU architecture.
- To know which parts of the code you would parallelize, why, and what's your intuition on the potential speedup.
- Explain which GPU memory would you use for each variable, and why.
- Can you think of any changes on the data structures, to make it faster on the GPU?

```cpp

#define NUM_VALS 5
#define NUM_RESULTS 16384

struct _my_data {
  int vals[NUM_VALS];
  uchar size; 
}

using my_data = _my_data;

int main(int argc, char **argv) {

  std::vector<my_data> data_vector;
  int* results;
  int* other;
  
  results = (int*)malloc(sizeof(int)*NUM_RESULTS);
  other = (int*)malloc(/*some size*/);
  // Fill other with values from some source
  
  //Fill in some values on data_vector
  for (int i=0; i < NUM_RESULTS; ++i){
    my_data temp = {{/*some 5 values from some source*/}, NUM_VALS};
    data_vector.push_back(temp);
    results[i] = /*a value from some source*/;
  }
  
  //Do the computations
  int count = 0;
  for (auto data_elem : data_vector) {
    for (int j=0; j < data_elem.size; ++j) {
      int read_val = data_elem.vals[j];
      results[count] = results[count] + other[read_val];
    }
    ++count;
  }
  
  return 0;
}
```
## Second test, kernel optimization

In the folder kernelColorConversion you can find some code with a description.

The goal of this test is to identify the most important performance problems, explain them and implement a version that improves the execution times. It does matter what's the final speed of the code, but what matters the most is the discussion you provide, and that any minimal improvement works.

Finally, on the Host code side, create 5 std::threads. Each thread execute's the same host code provided in the main function, N times in a loop. The goal is to allow the runtime to execute the 5xN kernel executions concurrently if possible.

Use NSIGHT to see the results.
