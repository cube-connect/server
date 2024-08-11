# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(enet_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(enet_FRAMEWORKS_FOUND_DEBUG "${enet_FRAMEWORKS_DEBUG}" "${enet_FRAMEWORK_DIRS_DEBUG}")

set(enet_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET enet_DEPS_TARGET)
    add_library(enet_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET enet_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${enet_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${enet_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### enet_DEPS_TARGET to all of them
conan_package_library_targets("${enet_LIBS_DEBUG}"    # libraries
                              "${enet_LIB_DIRS_DEBUG}" # package_libdir
                              "${enet_BIN_DIRS_DEBUG}" # package_bindir
                              "${enet_LIBRARY_TYPE_DEBUG}"
                              "${enet_IS_HOST_WINDOWS_DEBUG}"
                              enet_DEPS_TARGET
                              enet_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "enet"    # package_name
                              "${enet_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${enet_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET enet::enet
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${enet_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${enet_LIBRARIES_TARGETS}>
                 )

    if("${enet_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET enet::enet
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     enet_DEPS_TARGET)
    endif()

    set_property(TARGET enet::enet
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${enet_LINKER_FLAGS_DEBUG}>)
    set_property(TARGET enet::enet
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${enet_INCLUDE_DIRS_DEBUG}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET enet::enet
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${enet_LIB_DIRS_DEBUG}>)
    set_property(TARGET enet::enet
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${enet_COMPILE_DEFINITIONS_DEBUG}>)
    set_property(TARGET enet::enet
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${enet_COMPILE_OPTIONS_DEBUG}>)

########## For the modules (FindXXX)
set(enet_LIBRARIES_DEBUG enet::enet)
