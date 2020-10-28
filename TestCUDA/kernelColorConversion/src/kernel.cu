#include "kernel.h"

#include <math.h>

#define GLOBAL_ID ( (((blockDim.y * blockIdx.y) + threadIdx.y) * (gridDim.x * blockDim.x)) + ((blockDim.x * blockIdx.x) + threadIdx.x) )

__global__ void kernel_bgrpacked2rgbapacked(const uchar3* bgr, int w, int h, uchar4* rgba) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;
    int i = y * w + x;

    if (x < w) {
        rgba[i].x = bgr[i].z;
        rgba[i].y = bgr[i].y;
        rgba[i].z = bgr[i].x;
        rgba[i].w = 255;
    }
}

void convertBGRtoRGBA(uchar4* rgba, const uchar3* bgr, int w, int h, cudaStream_t stream) {
    dim3 blocks(512, 1, 1);
    dim3 grid(ceil((float)w / (float)blocks.x), h, 1);

    kernel_bgrpacked2rgbapacked<<<grid, blocks, 0, stream>>>(bgr, w, h, rgba);
}
