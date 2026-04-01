cmake_minimum_required(VERSION 3.16)

project(TicketVendingGUI_2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

# 🔧 STEP 2: Add resources.qrc directly to the executable
qt_add_executable(appTicketVendingGUI_2
    main.cpp
    backendcontroller.cpp
    backendcontroller.h
    qrservice.cpp
    qrservice.h
    ticketdata.h
    resources.qrc     # ✅ ADDED: CSV files now accessible to C++
)

# 🔧 STEP 1: Remove RESOURCES from qt_add_qml_module
qt_add_qml_module(appTicketVendingGUI_2
    URI TicketVendingGUI_2
    VERSION 1.0
    QML_FILES
        Main.qml
        UTSDisplay.qml
        PRSDisplay_responsive.qml
    SOURCES
        backendcontroller.h
        backendcontroller.cpp
        qrservice.h
        qrservice.cpp
        ticketdata.h
    # ❌ REMOVED: RESOURCES resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTicketVendingGUI_2 PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTicketVendingGUI_2
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appTicketVendingGUI_2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
