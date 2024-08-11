########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(enet_FIND_QUIETLY)
    set(enet_MESSAGE_MODE VERBOSE)
else()
    set(enet_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/enetTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${enet_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(enet_VERSION_STRING "1.3.18")
set(enet_INCLUDE_DIRS ${enet_INCLUDE_DIRS_RELEASE} )
set(enet_INCLUDE_DIR ${enet_INCLUDE_DIRS_RELEASE} )
set(enet_LIBRARIES ${enet_LIBRARIES_RELEASE} )
set(enet_DEFINITIONS ${enet_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${enet_BUILD_MODULES_PATHS_RELEASE} )
    message(${enet_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


