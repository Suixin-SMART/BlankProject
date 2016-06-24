# - Try to find ShSDK
# Once done this will define
#  SHSDK_FOUND - System has ShSDK
#  SHSDK_INCLUDE_DIRS - The ShSDK include directories
#  SHSDK_LIBRARIES - The libraries needed to use ShSDK

find_path(SDK_HEADER "ShSDK/ShSDK.h" HINTS ENV SHINE_BASE_DIR "../Shine/" PATHS /usr/local/ PATH_SUFFIXES "include")
include_directories(${SDK_HEADER})

macro(FIND_SHSDK_LIBRARY _var)
	find_library(${_var} NAMES ${ARGN} HINTS ENV SHINE_BASE_DIR "../Shine/" PATHS /usr/local/ PATH_SUFFIXES "lib")
	mark_as_advanced(${_var})
endmacro()

# ------------------------------------------------------------------------------------------------

if (MSVC)
	set(SHSDK_COMPILE_FLAGS "/EHs-c- /GR-") # disable exceptions / disable RTTI
else (MSVC)
	set(SHSDK_COMPILE_FLAGS "-fno-exceptions -fno-rtti")
endif (MSVC)

set(SHSDK_COMPILE_DEFINITIONS )

if (MSVC)
	list(APPEND SHSDK_COMPILE_DEFINITIONS "_ITERATOR_DEBUG_LEVEL=0")
endif (MSVC)

list(APPEND SHSDK_COMPILE_DEFINITIONS "SH_DEV=1" "SH_$<UPPER_CASE:$<CONFIG>>=1")

# ------------------------------------------------------------------------------------------------

# Detect platform
if(${CMAKE_SYSTEM_NAME} MATCHES "XboxOne")
	message(STATUS "Detected platform: Xbox One")
	set(SH_XBOXONE 1)
elseif(XBOX360)
	message(STATUS "Detected platform: Xbox 360")
	set(SH_XBOX360 1)
elseif(PS4)
	message(STATUS "Detected platform: PS4")
	set(SH_PS4 1)
elseif(PS3)
	message(STATUS "Detected platform: PS3")
	set(SH_PS3 1)
elseif(PSVITA)
	message(STATUS "Detected platform: PSVITA")
	set(SH_PSVITA 1)
elseif(WIN32)
	message(STATUS "Detected platform: Windows")
	set(SH_PC 1)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Android")
	message(STATUS "Detected platform: Android")
	set(SH_ANDROID 1)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
	message(STATUS "Detected platform: Linux")
	set(SH_LINUX 1)
elseif(APPLE)
	set(SH_APPLE 1)
	if (IOS) # IOS is defined in the toolchain
		message(STATUS "Detected platform: iOS")
		set(SH_IOS 1)
	else () # What about Android on Mac ?
		message(STATUS "Detected platform: Mac")
		set(SH_MAC 1)
	endif ()
else()
	message(STATUS "Detected platform: Unknown")
endif()

# ------------------------------------------------------------------------------------------------

FIND_SHSDK_LIBRARY(SHSDK_LIBRARY ShSDK)
FIND_SHSDK_LIBRARY(SHENTRYPOINT_LIBRARY ShEntryPoint)
FIND_SHSDK_LIBRARY(STUBUSERSYSTEM_LIBRARY StubUserSystem)
FIND_SHSDK_LIBRARY(SHSDK_EDITOR_LIBRARY ShSDK_Editor)

# ------------------------------------------------------------------------------------------------

set(SHSDK_LIBRARIES "${SHSDK_LIBRARY}")
set(SHSDK_EDITOR_LIBRARIES "${SHSDK_EDITOR_LIBRARY}")
set(SHSDK_INCLUDE_DIRS "${SHSDK_INCLUDE_DIR}")

if (ANDROID)

	# TODO

elseif (APPLE)

	# TODO

elseif (UNIX) # Not Android and not Apple ... must be Linux or BSD

	find_package(Threads QUIET)
	find_package(OpenGL QUIET)
	find_package(OpenAL QUIET)
	find_package(X11 QUIET)

	list(APPEND SHSDK_LIBRARIES "${OPENGL_LIBRARIES}" "${X11_LIBRARIES}" "${OPENAL_LIBRARY}" "${CMAKE_THREAD_LIBS_INIT}")

elseif (WIN32)

	find_package(DirectX9 QUIET)
	find_package(XAudio QUIET)
	find_package(XInput QUIET)

	list(APPEND SHSDK_INCLUDE_DIRS "${DirectX9_INCLUDE_DIR}")
	list(APPEND SHSDK_LIBRARIES "${DirectX9_LIBRARIES}" "${XInput_LIBRARIES}" "${XAudio_LIBRARY}")

else ()

	# TODO

	message("Platform not supported")

endif()

include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(ShSDK DEFAULT_MSG SHSDK_LIBRARIES SHSDK_EDITOR_LIBRARIES SHSDK_INCLUDE_DIRS)
