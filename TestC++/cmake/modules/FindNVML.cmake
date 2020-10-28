# FindNVML.cmake
  
if(WIN32)
    set(NVML_NAMES nvml)
    set(NVML_LIB_DIR "${CUDA_TOOLKIT_PATH}/lib/x64")
    set(NVML_INCLUDE_DIR ${CUDA_TOOLKIT_PATH}/include)
 
    # .lib import library full path
    find_file(NVML_LIBRARY
              NO_DEFAULT_PATH
              NAMES nvml.lib 
              PATHS ${NVML_LIB_DIR})

    # .dll full path
	set (NVML_DLL_DIR "${APIS_PATH}/nvml/dll_${NVIDIA_DRIVER_MAJOR_VERSION_EXPECTED}.${NVIDIA_DRIVER_MINOR_VERSION_EXPECTED}/" )
     find_file(NVML_DLL_PATH
              NO_DEFAULT_PATH
              NAMES nvml.dll
               PATHS ${NVML_DLL_DIR})
			   
    if (NVML_DLL_PATH)
		message (STATUS "FOUND NVML DLL:" ${NVML_DLL_PATH})
    else()
		message (FATAL_ERROR "missing NVML ${NVIDIA_DRIVER_MAJOR_VERSION_EXPECTED}.${NVIDIA_DRIVER_MINOR_VERSION_EXPECTED} at " ${NVML_DLL_DIR})
		
    endif()
 
# linux
elseif(UNIX AND NOT APPLE)
    set(NVML_NAMES nvidia-ml)
    set(NVML_LIB_DIR "${CUDA_TOOLKIT_PATH}/lib64/stubs")
    set(NVML_INCLUDE_DIR ${CUDA_INCLUDE_DIRS})
 
    find_library(NVML_LIBRARY                 
                 NAMES ${NVML_NAMES}
                 PATHS ${NVML_LIB_DIR})
else()
    message(FATAL_ERROR "Unsupported platform.")
endif()
 
find_path(NVML_INCLUDE_PATH
          NO_DEFAULT_PATH
          NAMES nvml.h
          PATHS ${NVML_INCLUDE_DIR})
 
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(NVML DEFAULT_MSG NVML_LIBRARY NVML_INCLUDE_PATH)

mark_as_advanced(NVML_INCLUDE_PATH NVML_LIBRARY)

if(NVML_FOUND)
  if(NVML_LIBRARY)
    add_library(nvml::nvml SHARED IMPORTED)
    set_target_properties(nvml::nvml PROPERTIES
                          IMPORTED_IMPLIB "${NVML_LIBRARY}"
                          INTERFACE_INCLUDE_DIRECTORIES "${NVML_INCLUDE_DIR}"
	                      			  	#deploy nvml.mll
	                      TARGET_DEPENDENCIES_COMMON  "${APIS_PATH}/nvml/dll_${NVIDIA_DRIVER_MAJOR_VERSION_EXPECTED}.${NVIDIA_DRIVER_MINOR_VERSION_EXPECTED}/nvml.dll "
	                      TARGET_DEPENDENCIES_DEBUG ""
	                      TARGET_DEPENDENCIES_RELEASE ""
						  )
  endif()
endif()

