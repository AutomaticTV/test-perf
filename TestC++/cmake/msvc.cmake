set(CMAKE_VS_JUST_MY_CODE_DEBUGGING 1)
set(CMAKE_INSTALL_SYSTEM_RUNTIME_COMPONENT "Runtime")

set(CMAKE_INSTALL_UCRT_LIBRARIES FALSE)

set(CMAKE_INSTALL_MFC_LIBRARIES FALSE)

include(InstallRequiredSystemLibraries) # Install MSVC runtime DLLs

function(set_msvc_compiler_definitions TARGET_NAME)
    # Assign the parameters under PARAMS_*
    cmake_parse_arguments(PARAMS "PERMISSIVE;WITH_OPENMP" "" "" ${ARGN})

    target_compile_definitions(${TARGET_NAME} PUBLIC "UNICODE")
    target_compile_definitions(${TARGET_NAME} PUBLIC "_UNICODE")

    set_target_properties(${TARGET_NAME} PROPERTIES
                        CXX_STANDARD 17
                        CXX_STANDARD_REQUIRED YES
                        CXX_EXTENSIONS NO
                        CUDA_STANDARD_REQUIRED OFF
                        CUDA_ARCHITECTURES OFF # enabled in cuda.cmake
                        VS_JUST_MY_CODE_DEBUGGING TRUE
    )

    # https://gitlab.kitware.com/cmake/cmake/issues/17720 &https://docs.microsoft.com/en-us/cpp/build/reference/ltcg-
    # link-time-code-generation?view=vs-2017

    set(CXX_COMPILER_FLAGS /diagnostics:caret /arch:AVX /utf-8 /bigobj)
    target_compile_options(${TARGET_NAME} PRIVATE $<$<COMPILE_LANGUAGE:CXX>:/permissive->)
  
        message(STATUS "Compiling ${TARGET_NAME} in PERMISSIVE mode")
     
    target_include_directories(${TARGET_NAME} PRIVATE ${CMAKE_BINARY_DIR}/generated) # for generated version.h files
    target_compile_options(${TARGET_NAME} PUBLIC $<$<COMPILE_LANGUAGE:CXX>:${CXX_COMPILER_FLAGS}>)
    target_link_options(
        ${TARGET_NAME} PRIVATE $<$<CONFIG:DEBUG>:$<$<COMPILE_LANGUAGE:CXX>:/ignore:4099>>) # Disable debug build
                                                                                           # warnings about missing
                                                                                           # pdb's (out of our control)
endfunction()
