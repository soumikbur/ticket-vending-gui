// #include <QGuiApplication>
// #include <QQmlApplicationEngine>
// #include <QQmlContext>

// #include "backendcontroller.h"
// int main(int argc, char *argv[])
// {
//     QGuiApplication app(argc, argv);
//     QQmlApplicationEngine engine;
//     BackendController backend;
//     engine.rootContext()->setContextProperty("Backend", &backend);
//     // engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));
//     engine.loadFromModule("TicketVendingGUI_2", "Main");
//     if (engine.rootObjects().isEmpty())
//         return -1;
//     return app.exec();
// }
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "backendcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    BackendController backend;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Backend", &backend);

    // ✅ CORRECT way for qt_add_qml_module
    engine.loadFromModule("TicketVendingGUI_2", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

