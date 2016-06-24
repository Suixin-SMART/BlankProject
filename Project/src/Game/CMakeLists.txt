include_directories(${SHSDK_INCLUDE_DIRS} "../Plugins")

set(SOURCES_GAME Game.cpp Game.h)
source_group("" FILES ${SOURCES_GAME})

set(TARGET_NAME "Game")
	
add_executable(${TARGET_NAME} WIN32 ${SOURCES_GAME})
set_property(TARGET ${TARGET_NAME} APPEND PROPERTY COMPILE_DEFINITIONS "${SHSDK_COMPILE_DEFINITIONS}")
set_property(TARGET ${TARGET_NAME} APPEND PROPERTY COMPILE_FLAGS "${SHSDK_COMPILE_FLAGS}")

target_link_libraries(${TARGET_NAME} Plugin) # link with plugins

target_link_libraries(${TARGET_NAME} ${SHSDK_LIBRARIES} ${SHENTRYPOINT_LIBRARY} ${STUBUSERSYSTEM_LIBRARY})

CopyToShineSAAS(${TARGET_NAME})
