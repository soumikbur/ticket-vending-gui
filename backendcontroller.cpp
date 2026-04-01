// #include "backendcontroller.h"
// #include <QDebug>

// BackendController::BackendController(QObject *parent)
//     : QObject(parent),
//     m_currentMode("PRS")
// {
//     // ❌ DO NOT load data here
//     // QML is not ready yet
// }

// QString BackendController::currentMode() const
// {
//     return m_currentMode;
// }

// QVariantMap BackendController::prsModel() const
// {
//     return m_prsModel;
// }

// void BackendController::loadPRS()
// {
//     qDebug() << "loadPRS called";

//     m_currentMode = "PRS";

//     m_prsModel.clear();
//     m_prsModel["mode"] = "PRS";
//     m_prsModel["from"] = "NDLS";
//     m_prsModel["to"] = "MAS";
//     m_prsModel["trainNo"] = "12616";
//     m_prsModel["quota"] = "GN";
//     m_prsModel["doj"] = "14/07";
//     m_prsModel["classCode"] = "SL";
//     m_prsModel["passengerCount"] = "06";
//     m_prsModel["totalFare"] = "4680.00";
//     m_prsModel["operatorName"] = "Amit Kumar";
//     m_prsModel["paymentMode"] = "UPI-QR CODE";
//     m_prsModel["qrString"] = "upi://pay?pa=railway@upi&am=4680";

//     QVariantList passengers;

//     QVariantMap p1;
//     p1["name"] = "Soumik";
//     p1["sex"] = "M";
//     p1["age"] = "23";
//     p1["status"] = "S4 - 66";
//     passengers.append(p1);

//     QVariantMap p2;
//     p2["name"] = "Moumita";
//     p2["sex"] = "F";
//     p2["age"] = "34";
//     p2["status"] = "S4 - 67";
//     passengers.append(p2);

//     m_prsModel["passengerList"] = passengers;

//     emit prsModelChanged();
//     emit modeChanged();
// }

// void BackendController::loadUTS()
// {
//     qDebug() << "loadUTS called";

//     m_currentMode = "UTS";

//     m_prsModel.clear();
//     m_prsModel["mode"] = "UTS";
//     m_prsModel["from"] = "NDLS";
//     m_prsModel["to"] = "GZB";
//     m_prsModel["passengerCount"] = "02";
//     m_prsModel["totalFare"] = "120.00";
//     m_prsModel["paymentMode"] = "UPI-QR CODE";
//     m_prsModel["qrString"] = "upi://pay?pa=railway@upi&am=120";
//     m_prsModel["passengerList"] = QVariantList();

//     emit prsModelChanged();
//     emit modeChanged();
// }
// #include "backendcontroller.h"
// #include <QFile>
// #include <QTextStream>
// #include <QDebug>

// BackendController::BackendController(QObject *parent)
//     : QObject(parent)
// {
// }

// /* ---------------- TICKETS ---------------- */

// QVariantList BackendController::tickets() const
// {
//     return m_tickets;
// }

// void BackendController::loadTickets()
// {
//     m_tickets.clear();

//     QFile file(":/data/ticket_header.csv");
//     if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
//         qDebug() << "Failed to open ticket_header.csv";
//         return;
//     }

//     QTextStream in(&file);
//     QStringList headers = in.readLine().split(",");

//     while (!in.atEnd()) {
//         QStringList row = in.readLine().split(",");
//         QVariantMap ticket;

//         for (int i = 0; i < headers.size(); i++) {
//             ticket[headers[i]] = row.value(i);
//         }

//         m_tickets.append(ticket);
//     }

//     file.close();
//     emit ticketsChanged();
// }

// /* ---------------- PASSENGERS ---------------- */

// QVariantList BackendController::passengers() const
// {
//     return m_passengers;
// }

// void BackendController::loadPassengers(int ticketId)
// {
//     m_passengers.clear();

//     QFile file(":/data/passengers.csv");
//     if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
//         qDebug() << "Failed to open passengers.csv";
//         return;
//     }

//     QTextStream in(&file);
//     QStringList headers = in.readLine().split(",");

//     while (!in.atEnd()) {
//         QStringList row = in.readLine().split(",");
//         QVariantMap passenger;

//         for (int i = 0; i < headers.size(); i++) {
//             passenger[headers[i]] = row.value(i);
//         }

//         if (passenger["Ticket_ID"].toInt() == ticketId) {
//             m_passengers.append(passenger);
//         }
//     }

//     file.close();
//     emit passengersChanged();
// }
#include "backendcontroller.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

/* ================= CONSTRUCTOR ================= */

BackendController::BackendController(QObject *parent)
    : QObject(parent),
    m_currentMode("PRS")
{
}

/* ================= MODE ================= */

QString BackendController::currentMode() const
{
    return m_currentMode;
}

/* ================= TICKETS ================= */

QVariantList BackendController::tickets() const
{
    return m_tickets;
}

void BackendController::loadTickets()
{
    m_tickets.clear();


    if (m_currentMode != "PRS") {
        m_currentMode = "PRS";
        emit currentModeChanged();
    }

    QFile file(":/data/ticket_header.csv");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open ticket_header.csv";
        return;
    }

    QTextStream in(&file);
    QStringList headers = in.readLine().split(",");

    while (!in.atEnd()) {
        QStringList row = in.readLine().split(",");
        QVariantMap ticket;

        for (int i = 0; i < headers.size(); i++) {
            ticket[headers[i]] = row.value(i);
        }

        m_tickets.append(ticket);
    }

    file.close();
    emit ticketsChanged();
}

/* ================= PASSENGERS ================= */

QVariantList BackendController::passengers() const
{
    return m_passengers;
}

void BackendController::loadPassengers(int ticketId)
{
    m_passengers.clear();

    QFile file(":/data/passengers.csv");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open passengers.csv";
        return;
    }

    QTextStream in(&file);
    QStringList headers = in.readLine().split(",");

    while (!in.atEnd()) {
        QStringList row = in.readLine().split(",");
        QVariantMap passenger;

        for (int i = 0; i < headers.size(); i++) {
            passenger[headers[i]] = row.value(i);
        }

        if (passenger["Ticket_ID"].toInt() == ticketId) {
            m_passengers.append(passenger);
        }
    }

    file.close();
    emit passengersChanged();
}
