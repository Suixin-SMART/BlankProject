cmake_minimum_required(VERSION 3.2.1)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Find the Shine Engine SDK
find_package(ShSDK)

# Enable C++11
set(CMAKE_CXX_STANDARD 11)

# Warnings
if (MSVC)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_CRT_SECURE_NO_WARNINGS")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_SCL_SECURE_NO_WARNINGS") # use /wd4996 instead ?
else (MSVC)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
endif (MSVC)

include(CMake/TargetBuildSAAS.cmake)

# cmake -G "Visual Studio 10 2010" -DBUILD_FILE_PATH="Path" -DBUILD_CONFIG_NAME="Config" ..\Project
ConfigureShineSAAS() # generate Manifest, icons ... Requires CMake options -DBUILD_FILE_PATH="Path" -DBUILD_CONFIG_NAME="Config"

add_subdirectory(src/Plugins)
add_subdirectory(src/Extension)
add_subdirectory(src/Game)