#pragma once

#include <cuda.h>
#include <cuda_runtime.h>

#include <cassert>
#include <iostream>
#include <sstream>
#include <string>

cudaError_t paCheck(cudaError_t result, char const *const expr,
                    char const *const func, const char *const file,
                    int const line, bool throwOnError);

CUresult inline paCheck(CUresult result, char const *const expr,
                        char const *const func, const char *const file,
                        int const line, bool throwOnError) {
  return static_cast<CUresult>(paCheck(static_cast<cudaError_t>(result), expr,
                                       func, file, line, throwOnError));
}

bool inline isCudaHealthy() { return cudaPeekAtLastError() == cudaSuccess; }

#define CUDA_CHECK(expr)                                                       \
  paCheck((expr), #expr, __func__, __FILE__, __LINE__, /*throwOnError*/ false)

#define CUDA_CHECK_THROW_ON_ERROR(expr)                                        \
  paCheck((expr), #expr, __func__, __FILE__, __LINE__, /*throwOnError*/ true)

template <typename T> T inline divUp(T a, T b) { return (a + b - 1) / b; }

bool inline isPow2(unsigned int x) { return ((x & (x - 1)) == 0); }

#define CUDA_CHECK_LAST_ERROR CUDA_CHECK(cudaGetLastError())
