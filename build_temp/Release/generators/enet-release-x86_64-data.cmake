########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(enet_COMPONENT_NAMES "")
if(DEFINED enet_FIND_DEPENDENCY_NAMES)
  list(APPEND enet_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES enet_FIND_DEPENDENCY_NAMES)
else()
  set(enet_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(enet_PACKAGE_FOLDER_RELEASE "/home/ccn/.conan2/p/b/enetf3e00da2a0d7c/p")
set(enet_BUILD_MODULES_PATHS_RELEASE )


set(enet_INCLUDE_DIRS_RELEASE "${enet_PACKAGE_FOLDER_RELEASE}/include")
set(enet_RES_DIRS_RELEASE )
set(enet_DEFINITIONS_RELEASE )
set(enet_SHARED_LINK_FLAGS_RELEASE )
set(enet_EXE_LINK_FLAGS_RELEASE )
set(enet_OBJECTS_RELEASE )
set(enet_COMPILE_DEFINITIONS_RELEASE )
set(enet_COMPILE_OPTIONS_C_RELEASE )
set(enet_COMPILE_OPTIONS_CXX_RELEASE )
set(enet_LIB_DIRS_RELEASE "${enet_PACKAGE_FOLDER_RELEASE}/lib")
set(enet_BIN_DIRS_RELEASE )
set(enet_LIBRARY_TYPE_RELEASE STATIC)
set(enet_IS_HOST_WINDOWS_RELEASE 0)
set(enet_LIBS_RELEASE enet)
set(enet_SYSTEM_LIBS_RELEASE )
set(enet_FRAMEWORK_DIRS_RELEASE )
set(enet_FRAMEWORKS_RELEASE )
set(enet_BUILD_DIRS_RELEASE )
set(enet_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(enet_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${enet_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${enet_COMPILE_OPTIONS_C_RELEASE}>")
set(enet_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${enet_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${enet_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${enet_EXE_LINK_FLAGS_RELEASE}>")


set(enet_COMPONENTS_RELEASE )