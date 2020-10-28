# FindGoogleTest
# ---------
#
# Locate Google Test Framework
#
# This module defines:
#
# ::
#
#   GOOGLETEST_INCLUDE_DIRS, where to find the headers
#   GOOGLETEST_LIBRARIES, the libraries against which to link
#   GOOGLETEST_FOUND, if false, do not try to use the above mentioned vars
#

if (WIN32)
    list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ".a" ".lib")
    list(APPEND CMAKE_FIND_LIBRARY_PREFIXES "" "lib")
endif ()
  
find_path(
    GOOGLETEST_INCLUDE_DIR NAMES gtest/gtest.h
    PATHS ${GTEST_ROOT}/googletest/include/
    NO_DEFAULT_PATH
)

find_path(
    GOOGLEMOCK_INCLUDE_DIR NAMES gmock/gmock.h
    PATHS ${GTEST_ROOT}/googlemock/include/
    NO_DEFAULT_PATH
)

# DEBUG
find_library(
    GOOGLETEST_LIBRARY_DEBUG NAMES gtestd
    PATHS ${GTEST_ROOT}/lib/Debug/
    NO_DEFAULT_PATH
)

find_library(
    GOOGLETEST_MAIN_LIBRARY_DEBUG NAMES gtest_maind
    PATHS ${GTEST_ROOT}/lib/Debug/
    NO_DEFAULT_PATH
)

find_library(
    GOOGLEMOCK_LIBRARY_DEBUG NAMES gmockd
    PATHS ${GTEST_ROOT}/lib/Debug/
    NO_DEFAULT_PATH
)

find_library(
    GOOGLEMOCK_MAIN_LIBRARY_DEBUG NAMES gmock_maind
    PATHS ${GTEST_ROOT}/lib/Debug/
    NO_DEFAULT_PATH
)

# RELEASE
find_library(
    GOOGLETEST_LIBRARY_RELEASE NAMES gtest
    PATHS ${GTEST_ROOT}/lib/Release/
    NO_DEFAULT_PATH
)

find_library(
    GOOGLETEST_MAIN_LIBRARY_RELEASE NAMES gtest_main
    PATHS ${GTEST_ROOT}/lib/Release/
    NO_DEFAULT_PATH
)

find_library(
    GOOGLEMOCK_LIBRARY_RELEASE NAMES gmock
    PATHS ${GTEST_ROOT}/lib/Release/
    NO_DEFAULT_PATH
)

find_library(
    GOOGLEMOCK_MAIN_LIBRARY_RELEASE NAMES gmock_main
    PATHS ${GTEST_ROOT}/lib/Release/
    NO_DEFAULT_PATH
)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
    GOOGLETEST
    FOUND_VAR GOOGLETEST_FOUND
    REQUIRED_VARS
        GOOGLETEST_LIBRARY_DEBUG
        GOOGLETEST_MAIN_LIBRARY_DEBUG
        GOOGLEMOCK_LIBRARY_DEBUG
        GOOGLEMOCK_MAIN_LIBRARY_DEBUG
        GOOGLETEST_LIBRARY_RELEASE
        GOOGLETEST_MAIN_LIBRARY_RELEASE
        GOOGLEMOCK_LIBRARY_RELEASE
        GOOGLEMOCK_MAIN_LIBRARY_RELEASE
        GOOGLETEST_INCLUDE_DIR
        GOOGLEMOCK_INCLUDE_DIR
)

if(GOOGLETEST_FOUND)
    set(
        GOOGLE_LIBRARIES_DIR
        ${GTEST_ROOT}/lib/
    )

    set(
        GOOGLETEST_INCLUDE_DIRS
        ${GOOGLETEST_INCLUDE_DIR}
        ${GOOGLEMOCK_INCLUDE_DIR}
    )
endif(GOOGLETEST_FOUND)


mark_as_advanced(
    GOOGLETEST_INCLUDE_DIR
    GOOGLEMOCK_INCLUDE_DIR
    GOOGLETEST_LIBRARY_DEBUG
    GOOGLETEST_MAIN_LIBRARY_DEBUG
    GOOGLEMOCK_LIBRARY_DEBUG
    GOOGLEMOCK_MAIN_LIBRARY_DEBUG
    GOOGLETEST_LIBRARY_RELEASE
    GOOGLETEST_MAIN_LIBRARY_RELEASE
    GOOGLEMOCK_LIBRARY_RELEASE
    GOOGLEMOCK_MAIN_LIBRARY_RELEASE
)
