# Настройки компиляции для разных платформ
if(WIN32)
    add_compile_definitions(OS_WINDOWS)
    set(PLATFORM_LIBS "")
elseif(UNIX AND NOT APPLE)
    add_compile_definitions(OS_LINUX)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(GTKMM REQUIRED gtkmm-3.0)
    set(PLATFORM_LIBS ${GTKMM_LIBRARIES})
endif()

# Общие флаги компиляции
if(MSVC)
    add_compile_options(/W4 /WX)
else()
    add_compile_options(-Wall -Wextra -Werror -pedantic)
endif()

# Настройки для релиза/дебага
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)