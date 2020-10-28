# Builds and sets the sources in the TARGET at the outer scope GLOB_EXCLUDE can be used to remove more from list of
# sources
function(build_sources_list TARGET)
    # Assign the parameters under PARAMS_*
    cmake_parse_arguments(PARAMS "" "GLOB_EXCLUDE" "" ${ARGN})

    # Find all sources, headers and resources
    file(GLOB_RECURSE SOURCEFILES CONFIGURE_DEPENDS *.cpp *.h *.cu *.cuh *.hpp *.ui *.qrc *.rc *.qml)

    # Traverse unit test files and remove from sources
   
    

    # If exclude pattern was set, apply it
    if(PARAMS_GLOB_EXCLUDE)
        list(FILTER SOURCEFILES EXCLUDE REGEX ${PARAMS_GLOB_EXCLUDE})
    endif()

    # Include the version file to embed it into the resulting file


    # Set the variable in the outer scope named like content of TARGET
    set(${TARGET} ${SOURCEFILES}  PARENT_SCOPE)

    # Set virtual folders for MSVC
    set_virtual_folders("${SOURCEFILES}")
endfunction()

function(add_git_hooks_to_target TARGET_NAME)
    add_custom_command(
        TARGET ${TARGET_NAME} PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -Ddestinationfile="${CMAKE_SOURCE_DIR}/.git/hooks/pre-commit"
                -Dsourcefile="${CMAKE_SOURCE_DIR}/code_style_check/pre-commit" -P
                ${CMAKE_SOURCE_DIR}/cmake/copy_if_not_exists.cmake)
endfunction()
