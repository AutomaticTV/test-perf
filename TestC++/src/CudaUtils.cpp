#include "CudaUtils.h"

#include <atomic>
#include <unordered_set>

cudaError_t paCheck(cudaError_t result, char const *const expr,
                    char const *const func, const char *const file,
                    int const line, bool throwOnError) {
  if (result != cudaSuccess) {
    static std::atomic<bool> wasCudaFailureLogged = false;
    static std::unordered_set<cudaError_t> recurrentCudaErrorCodes = {
        cudaErrorLaunchFailure,       cudaErrorIllegalAddress,
        cudaErrorLaunchTimeout,       cudaErrorHardwareStackError,
        cudaErrorIllegalInstruction,  cudaErrorMisalignedAddress,
        cudaErrorInvalidAddressSpace, cudaErrorInvalidPc};
    const bool isResultSticky = recurrentCudaErrorCodes.count(result) > 0;
    const bool hasToLog = !wasCudaFailureLogged || !isResultSticky;

    std::stringstream ss;
    if (throwOnError) {
      ss << "Throwing exception because of ";
    }

    ss << "CUDA error: '" << cudaGetErrorName(result) << "' executing '" << expr
       << "' in '" << func << "' function at " << file << ":" << line << ".";

    if (hasToLog) {
      if (isResultSticky) {
        wasCudaFailureLogged = true;
      }

      std::cout << ss.str() << std::endl;
    }
    if (throwOnError) {
      throw std::exception(ss.str().c_str());
    }
  }
  return result;
}
