# Try to find Live555 libraries
# Once done this will define
#  Live555_FOUND
#  Live555_INCLUDE_DIRS
#  Live555_LIBRARIES

if (NOT Live555_FOUND)
 
	set(_Live555_FOUND ON)
	
	foreach (library liveMedia BasicUsageEnvironment Groupsock UsageEnvironment)
 
    string(TOLOWER ${library} lowercase_library in )
    
		find_path(Live555_${library}_INCLUDE_DIR
			NAMES
			${library}.hh
			${lowercase_library}.hh
			HINTS
			${Live555_ROOT}/include/live555/${library}
			/usr/local/include/${library}
			/usr/local/include/${lowercase_library}
			DOC "Where the live555 library can be found"
		)
		
		if (Live555_${library}_INCLUDE_DIR)
			list(APPEND _Live555_INCLUDE_DIRS ${Live555_${library}_INCLUDE_DIR})
		else()		
			set(_Live555_FOUND OFF)
		endif ()

		foreach (mode DEBUG RELEASE)
		if (${mode} STREQUAL DEBUG)
			set(libsuffix "d")
		else()
			set(libsuffix "")
		endif()

		endforeach ()
	endforeach ()
	
	find_library(Live555_LIBRARY_DEBUG
				NAMES
				live555d
				PATHS
			    ${Live555_ROOT}/lib/
			)
	 
	find_library(Live555_LIBRARY_RELEASE
				NAMES
				live555
				PATHS
			    ${Live555_ROOT}/lib/
			)			
				 
	if (_Live555_FOUND)
		set(Live555_INCLUDE_DIRS ${_Live555_INCLUDE_DIRS} CACHE INTERNAL "")
		set(Live555_FOUND ${_Live555_FOUND} CACHE BOOL "" FORCE)
	endif()
 
	include(FindPackageHandleStandardArgs)
	# handle the QUIETLY and REQUIRED arguments and set LOGGING_FOUND to TRUE
	# if all listed variables are TRUE
	find_package_handle_standard_args(Live555 DEFAULT_MSG Live555_INCLUDE_DIRS Live555_LIBRARY_DEBUG Live555_LIBRARY_RELEASE Live555_FOUND)

	# Tell cmake GUIs to ignore the "local" variables.
	mark_as_advanced(Live555_INCLUDE_DIRS Live555_LIBRARY_DEBUG Live555_LIBRARY_RELEASE Live555_FOUND)
endif (NOT Live555_FOUND)

if (Live555_FOUND)
 
	add_library(live555::live555 SHARED IMPORTED)
    set_target_properties(live555::live555 PROPERTIES
                          INTERFACE_INCLUDE_DIRECTORIES "${Live555_INCLUDE_DIRS}"
						  IMPORTED_FLAGS DEBUG_SCR
						  IMPORTED_IMPLIB_DEBUG "${Live555_LIBRARY_DEBUG}"
						  IMPORTED_IMPLIB_RELEASE "${Live555_LIBRARY_RELEASE}"
						  IMPORTED_IMPLIB_RELWITHDEBINFO "${Live555_LIBRARY_RELEASE}"  
						  TARGET_DEPENDENCIES_COMMON ""
					      TARGET_DEPENDENCIES_DEBUG "${Live555_ROOT}/bin/live555d.dll"  
						  TARGET_DEPENDENCIES_RELEASE "${Live555_ROOT}/bin/live555.dll"  
						  TARGET_DEPENDENCIES_RELWITHDEBINFO "${Live555_ROOT}/bin/live555.dll"  
						  )
endif()
