

# Conan automatically generated toolchain file
# DO NOT EDIT MANUALLY, it will be overwritten

# Avoid including toolchain file several times (bad if appending to variables like
#   CMAKE_CXX_FLAGS. See https://github.com/android/ndk/issues/323
include_guard()

message(STATUS "Using Conan toolchain: ${CMAKE_CURRENT_LIST_FILE}")

if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeToolchain' generator only works with CMake >= 3.15")
endif()




########## generic_system block #############
# Definition of system, platform and toolset
#############################################







string(APPEND CONAN_CXX_FLAGS " -m64")
string(APPEND CONAN_C_FLAGS " -m64")
string(APPEND CONAN_SHARED_LINKER_FLAGS " -m64")
string(APPEND CONAN_EXE_LINKER_FLAGS " -m64")



message(STATUS "Conan toolchain: C++ Standard 23 with extensions OFF")
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Conan conf flags start: 
# Conan conf flags end

foreach(config IN LISTS CMAKE_CONFIGURATION_TYPES)
    string(TOUPPER ${config} config)
    if(DEFINED CONAN_CXX_FLAGS_${config})
      string(APPEND CMAKE_CXX_FLAGS_${config}_INIT " ${CONAN_CXX_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_C_FLAGS_${config})
      string(APPEND CMAKE_C_FLAGS_${config}_INIT " ${CONAN_C_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_SHARED_LINKER_FLAGS_${config})
      string(APPEND CMAKE_SHARED_LINKER_FLAGS_${config}_INIT " ${CONAN_SHARED_LINKER_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_EXE_LINKER_FLAGS_${config})
      string(APPEND CMAKE_EXE_LINKER_FLAGS_${config}_INIT " ${CONAN_EXE_LINKER_FLAGS_${config}}")
    endif()
endforeach()

if(DEFINED CONAN_CXX_FLAGS)
  string(APPEND CMAKE_CXX_FLAGS_INIT " ${CONAN_CXX_FLAGS}")
endif()
if(DEFINED CONAN_C_FLAGS)
  string(APPEND CMAKE_C_FLAGS_INIT " ${CONAN_C_FLAGS}")
endif()
if(DEFINED CONAN_SHARED_LINKER_FLAGS)
  string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${CONAN_SHARED_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_EXE_LINKER_FLAGS)
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${CONAN_EXE_LINKER_FLAGS}")
endif()




get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(_CMAKE_IN_TRY_COMPILE)
    message(STATUS "Running toolchain IN_TRY_COMPILE")
    return()
endif()

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG ON)

# Definition of CMAKE_MODULE_PATH
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "/home/ccn/.conan2/p/b/enet7e66908b5d618/p/lib" "/home/ccn/.conan2/p/b/glfw8311b1aac4225/p/lib" "/home/ccn/.conan2/p/b/gladc5dbbf17fc0e2/p/lib" "/home/ccn/.conan2/p/b/assim3f3b0a92ce031/p/lib" "/home/ccn/.conan2/p/b/miniz8018d7e689fb3/p/lib" "/home/ccn/.conan2/p/b/bzip2878c721a516bf/p/lib" "/home/ccn/.conan2/p/b/pugixa17bcdec405e3/p/lib" "lib" "/home/ccn/.conan2/p/b/zlib6795f36203c7a/p/lib" "/home/ccn/.conan2/p/b/kuba-2e660cc52bab9/p/lib" "/home/ccn/.conan2/p/b/poly273c8e1b99e763/p/lib" "lib" "/home/ccn/.conan2/p/b/draco13ad89d715b92/p/lib" "/home/ccn/.conan2/p/b/clippe4f6ec555b04c/p/lib" "/home/ccn/.conan2/p/b/opend808c24f11b6f2/p/lib" "/home/ccn/.conan2/p/b/imguide9deb2b84dce/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/ccn/.conan2/p/b/enet7e66908b5d618/p/include" "/home/ccn/.conan2/p/b/glfw8311b1aac4225/p/include" "/home/ccn/.conan2/p/b/gladc5dbbf17fc0e2/p/include" "/home/ccn/.conan2/p/glmdf97922a12435/p/include" "/home/ccn/.conan2/p/b/assim3f3b0a92ce031/p/include" "/home/ccn/.conan2/p/b/miniz8018d7e689fb3/p/include" "/home/ccn/.conan2/p/b/miniz8018d7e689fb3/p/include/minizip" "/home/ccn/.conan2/p/b/bzip2878c721a516bf/p/include" "/home/ccn/.conan2/p/b/pugixa17bcdec405e3/p/include" "include" "/home/ccn/.conan2/p/b/zlib6795f36203c7a/p/include" "/home/ccn/.conan2/p/b/kuba-2e660cc52bab9/p/include" "/home/ccn/.conan2/p/b/poly273c8e1b99e763/p/include" "include" "/home/ccn/.conan2/p/b/draco13ad89d715b92/p/include" "/home/ccn/.conan2/p/b/clippe4f6ec555b04c/p/include" "/home/ccn/.conan2/p/stbf6cb8d59f52a8/p/include" "/home/ccn/.conan2/p/b/opend808c24f11b6f2/p/include" "/home/ccn/.conan2/p/b/imguide9deb2b84dce/p/include")
set(CONAN_RUNTIME_LIB_DIRS "/home/ccn/.conan2/p/b/enet7e66908b5d618/p/lib" "/home/ccn/.conan2/p/b/glfw8311b1aac4225/p/lib" "/home/ccn/.conan2/p/b/gladc5dbbf17fc0e2/p/lib" "/home/ccn/.conan2/p/b/assim3f3b0a92ce031/p/lib" "/home/ccn/.conan2/p/b/miniz8018d7e689fb3/p/lib" "/home/ccn/.conan2/p/b/bzip2878c721a516bf/p/lib" "/home/ccn/.conan2/p/b/pugixa17bcdec405e3/p/lib" "lib" "/home/ccn/.conan2/p/b/zlib6795f36203c7a/p/lib" "/home/ccn/.conan2/p/b/kuba-2e660cc52bab9/p/lib" "/home/ccn/.conan2/p/b/poly273c8e1b99e763/p/lib" "lib" "/home/ccn/.conan2/p/b/draco13ad89d715b92/p/lib" "/home/ccn/.conan2/p/b/clippe4f6ec555b04c/p/lib" "/home/ccn/.conan2/p/b/opend808c24f11b6f2/p/lib" "/home/ccn/.conan2/p/b/imguide9deb2b84dce/p/lib" )



if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()




set(CMAKE_INSTALL_BINDIR "bin")
set(CMAKE_INSTALL_SBINDIR "bin")
set(CMAKE_INSTALL_LIBEXECDIR "bin")
set(CMAKE_INSTALL_LIBDIR "lib")
set(CMAKE_INSTALL_INCLUDEDIR "include")
set(CMAKE_INSTALL_OLDINCLUDEDIR "include")


# Variables
# Variables  per configuration


# Preprocessor definitions
# Preprocessor definitions per configuration


if(CMAKE_POLICY_DEFAULT_CMP0091)  # Avoid unused and not-initialized warnings
endif()
