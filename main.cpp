#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "backendcontroller.h"
#include "qrcodeitem.h"

#include <QFile>
#include <QTextStream>
#include <QDateTime>

void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QFile logFile("debug_log.txt");
    if (logFile.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)) {
        QTextStream stream(&logFile);
        stream << QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss.zzz ")
               << msg << "\n";
    }
}

int main(int argc, char *argv[])
{
    qInstallMessageHandler(myMessageOutput);
    QGuiApplication app(argc, argv);

    qmlRegisterType<QRCodeItem>("TicketVendingGUI_2", 1, 0, "QRCodeItem");

    BackendController backend;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Backend", &backend);

    engine.loadFromModule("TicketVendingGUI_2", "Main");

    if (engine.rootObjects().isEmpty()) {
        qCritical("engine.rootObjects() is EMPTY!");
        return -1;
    }

    return app.exec();
}
