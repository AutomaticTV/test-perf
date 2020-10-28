# - Try to find Genicam
# Once done this will define
#  GENICAM_FOUND - System has genicam
#  GENICAM_INCLUDE_DIRS - The genicam include directories
#  GENICAM_LIBRARIES - The libraries needed to use genicam
#C:\Program Files\Basler\pylon 3.2\genicam\library\cpp\include
#C:\Program Files\Basler\pylon 3.2\genicam\library\cpp\lib\win64_x64

if(WIN32) 
	set( GENICAM_LIBRARY "$ENV{PYLON_GENICAM_ROOT}/lib/win64_x64" ) 
endif()
 
find_path(GENICAM_INCLUDE_DIR GenICam.h
			PATHS
			"$ENV{PYLON_GENICAM_ROOT}/include"
			)
 


find_library(	GENAPI_LIBRARY 
				NAMES 
				GenApi_gcc40_v2_3 GenApi_MD_VC100_v2_3
				PATHS
				${GENICAM_LIBRARY}
)

find_library(	GCBASE_LIBRARY 
				NAMES 
				GCBase_gcc40_v2_3 GCBase_MD_VC100_v2_3
				PATHS
				${GENICAM_LIBRARY}
)

find_library(	LOG4CPP_LIBRARY 
				NAMES 
				log4cpp_gcc40_v2_3 log4cpp_MD_VC100_v2_3
				PATHS
				${GENICAM_LIBRARY}
)

find_library(	LOG_GCC_LIBRARY 
				NAMES 
				Log_gcc40_v2_3 Log_MD_VC100_v2_3
				PATHS
				${GENICAM_LIBRARY}
)

find_library(	MATHPARSER_LIBRARY 
				NAMES 
				MathParser_gcc40_v2_3 MathParser_MD_VC100_v2_3
				PATHS
				${GENICAM_LIBRARY}
)

find_library(	CLPROTOCOL_LIBRARY
				NAMES 
				CLProtocol_gcc40_v2_3 CLProtocol_MD_VC100_v2_3
				PATHS
				${GENICAM_LIBRARY}
)


set(GENICAM_LIBRARIES ${GENAPI_LIBRARY} ${GCBASE_LIBRARY} ${LOG4CPP_LIBRARY} ${LOG_GCC_LIBRARY} ${MATHPARSER_LIBRARY})
set(GENICAM_INCLUDE_DIRS ${GENICAM_INCLUDE_DIR} )

include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(GENICAM DEFAULT_MSG
  GENICAM_INCLUDE_DIR
  GENICAM_LIBRARY)
set(GENICAM_INCLUDE_DIRS ${GENICAM_INCLUDE_DIR})
set(GENICAM_LIBRARIES ${GENAPI_LIBRARY})

mark_as_advanced(GENICAM_INCLUDE_DIR GENICAM_LIBRARIES)

	

if(GENICAM_FOUND)
  # cudnn::Core target
  if(GENAPI_LIBRARY)
    add_library(genicam::genapi SHARED IMPORTED)
    set_target_properties(genicam::genapi PROPERTIES
                          IMPORTED_IMPLIB ${GENAPI_LIBRARY}						  
                          INTERFACE_INCLUDE_DIRECTORIES "${GENICAM_INCLUDE_DIR}"	
						  TARGET_DEPENDENCIES_COMMON "$ENV{PYLON_GENICAM_ROOT}/bin/Win64_x64/GenApi_MD_VC100_v${GENICAM_VERSION_MAJOR}_${GENICAM_VERSION_MINOR}.dll"
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""
						  )
   
  endif()
  
  if(GCBASE_LIBRARY)
    add_library(genicam::gcbase SHARED IMPORTED)
    set_target_properties(genicam::gcbase PROPERTIES
                          IMPORTED_IMPLIB ${GCBASE_LIBRARY}						  
                          INTERFACE_INCLUDE_DIRECTORIES "${GENICAM_INCLUDE_DIR}"	
						  TARGET_DEPENDENCIES_COMMON "$ENV{PYLON_GENICAM_ROOT}/bin/Win64_x64/GCBase_MD_VC100_v${GENICAM_VERSION_MAJOR}_${GENICAM_VERSION_MINOR}.dll"
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""						  
						  )
   
  endif()
  
  if(LOG4CPP_LIBRARY)
    add_library(genicam::log4cpp SHARED IMPORTED)
    set_target_properties(genicam::log4cpp PROPERTIES
                          IMPORTED_IMPLIB ${LOG4CPP_LIBRARY}						  
                          INTERFACE_INCLUDE_DIRECTORIES "${GENICAM_INCLUDE_DIR}"	
					      TARGET_DEPENDENCIES_COMMON "$ENV{PYLON_GENICAM_ROOT}/bin/Win64_x64/log4cpp_MD_VC100_v${GENICAM_VERSION_MAJOR}_${GENICAM_VERSION_MINOR}.dll"
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""						  						  
						  )
   
  endif()
  
   if(LOG_GCC_LIBRARY)
    add_library(genicam::logcc SHARED IMPORTED)
    set_target_properties(genicam::logcc PROPERTIES
                          IMPORTED_IMPLIB ${LOG_GCC_LIBRARY}						  
                          INTERFACE_INCLUDE_DIRECTORIES "${GENICAM_INCLUDE_DIR}"	
						   TARGET_DEPENDENCIES_COMMON "$ENV{PYLON_GENICAM_ROOT}/bin/Win64_x64/Log_MD_VC100_v${GENICAM_VERSION_MAJOR}_${GENICAM_VERSION_MINOR}.dll"
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""		
						  
						  )
   
  endif()
  
   if(MATHPARSER_LIBRARY)
    add_library(genicam::mathparser SHARED IMPORTED)
    set_target_properties(genicam::mathparser PROPERTIES
                          IMPORTED_IMPLIB ${MATHPARSER_LIBRARY}						  
                          INTERFACE_INCLUDE_DIRECTORIES "${GENICAM_INCLUDE_DIR}"	
						  TARGET_DEPENDENCIES_COMMON "$ENV{PYLON_GENICAM_ROOT}/bin/Win64_x64/MathParser_MD_VC100_v${GENICAM_VERSION_MAJOR}_${GENICAM_VERSION_MINOR}.dll"
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""						  
						  )
   
  endif()
  
 
   if(CLPROTOCOL_LIBRARY)
    add_library(genicam::clprotocol SHARED IMPORTED)
    set_target_properties(genicam::clprotocol PROPERTIES
                          IMPORTED_IMPLIB ${CLPROTOCOL_LIBRARY}						  
                          INTERFACE_INCLUDE_DIRECTORIES "${GENICAM_INCLUDE_DIR}"		
						  TARGET_DEPENDENCIES_COMMON "$ENV{PYLON_GENICAM_ROOT}/bin/Win64_x64/CLProtocol_MD_VC100_v${GENICAM_VERSION_MAJOR}_${GENICAM_VERSION_MINOR}.dll"
						  TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""							  
						  )
   
  endif()
  
  
  
endif()

