include(FindPackageHandleStandardArgs)
set (VERSION_VAR 10.11.2)
find_path(DECKLINK_INCLUDE_DIR DeckLinkAPI.h
    PATHS
    ${DECKLINK_PATH}/${VERSION_VAR}/include
    /usr/local/DECKLINK/include
    /usr/include
    )
 

list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ".obj")	
find_library(DECKLINK_LIBRARY_DEBUG  DeckLinkAPI_i
    PATHS
	 ${DECKLINK_PATH}/${VERSION_VAR}/bin/x64/Debug/vc141
    /usr/lib/x86_64-linux-gnu
	PATH_SUFFIXES obj
    )
	
find_library(DECKLINK_LIBRARY_RELEASE DeckLinkAPI_i
    PATHS
    ${DECKLINK_PATH}/${VERSION_VAR}/bin/x64/Release/vc141
    /usr/lib/x86_64-linux-gnu
	PATH_SUFFIXES obj
    )
	
	
 
find_package_handle_standard_args(
    DECKLINK DEFAULT_MSG DECKLINK_INCLUDE_DIR DECKLINK_LIBRARY_DEBUG DECKLINK_LIBRARY_RELEASE)

set(DECKLINK_INCLUDE_DIRS ${DECKLINK_INCLUDE_DIR})
set(DECKLINK_LIBRARIES ${DECKLINK_LIBRARY_DEBUG} ${DECKLINK_LIBRARY_RELEASE} )
mark_as_advanced(DECKLINK_INCLUDE_DIR DECKLINK_LIBRARY_DEBUG DECKLINK_LIBRARY_RELEASE )

if(DECKLINK_FOUND)
  # cudnn::Core target
  if(DECKLINK_INCLUDE_DIR)
    add_library(decklink::decklink STATIC IMPORTED)
    set_target_properties(decklink::decklink PROPERTIES
                          IMPORTED_LOCATION_DEBUG "${DECKLINK_LIBRARY_DEBUG}"
						  IMPORTED_LOCATION_RELEASE "${DECKLINK_LIBRARY_RELEASE}"
						  IMPORTED_LOCATION_RELWITHDEBINFO "${DECKLINK_LIBRARY_RELEASE}"
                          INTERFACE_INCLUDE_DIRECTORIES "${DECKLINK_INCLUDE_DIRS}"					  
						  )
   
  endif()

endif()

