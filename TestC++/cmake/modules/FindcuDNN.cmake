# Find cUDNN, NVIDIA Deep Learning core computation library for CUDA.
# Returns:
#   CUDNN_INCLUDE_DIRS
#   CUDNN_LIBRARIES

include(FindPackageHandleStandardArgs)

find_path(CUDNN_INCLUDE_DIR cudnn.h
    PATHS
    ${CUDNN_PATH}/include
    /usr/local/cudnn/include
    /usr/include
    )

find_library(CUDNN_LIBRARY cudnn
    PATHS
    ${CUDNN_PATH}/lib/x64
    /usr/local/cudnn/lib64
    /usr/lib/x86_64-linux-gnu
    )

find_package_handle_standard_args(
    CUDNN DEFAULT_MSG CUDNN_INCLUDE_DIR CUDNN_LIBRARY)

set(CUDNN_INCLUDE_DIRS ${CUDNN_INCLUDE_DIR})
set(CUDNN_LIBRARIES ${CUDNN_LIBRARY})
mark_as_advanced(CUDNN_INCLUDE_DIR CUDNN_LIBRARY)

# SDL2:: targets (SDL2::Core and SDL2::Main)
if(CUDNN_FOUND)

  # cudnn::Core target
  if(CUDNN_LIBRARY)
    add_library(cudnn::cudnn SHARED IMPORTED)
    set_target_properties(cudnn::cudnn PROPERTIES
                          IMPORTED_IMPLIB "${CUDNN_LIBRARY}"
                          INTERFACE_INCLUDE_DIRECTORIES "${CUDNN_INCLUDE_DIR}"
						  #IMPORTED_LOCATION " $ENV{CUDNN_PATH}/bin/cudnn64_7.dll" #does not work on window
						   TARGET_DEPENDENCIES_COMMON
						 "${CUDNN_PATH}/bin/cudnn64_7.dll"  
					      TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""
						  )
   
  endif()
endif()
