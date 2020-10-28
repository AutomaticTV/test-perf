#include <cuda.h>
#include <cuda_runtime.h>

void convertBGRtoRGBA(uchar4* rgba, const uchar3* bgr, int w, int h, cudaStream_t stream);
