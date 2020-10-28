option(CUDA_ENABLE_NVTOOLSEXT "Enable CUDA_ENABLE_NVTOOLSEXT " OFF)
string(REGEX REPLACE "([0-9]+)\\.([0-9]+).*" "\\1" CUDA_VERSION_MAJOR ${CMAKE_CUDA_COMPILER_VERSION})
string(REGEX REPLACE "([0-9]+)\\.([0-9]+).*" "\\2" CUDA_VERSION_MINOR ${CMAKE_CUDA_COMPILER_VERSION})
set(NVIDIA_DRIVER_MAJOR_VERSION_EXPECTED 442)
set(NVIDIA_DRIVER_MINOR_VERSION_EXPECTED 92)
# enable response files for cuda
set(CMAKE_CUDA_USE_RESPONSE_FILE_FOR_OBJECTS 1)
set(CMAKE_CUDA_USE_RESPONSE_FILE_FOR_INCLUDES 1)
set(CMAKE_CUDA_USE_RESPONSE_FILE_FOR_LIBRARIES 1)
# https://cmake.org/cmake/help/latest/module/FindCUDAToolkit.html#module:FindCUDAToolkit
find_package(CUDAToolkit ${CUDA_VERSION_MAJOR}.${CUDA_VERSION_MINOR} EXACT REQUIRED)
function(add_cuda_to_target TARGET_NAME COMPONENTS)
    target_include_directories(${TARGET_NAME} PRIVATE "${CUDA_TOOLKIT_PATH}/include")
    set(COMPILER_CUDA_FLAGS --use_fast_math -Xcudafe)
    # Removing the following warnings (more than 1K warnings!): - base class dllexport/dllimport specification differs
    # from that of the derived class - field of class type without a DLL interface used in a class with a DLL interface
    list(APPEND COMPILER_CUDA_FLAGS "--diag_suppress=1388 --diag_suppress=1394")
    set_target_properties(${TARGET_NAME} PROPERTIES CUDA_STANDARD_REQUIRED ON CUDA_STANDARD 14 CUDA_RUNTIME_LIBRARY
                                                                                               Shared)
    if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.18.0")
        #set_property(TARGET ${TARGET_NAME} PROPERTY CUDA_ARCHITECTURES 52-real 61-real 75-real)
        set_property(TARGET ${TARGET_NAME} PROPERTY CUDA_ARCHITECTURES 61-real 75-real)
    else()
     #   list(APPEND COMPILER_CUDA_FLAGS -gencode=arch=compute_52,code=sm_52) # maxwell
        list(APPEND COMPILER_CUDA_FLAGS -gencode=arch=compute_61,code=sm_61) # pascal
        list(APPEND COMPILER_CUDA_FLAGS -gencode=arch=compute_75,code=sm_75) # turing
    endif()
    target_compile_definitions(
        ${TARGET_NAME} PRIVATE NVIDIA_DRIVER_MAJOR_VERSION_EXPECTED ${NVIDIA_DRIVER_MAJOR_VERSION_EXPECTED}
                               NVIDIA_DRIVER_MINOR_VERSION_EXPECTED ${NVIDIA_DRIVER_MINOR_VERSION_EXPECTED})
    target_compile_options(${TARGET_NAME} PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:${COMPILER_CUDA_FLAGS}>)
    if(${CUDA_ENABLE_NVTOOLSEXT})
        list(APPEND COMPONENTS nvToolsExt)
    endif()
    set(EXPORTED_TARGETS ${COMPONENTS}) # shared runtime
    list(TRANSFORM EXPORTED_TARGETS PREPEND "CUDA::")
    target_link_libraries(${TARGET_NAME} PRIVATE ${EXPORTED_TARGETS})
endfunction()