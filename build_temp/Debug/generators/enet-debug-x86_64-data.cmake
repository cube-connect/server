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
set(enet_PACKAGE_FOLDER_DEBUG "/home/ccn/.conan2/p/b/enet7e66908b5d618/p")
set(enet_BUILD_MODULES_PATHS_DEBUG )


set(enet_INCLUDE_DIRS_DEBUG "${enet_PACKAGE_FOLDER_DEBUG}/include")
set(enet_RES_DIRS_DEBUG )
set(enet_DEFINITIONS_DEBUG )
set(enet_SHARED_LINK_FLAGS_DEBUG )
set(enet_EXE_LINK_FLAGS_DEBUG )
set(enet_OBJECTS_DEBUG )
set(enet_COMPILE_DEFINITIONS_DEBUG )
set(enet_COMPILE_OPTIONS_C_DEBUG )
set(enet_COMPILE_OPTIONS_CXX_DEBUG )
set(enet_LIB_DIRS_DEBUG "${enet_PACKAGE_FOLDER_DEBUG}/lib")
set(enet_BIN_DIRS_DEBUG )
set(enet_LIBRARY_TYPE_DEBUG STATIC)
set(enet_IS_HOST_WINDOWS_DEBUG 0)
set(enet_LIBS_DEBUG enet)
set(enet_SYSTEM_LIBS_DEBUG )
set(enet_FRAMEWORK_DIRS_DEBUG )
set(enet_FRAMEWORKS_DEBUG )
set(enet_BUILD_DIRS_DEBUG )
set(enet_NO_SONAME_MODE_DEBUG FALSE)


# COMPOUND VARIABLES
set(enet_COMPILE_OPTIONS_DEBUG
    "$<$<COMPILE_LANGUAGE:CXX>:${enet_COMPILE_OPTIONS_CXX_DEBUG}>"
    "$<$<COMPILE_LANGUAGE:C>:${enet_COMPILE_OPTIONS_C_DEBUG}>")
set(enet_LINKER_FLAGS_DEBUG
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${enet_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${enet_SHARED_LINK_FLAGS_DEBUG}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${enet_EXE_LINK_FLAGS_DEBUG}>")


set(enet_COMPONENTS_DEBUG )