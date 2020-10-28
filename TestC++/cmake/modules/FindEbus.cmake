include(FindPackageHandleStandardArgs)
 	
find_path(EBUS_INCLUDE_DIR PvBase.h
    PATHS
    ${EBUS_ROOT}/Includes
    /usr/local/EBUS/include
    /usr/include
    )

find_library(EBUS_LIBRARY_PVBASE PvBase64
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )

find_library(EBUS_LIBRARY_PVDEVICE PvDevice64
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )

find_library(EBUS_LIBRARY_PVAPPUTILS PvAppUtils64
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )
find_library(EBUS_LIBRARY_PVGENICAM PvGenICam64
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )
find_library(EBUS_LIBRARY_PVBUFFER PvBuffer64
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )
	
find_library(EBUS_LIBRARY_PVSTREAM PvStream64
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )
	
find_library(EBUS_LIBRARY_PVGUIVC11 PvGUI64_VC11
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )
			
 find_library(EBUS_LIBRARY_PVPERSISTENCE PvPersistence64
    PATHS
	 ${EBUS_ROOT}/Libraries
    /usr/lib/x86_64-linux-gnu
 
    )
			
 
find_package_handle_standard_args(
    EBUS DEFAULT_MSG EBUS_INCLUDE_DIR EBUS_LIBRARY_PVBASE EBUS_LIBRARY_PVDEVICE EBUS_LIBRARY_PVAPPUTILS EBUS_LIBRARY_PVGENICAM EBUS_LIBRARY_PVBUFFER EBUS_LIBRARY_PVSTREAM EBUS_LIBRARY_PVGUIVC11 EBUS_LIBRARY_PVPERSISTENCE)

set(EBUS_INCLUDE_DIRS ${EBUS_INCLUDE_DIR})
set(EBUS_LIBRARY ${EBUS_LIBRARY_PVBASE})
mark_as_advanced(EBUS_INCLUDE_DIR EBUS_LIBRARY)

if(EBUS_FOUND)

  if(EBUS_LIBRARY)
    add_library(ebus::pvbase SHARED IMPORTED)
    set_target_properties(ebus::pvbase PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVBASE}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"	
						  )
						  
   add_library(ebus::PvDevice SHARED IMPORTED)
    set_target_properties(ebus::PvDevice PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVDEVICE}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"					  
						  )
   add_library(ebus::PvAppUtils SHARED IMPORTED)
    set_target_properties(ebus::PvAppUtils PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVAPPUTILS}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"	
						  )
						  
	add_library(ebus::PvGenicam SHARED IMPORTED)
    set_target_properties(ebus::PvGenicam PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVGENICAM}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"	
						  )					  
						  
						  
	add_library(ebus::PvBuffer SHARED IMPORTED)
    set_target_properties(ebus::PvBuffer PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVBUFFER}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"	
						  )					  					  
	add_library(ebus::PvStream SHARED IMPORTED)
    set_target_properties(ebus::PvStream PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVSTREAM}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"	
						  )						  
    add_library(ebus::PvGuiVC11 SHARED IMPORTED)
    set_target_properties(ebus::PvGuiVC11 PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVGUIVC11}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"	
						  )	
    add_library(ebus::PvPersistence SHARED IMPORTED)
    set_target_properties(ebus::PvPersistence PROPERTIES
						  IMPORTED_IMPLIB "${EBUS_LIBRARY_PVPERSISTENCE}" 
                          INTERFACE_INCLUDE_DIRECTORIES "${EBUS_INCLUDE_DIRS}"	
						  )	
						  
						   
  endif()
  

endif()

