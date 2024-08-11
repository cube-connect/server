message(STATUS "Conan: Using CMakeDeps conandeps_legacy.cmake aggregator via include()")
message(STATUS "Conan: It is recommended to use explicit find_package() per dependency instead")

find_package(enet)
find_package(glfw3)
find_package(glad)
find_package(glm)
find_package(assimp)
find_package(stb)
find_package(imgui)

set(CONANDEPS_LEGACY  enet::enet  glfw  glad::glad  glm::glm  assimp::assimp  stb::stb  imgui::imgui )