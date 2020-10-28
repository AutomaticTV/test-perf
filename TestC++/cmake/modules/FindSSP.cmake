if(WIN32) 
	set( SSP_LIBRARY_PATH "${SSP_ROOT}/lib/win_x64_vs2017" ) 
endif()
 
 set (SSP_INCLUDE_DIR ${SSP_ROOT}/include)
find_path(SSP_INCLUDE_DIR_LIBUV uv.h
			PATHS
			"${SSP_ROOT}/include/libuv/include"
			)

 
 
find_library(	SSP_LIBRARY_DEBUG 
				NAMES 
				libsspd
				PATHS
				${SSP_LIBRARY_PATH}
)
find_library(	SSP_LIBRARY_RELEASE 
				NAMES 
				libssp
				PATHS
				${SSP_LIBRARY_PATH}
)
 

include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SSP DEFAULT_MSG
  SSP_INCLUDE_DIR
  SSP_LIBRARY_DEBUG
  SSP_LIBRARY_RELEASE
  )
set (SSP_INCLUDE_DIRS ${SSP_INCLUDE_DIR} ${SSP_INCLUDE_DIR_LIBUV})
set (SSP_LIBRARY  ${SSP_LIBRARY_DEBUG} ${SSP_LIBRARY_RELEASE})

mark_as_advanced(SSP_INCLUDE_DIR SSP_LIBRARY_DEBUG SSP_LIBRARY_RELEASE)


if(SSP_FOUND)
  # cudnn::Core target
  if(SSP_LIBRARY)
    add_library(ssp::ssp SHARED IMPORTED)
    set_target_properties(ssp::ssp PROPERTIES
                          IMPORTED_IMPLIB_DEBUG ${SSP_LIBRARY_DEBUG}				  
						  IMPORTED_IMPLIB_RELEASE ${SSP_LIBRARY_RELEASE}	
					      IMPORTED_IMPLIB_RELWITHDEBINFO "${SSP_LIBRARY_RELEASE}"  
                          INTERFACE_INCLUDE_DIRECTORIES "${SSP_INCLUDE_DIRS}"
					      TARGET_DEPENDENCIES_COMMON ""
					      TARGET_DEPENDENCIES_DEBUG "${SSP_ROOT}/bin/libsspd.dll"
					      TARGET_DEPENDENCIES_RELEASE  "${SSP_ROOT}/bin/libssp.dll"						  
						  )
   
  endif()
  
  
  
endif()

