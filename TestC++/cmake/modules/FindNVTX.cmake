# FindNVTX.cmake
  
set(NVTX_INCLUDE_DIR "$ENV{NVTOOLSEXT_PATH}/include")
set(NVTX_LIB_DIR "$ENV{NVTOOLSEXT_PATH}/lib/x64")

find_path(NVTX_INCLUDE_PATH  nvToolsExt.h
      PATHS ${NVTX_INCLUDE_DIR})

# .lib import library full path
find_library(NVTX_LIBRARY
          nvToolsExt64_1   
          PATHS ${NVTX_LIB_DIR})


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(NVTX DEFAULT_MSG NVTX_LIBRARY NVTX_INCLUDE_PATH)

mark_as_advanced(NVTX_INCLUDE_PATH NVTX_LIBRARY)

if(NVTX_FOUND)
  if(NVTX_LIBRARY)
    add_library(nvtx::nvtx SHARED IMPORTED)
    set_target_properties(nvtx::nvtx PROPERTIES					     
                          IMPORTED_IMPLIB "${NVTX_LIBRARY}"
                          INTERFACE_INCLUDE_DIRECTORIES "${NVTX_INCLUDE_DIR}"
						  INTERFACE_COMPILE_DEFINITIONS "USE_NVTX"
						  TARGET_DEPENDENCIES_COMMON  "$ENV{NVTOOLSEXT_PATH}/bin/x64/nvToolsExt64_1.dll" 
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""
						  )
 				  
  endif()
endif()

