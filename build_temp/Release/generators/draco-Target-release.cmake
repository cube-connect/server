# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(draco_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(draco_FRAMEWORKS_FOUND_RELEASE "${draco_FRAMEWORKS_RELEASE}" "${draco_FRAMEWORK_DIRS_RELEASE}")

set(draco_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET draco_DEPS_TARGET)
    add_library(draco_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET draco_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${draco_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${draco_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### draco_DEPS_TARGET to all of them
conan_package_library_targets("${draco_LIBS_RELEASE}"    # libraries
                              "${draco_LIB_DIRS_RELEASE}" # package_libdir
                              "${draco_BIN_DIRS_RELEASE}" # package_bindir
                              "${draco_LIBRARY_TYPE_RELEASE}"
                              "${draco_IS_HOST_WINDOWS_RELEASE}"
                              draco_DEPS_TARGET
                              draco_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "draco"    # package_name
                              "${draco_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${draco_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET draco::draco
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${draco_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${draco_LIBRARIES_TARGETS}>
                 )

    if("${draco_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET draco::draco
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     draco_DEPS_TARGET)
    endif()

    set_property(TARGET draco::draco
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${draco_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET draco::draco
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${draco_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET draco::draco
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${draco_LIB_DIRS_RELEASE}>)
    set_property(TARGET draco::draco
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${draco_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET draco::draco
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${draco_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(draco_LIBRARIES_RELEASE draco::draco)
