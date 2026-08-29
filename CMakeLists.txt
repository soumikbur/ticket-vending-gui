cmake_minimum_required(VERSION 3.16)

project(TicketVendingGUI_2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appTicketVendingGUI_2
    main.cpp
    backendcontroller.cpp
    backendcontroller.h
    qrservice.cpp
    qrservice.h
    qrcodeitem.cpp
    qrcodeitem.h
    qrcodegen.cpp
    qrcodegen.hpp
    ticketdata.h
    resources.qrc
)

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
        qrcodeitem.h
        qrcodeitem.cpp
        qrcodegen.hpp
        qrcodegen.cpp
        ticketdata.h
)

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
