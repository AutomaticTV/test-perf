include(FindPackageHandleStandardArgs)

  
    # Non-OS X framework versions expect you to also dynamically link to
    # SDL2main. This is mainly for Windows and OS X. Other (Unix) platforms
    # seem to provide SDL2main for compatibility even though they don't
    # necessarily need it.

    if(SDL2_PATH)
      set(SDL2MAIN_LIBRARY_PATHS "${SDL2_PATH}")
    endif()

    if(NOT SDL2_NO_DEFAULT_PATH)
      set(SDL2MAIN_LIBRARY_PATHS
            /sw
            /opt/local
            /opt/csw
            /opt
            "${SDL2MAIN_LIBRARY_PATHS}"
      )
    endif()

    find_library(SDL2MAIN_LIBRARY
      NAMES SDL2main
      HINTS
        ENV SDL2DIR
        ${SDL2_NO_DEFAULT_PATH_CMD}
      PATH_SUFFIXES lib ${VC_LIB_PATH_SUFFIX}
      PATHS ${SDL2MAIN_LIBRARY_PATHS}
      DOC "Where the SDL2main library can be found"
    )
    unset(SDL2MAIN_LIBRARY_PATHS)
   
  
if(SDL2_LIBRARY)
  # For SDL2main
  if(SDL2MAIN_LIBRARY AND NOT SDL2_BUILDING_LIBRARY)
    list(FIND SDL2_LIBRARIES "${SDL2MAIN_LIBRARY}" _SDL2_MAIN_INDEX)
    if(_SDL2_MAIN_INDEX EQUAL -1)
      set(SDL2_LIBRARIES "${SDL2MAIN_LIBRARY}" ${SDL2_LIBRARIES})
    endif()
    unset(_SDL2_MAIN_INDEX)
  endif()

  # For OS X, SDL2 uses Cocoa as a backend so it must link to Cocoa.
  # CMake doesn't display the -framework Cocoa string in the UI even
  # though it actually is there if I modify a pre-used variable.
  # I think it has something to do with the CACHE STRING.
  # So I use a temporary variable until the end so I can set the
  # "real" variable in one-shot.
  if(APPLE)
    set(SDL2_LIBRARIES ${SDL2_LIBRARIES} "-framework Cocoa")
  endif()

  # For threads, as mentioned Apple doesn't need this.
  # In fact, there seems to be a problem if I used the Threads package
  # and try using this line, so I'm just skipping it entirely for OS X.
  if(NOT APPLE)
    set(SDL2_LIBRARIES ${SDL2_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
  endif()

  # For MinGW library
  if(MINGW)
    set(SDL2_LIBRARIES ${MINGW32_LIBRARY} ${SDL2_LIBRARIES})
  endif()

endif()

 
include(FindPackageHandleStandardArgs)
 
if(SDL2MAIN_LIBRARY)
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL2MAIN
                                    REQUIRED_VARS SDL2MAIN_LIBRARY SDL2_INCLUDE_DIR
                                    VERSION_VAR SDL2_VERSION_STRING)
endif()

  

  # SDL2::Main target
  # Applications should link to SDL2::Main instead of SDL2::Core
  # For more details, please see above.
  if(NOT SDL2_BUILDING_LIBRARY AND NOT TARGET SDL2::Main)

    if(SDL2_INCLUDE_DIR MATCHES ".framework" OR NOT SDL2MAIN_LIBRARY)
      add_library(SDL2::Main INTERFACE IMPORTED)
      set_property(TARGET SDL2::Main PROPERTY
                   INTERFACE_LINK_LIBRARIES SDL2::Core)
    elseif(SDL2MAIN_LIBRARY)
      # MinGW requires that the mingw32 library is specified before the
      # libSDL2main.a static library when linking.
      # The SDL2::MainInternal target is used internally to make sure that
      # CMake respects this condition.
      add_library(SDL2::MainInternal UNKNOWN IMPORTED)
      set_property(TARGET SDL2::MainInternal PROPERTY
                   IMPORTED_LOCATION "${SDL2MAIN_LIBRARY}")
      set_property(TARGET SDL2::MainInternal PROPERTY
                   INTERFACE_LINK_LIBRARIES SDL2::Core)

      add_library(SDL2::Main INTERFACE IMPORTED)

      if(MINGW)
        # MinGW needs an additional link flag '-mwindows' and link to mingw32
        set_property(TARGET SDL2::Main PROPERTY
                     INTERFACE_LINK_LIBRARIES "mingw32" "-mwindows")
      endif()
	set (DLLS_DEPS  "${APIS_PATH}/SDL2-2.0.7/lib/x64/sdl2.dll" "${CMAKE_SOURCE_DIR}/${TARGET_NAME}/ATVgamecontrollerdb.txt ")

      set_property(TARGET SDL2::Main APPEND PROPERTY
                   INTERFACE_LINK_LIBRARIES SDL2::MainInternal)
    endif()

  endif()
 
