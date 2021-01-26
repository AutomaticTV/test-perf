#include "kernel.h"

#include <iostream>

#include <cuda.h>
#include <cuda_runtime.h>


#define WIDTH 3833
#define HEIGHT 2160

bool checkResults(uchar4* rgba, uchar3* bgr, int size) {
    bool correct = true;

    for (int i = 0; i < size; ++i) {
        correct &= rgba[i].x == bgr[i].z;
        correct &= rgba[i].y == bgr[i].y;
        correct &= rgba[i].z == bgr[i].x;
        correct &= rgba[i].w == 255;
    }

    return correct;
}

int main() {
    uchar3 *h_bgr, *d_bgr;
    uchar4 *h_rgba, *d_rgba;

    int bar_widht = HEIGHT / 3;

    cudaError_t error;
    cudaStream_t stream;
    cudaStreamCreate(&stream);

    // Alloc and generate BGR bars.
    h_bgr = (uchar3*)malloc(sizeof(uchar3) * WIDTH * HEIGHT);
    for (int i = 0; i < WIDTH * HEIGHT; ++i) {
        if (i < bar_widht) {
            h_bgr[i] = {255, 0, 0};
        } else if (i < bar_widht * 2) {
            h_bgr[i] = {0, 255, 0};
        } else {
            h_bgr[i] = {0, 0, 255};
        }
    }
    error = cudaMalloc(&d_bgr, sizeof(uchar3) * WIDTH * HEIGHT);
    if (error != CUDA_SUCCESS)
        std::cout << "Error in cudaMalloc" << std::endl;

    // Alloc RGBA pointers
    h_rgba = (uchar4*)malloc(sizeof(uchar4) * WIDTH * HEIGHT);
    error = cudaMalloc(&d_rgba, sizeof(uchar4) * WIDTH * HEIGHT);
    if (error != CUDA_SUCCESS)
        std::cout << "Error in cudaMalloc" << std::endl;

    // Enqueue transfers and computation
    cudaMemcpyAsync(d_bgr, h_bgr, sizeof(uchar3) * WIDTH * HEIGHT, cudaMemcpyHostToDevice, stream);
    if (error != CUDA_SUCCESS)
        std::cout << "Error in cudaMemcpyAsync HostToDevice" << std::endl;

    convertBGRtoRGBA(d_rgba, d_bgr, WIDTH, HEIGHT, stream);
    error = cudaGetLastError();
    if (error != CUDA_SUCCESS)
        std::cout << "Error in kernel execution" << std::endl;

    cudaMemcpyAsync(h_rgba, d_rgba, sizeof(uchar4) * WIDTH * HEIGHT, cudaMemcpyDeviceToHost, stream);
    if (error != CUDA_SUCCESS)
        std::cout << "Error in cudaMemcpyAsync DeviceToHost" << std::endl;

    error = cudaStreamSynchronize(stream);
    if (error != CUDA_SUCCESS)
        std::cout << "Error in cudaStreamSynchronize" << std::endl;

    // Check the results
    bool ok = checkResults(h_rgba, h_bgr, WIDTH * HEIGHT);

    if (ok) {
        std::cout << "Executed!! Results OK." << std::endl;
    } else {
        std::cout << "Executed!! Results NOT OK." << std::endl;
    }

    return 0;
}