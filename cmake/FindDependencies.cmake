# Поиск дополнительных библиотек
find_package(Qt6 COMPONENTS Core Widgets Network Concurrent Gui REQUIRED)

# Для архивации
find_package(ZLIB REQUIRED)
if(NOT TARGET QuaZip::QuaZip)
    find_package(QuaZip-Qt6 REQUIRED)
endif()

# Для шифрования
find_package(QCA-qt6 REQUIRED)

# Для псевдографического интерфейса
if(BUILD_CONSOLE_UI)
    find_package(Curses QUIET)
    if(NOT Curses_FOUND)
        message(WARNING "Curses library not found - console UI will be limited")
    endif()
endif()