#include "backendcontroller.h"
#include "qrservice.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

/* ================= CONSTRUCTOR ================= */

BackendController::BackendController(QObject *parent)
    : QObject(parent),
      m_currentMode("PRS"),
      m_currentQrString("upi://pay?pa=railway@upi&pn=INDIAN%20RAILWAYS&am=4680.00&tr=TXN12616&cu=INR")
{
}

/* ================= MODE ================= */

QString BackendController::currentMode() const
{
    return m_currentMode;
}

/* ================= QR STRING ================= */

QString BackendController::currentQrString() const
{
    return m_currentQrString;
}

QString BackendController::getQrStringForTicket(int ticketIndex) const
{
    if (ticketIndex >= 0 && ticketIndex < m_tickets.size()) {
        return m_tickets[ticketIndex].toMap().value("qrString").toString();
    }
    return m_currentQrString;
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
        file.setFileName("ticket_header.csv");
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            file.setFileName("C:/Users/User/Documents/Projects/TicketVendingGUI_2/ticket_header.csv");
            if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
                qDebug() << "Failed to open ticket_header.csv";
                return;
            }
        }
    }

    QTextStream in(&file);
    QStringList headers = in.readLine().split(",");

    while (!in.atEnd()) {
        QString line = in.readLine().trimmed();
        if (line.isEmpty()) continue;

        QStringList row = line.split(",");
        QVariantMap ticket;

        for (int i = 0; i < headers.size(); i++) {
            ticket[headers[i].trimmed()] = row.value(i).trimmed();
        }

        // Dynamically populate qrString if not present in CSV
        if (!ticket.contains("qrString") || ticket["qrString"].toString().isEmpty()) {
            QString amount = ticket.value("Fare").toString();
            QString trId = QString("TXN%1").arg(ticket.value("Ticket_ID").toString());
            ticket["qrString"] = QrService::generateUpiQr(amount, trId);
        }

        m_tickets.append(ticket);
    }

    file.close();

    if (!m_tickets.isEmpty()) {
        m_currentQrString = m_tickets[0].toMap().value("qrString").toString();
        emit currentQrStringChanged();
    }

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
        file.setFileName("passengers.csv");
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            file.setFileName("C:/Users/User/Documents/Projects/TicketVendingGUI_2/passengers.csv");
            if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
                qDebug() << "Failed to open passengers.csv";
                return;
            }
        }
    }

    QTextStream in(&file);
    QStringList headers = in.readLine().split(",");

    while (!in.atEnd()) {
        QString line = in.readLine().trimmed();
        if (line.isEmpty()) continue;

        QStringList row = line.split(",");
        QVariantMap passenger;

        for (int i = 0; i < headers.size(); i++) {
            passenger[headers[i].trimmed()] = row.value(i).trimmed();
        }

        if (passenger["Ticket_ID"].toInt() == ticketId) {
            m_passengers.append(passenger);
        }
    }

    file.close();
    emit passengersChanged();
}
