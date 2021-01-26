cmake_minimum_required(VERSION 3.17)

project("atv-test-cpp" LANGUAGES CXX CUDA)

find_package(CUDAToolkit REQUIRED)

file(GLOB_RECURSE SRCS src/*.h src/*.cpp src/*.cu)

add_executable(${PROJECT_NAME} ${SRCS})

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)

target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cudart CUDA::cuda_driver)
