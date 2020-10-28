build_sources_list(SRCS)
set(TARGET_NAME "Reproducer")
add_executable(${TARGET_NAME} ${SRCS})
target_include_directories(${TARGET_NAME}  PUBLIC ${CMAKE_SOURCE_DIR} )
set_msvc_compiler_definitions(${TARGET_NAME})

set(CUDA_LIBS "cudart; cuda_driver")
add_cuda_to_target(${TARGET_NAME} ${CUDA_LIBS})
