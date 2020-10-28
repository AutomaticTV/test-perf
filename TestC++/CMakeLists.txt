cmake_minimum_required (VERSION 3.17.0)

# Setting up the defaults
include(cmake/cmake_init.cmake)

project(Reproducer LANGUAGES CXX CUDA)

# CMake customizations and function definitions
include(cmake/virtualfolders.cmake)
include(cmake/build_sources_list.cmake)
include(cmake/deploy_dependencies.cmake)

# Visual Studio specific things
if (MSVC)
    include(cmake/msvc.cmake)
endif()

# External library configuration
include(cmake/libs/cuda.cmake)

add_subdirectory(src)