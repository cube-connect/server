

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
string(APPEND CONAN_CXX_FLAGS " -fsanitize=address -fuse-ld=mold")
string(APPEND CONAN_C_FLAGS " -fsanitize=address -fuse-ld=mold")
string(APPEND CONAN_SHARED_LINKER_FLAGS " -fsanitize=address -fuse-ld=mold")
string(APPEND CONAN_EXE_LINKER_FLAGS " -fsanitize=address -fuse-ld=mold")
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
list(PREPEND CMAKE_LIBRARY_PATH "/home/ccn/.conan2/p/b/enetf3e00da2a0d7c/p/lib" "/home/ccn/.conan2/p/b/glfwfdb1954ead981/p/lib" "/home/ccn/.conan2/p/b/gladb70f5e9a2ec7a/p/lib" "/home/ccn/.conan2/p/b/assim7a6fc1b049af0/p/lib" "/home/ccn/.conan2/p/b/miniz3a6f5f79596f8/p/lib" "/home/ccn/.conan2/p/b/bzip274af46ddeb28c/p/lib" "/home/ccn/.conan2/p/b/pugix2435af142898d/p/lib" "lib" "/home/ccn/.conan2/p/b/zlib07a6fffa961b1/p/lib" "/home/ccn/.conan2/p/b/kuba-a20bd548cece4/p/lib" "/home/ccn/.conan2/p/b/poly258f58f496de09/p/lib" "lib" "/home/ccn/.conan2/p/b/dracof180254efa694/p/lib" "/home/ccn/.conan2/p/b/clipp5507d3b6b72d2/p/lib" "/home/ccn/.conan2/p/b/opend4ae65cd59c596/p/lib" "/home/ccn/.conan2/p/b/imgui6fa52df29e06e/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/ccn/.conan2/p/b/enetf3e00da2a0d7c/p/include" "/home/ccn/.conan2/p/b/glfwfdb1954ead981/p/include" "/home/ccn/.conan2/p/b/gladb70f5e9a2ec7a/p/include" "/home/ccn/.conan2/p/glmdf97922a12435/p/include" "/home/ccn/.conan2/p/b/assim7a6fc1b049af0/p/include" "/home/ccn/.conan2/p/b/miniz3a6f5f79596f8/p/include" "/home/ccn/.conan2/p/b/miniz3a6f5f79596f8/p/include/minizip" "/home/ccn/.conan2/p/b/bzip274af46ddeb28c/p/include" "/home/ccn/.conan2/p/b/pugix2435af142898d/p/include" "include" "/home/ccn/.conan2/p/b/zlib07a6fffa961b1/p/include" "/home/ccn/.conan2/p/b/kuba-a20bd548cece4/p/include" "/home/ccn/.conan2/p/b/poly258f58f496de09/p/include" "include" "/home/ccn/.conan2/p/b/dracof180254efa694/p/include" "/home/ccn/.conan2/p/b/clipp5507d3b6b72d2/p/include" "/home/ccn/.conan2/p/stbf6cb8d59f52a8/p/include" "/home/ccn/.conan2/p/b/opend4ae65cd59c596/p/include" "/home/ccn/.conan2/p/b/imgui6fa52df29e06e/p/include")
set(CONAN_RUNTIME_LIB_DIRS "/home/ccn/.conan2/p/b/enetf3e00da2a0d7c/p/lib" "/home/ccn/.conan2/p/b/glfwfdb1954ead981/p/lib" "/home/ccn/.conan2/p/b/gladb70f5e9a2ec7a/p/lib" "/home/ccn/.conan2/p/b/assim7a6fc1b049af0/p/lib" "/home/ccn/.conan2/p/b/miniz3a6f5f79596f8/p/lib" "/home/ccn/.conan2/p/b/bzip274af46ddeb28c/p/lib" "/home/ccn/.conan2/p/b/pugix2435af142898d/p/lib" "lib" "/home/ccn/.conan2/p/b/zlib07a6fffa961b1/p/lib" "/home/ccn/.conan2/p/b/kuba-a20bd548cece4/p/lib" "/home/ccn/.conan2/p/b/poly258f58f496de09/p/lib" "lib" "/home/ccn/.conan2/p/b/dracof180254efa694/p/lib" "/home/ccn/.conan2/p/b/clipp5507d3b6b72d2/p/lib" "/home/ccn/.conan2/p/b/opend4ae65cd59c596/p/lib" "/home/ccn/.conan2/p/b/imgui6fa52df29e06e/p/lib" )



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
