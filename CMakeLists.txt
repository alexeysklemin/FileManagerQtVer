# =============================================
# 1. Базовые настройки проекта
# =============================================
cmake_minimum_required(VERSION 3.21)  # Требуется для Qt 6.4+ и удобной работы с Modern CMake
project(
    MyFileManager
    VERSION 1.0.0
    DESCRIPTION "Кроссплатформенный файловый менеджер с Qt"
    LANGUAGES CXX
)

# =============================================
# 2. Настройка стандарта C++ и флагов компиляции
# =============================================
set(CMAKE_CXX_STANDARD 17)           # Qt 6 требует C++17
set(CMAKE_CXX_STANDARD_REQUIRED ON)   # Запрещает использовать более старый стандарт
set(CMAKE_AUTOMOC ON)                 # Автоматический вызов moc для Qt-классов
set(CMAKE_AUTORCC ON)                 # Автоматическая компиляция .qrc-файлов
set(CMAKE_AUTOUIC ON)                 # Автоматическая обработка .ui-файлов

# =============================================
# 3. Поиск Qt6 и зависимостей
# =============================================
find_package(Qt6 REQUIRED COMPONENTS
    Core      # Базовые классы (QString, QFile, QDir)
    Widgets   # GUI-компоненты (QMainWindow, QFileDialog)
    Network   # HTTP/FTP (QNetworkAccessManager)
    Concurrent # Для многопоточных операций (QFuture)
    Gui       # Работа с графикой (QImage, QIcon)
)

# Для архивации (QuaZip — обёртка над zlib для Qt)
find_package(ZLIB REQUIRED)
find_package(QuaZip-Qt6 REQUIRED)

# Для шифрования (используем Qt Cryptography Architecture)
find_package(QCA-qt6 REQUIRED)

# =============================================
# 4. Настройка структуры проекта
# =============================================
set(INC_DIR ${CMAKE_SOURCE_DIR}/inc)  # Путь к заголовкам
set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)  # Путь к исходникам
set(RES_DIR ${CMAKE_SOURCE_DIR}/resources)  # Ресурсы (иконки, переводы)

# =============================================
# 5. Подключение подпроектов
# =============================================
add_subdirectory(core)  # Ядро приложения (файловая система, операции)
add_subdirectory(ui)    # Интерфейс (GUI или консольный)
add_subdirectory(app)   # Главное приложение

# =============================================
# 6. Опциональные модули (плагины, тесты)
# =============================================
option(BUILD_PLUGINS "Включить поддержку плагинов" ON)
if(BUILD_PLUGINS)
    add_subdirectory(plugins)
endif()

option(BUILD_TESTS "Собирать тесты" OFF)
if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

# =============================================
# 7. Установка (если нужно собирать пакет)
# =============================================
install(TARGETS myFileManager DESTINATION bin)
install(DIRECTORY ${RES_DIR}/ DESTINATION share/myFileManager)