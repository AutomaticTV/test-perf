 if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.18.0")
    cmake_policy(SET CMP0104 NEW) # cuda archs
endif()
 

set(CMAKE_CXX_USE_RESPONSE_FILE_FOR_OBJECTS 1)
set(CMAKE_CXX_USE_RESPONSE_FILE_FOR_INCLUDES 1)
set(CMAKE_CXX_USE_RESPONSE_FILE_FOR_LIBRARIES 1)
set(CMAKE_CXX_RESPONSE_FILE_LINK_FLAG "@")

if(WIN32)
    if(CMAKE_GENERATOR MATCHES "Ninja")
        # don't set geneartor and toolset yet, ninja does not support it
        set(CMAKE_NINJA_FORCE_RESPONSE_FILE 1 CACHE INTERNAL "")
    else()
        # asume visual studio 2017 or newer other visual studio versions (2019) might be supported in the future
        set(CMAKE_GENERATOR_PLATFORM "x64")
        set(CMAKE_GENERATOR_TOOLSET "host=x64,cuda=10.1")
    endif()
endif()

set(OUT_DIR "${CMAKE_BINARY_DIR}/bin/${CMAKE_CFG_TYPE}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUT_DIR})

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER "CMake")
file(TO_CMAKE_PATH $ENV{APIS_PATH_VS2017} APIS_PATH)
set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "" FORCE)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules)