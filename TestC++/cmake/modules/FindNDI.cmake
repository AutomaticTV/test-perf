include(FindPackageHandleStandardArgs)


find_path(NDI_INCLUDE_DIR Processing.NDI.Lib.h
    PATHS
    ${NDI_PATH}/include
    /usr/local/NDI/include
    /usr/include
    )

find_library(NDI_LIBRARY Processing.NDI.Lib.x64
    PATHS
	 ${NDI_PATH}/lib/x64
    /usr/lib/x86_64-linux-gnu
	PATH_SUFFIXES lib
    )
	
 
find_package_handle_standard_args(
    NDI DEFAULT_MSG NDI_INCLUDE_DIR NDI_LIBRARY)

set(NDI_INCLUDE_DIRS ${NDI_INCLUDE_DIR})
set(NDI_LIBRARIES ${NDI_LIBRARY})
mark_as_advanced(NDI_INCLUDE_DIR NDI_LIBRARY)

if(NDI_FOUND)
 
  if(NDI_LIBRARY)
    add_library(ndi::ndi SHARED IMPORTED)
    set_target_properties(ndi::ndi PROPERTIES
						  IMPORTED_IMPLIB "${NDI_LIBRARY}"
                          INTERFACE_INCLUDE_DIRECTORIES "${NDI_INCLUDE_DIRS}"	
						  TARGET_DEPENDENCIES_COMMON 
						  "${NDI_PATH}/bin/x64/Processing.NDI.Lib.x64.dll" 	 
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""						  
			  )
   
  endif()

endif()

