include(FindPackageHandleStandardArgs)
 
find_path(H264BITSTREAM_INCLUDE_DIR h264_stream.h
    PATHS
    ${H264BITSTREAM_PATH}/include/h264bitstream
    /usr/local/h264bitstream/include
    /usr/include
    )


find_library(H264BITSTREAM_LIBRARY  libh264bitstream
    PATHS
    ${H264BITSTREAM_PATH}/lib
    /usr/local/h264bitstream/lib64
    /usr/lib/x86_64-linux-gnu
    )

	
find_package_handle_standard_args(
    H264BITSTREAM DEFAULT_MSG H264BITSTREAM_INCLUDE_DIR H264BITSTREAM_LIBRARY)

set(H264BITSTREAM_INCLUDE_DIRS ${H264BITSTREAM_INCLUDE_DIR})
set(H264BITSTREAM_LIBRARIES ${H264BITSTREAM_LIBRARY})
mark_as_advanced(H264BITSTREAM_INCLUDE_DIR H264BITSTREAM_LIBRARY)

 
if(H264BITSTREAM_FOUND)
  if(H264BITSTREAM_LIBRARY)
 
    add_library(h264bitstream::h264bitstream SHARED IMPORTED)
    set_target_properties(h264bitstream::h264bitstream PROPERTIES
                          IMPORTED_IMPLIB "${H264BITSTREAM_LIBRARY}"
                          INTERFACE_INCLUDE_DIRECTORIES "${H264BITSTREAM_INCLUDE_DIR}"	  
						  TARGET_DEPENDENCIES_COMMON
						  "${H264BITSTREAM_PATH}/bin/libh264bitstream-0.dll"   
					      TARGET_DEPENDENCIES_DEBUG ""
						  TARGET_DEPENDENCIES_RELEASE ""
						  )
 
    				  
  endif()

endif()
