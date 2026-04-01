#ifndef TICKETDATA_H
#define TICKETDATA_H

#include <QString>
#include <QVariantList>
struct Passenger
{
    QString name;
    QString sex;
    QString age;
    QString status;
};



struct TicketData
{
    // Mode: "PRS" or "UTS"
    QString mode;

    // Station details
    QString from;
    QString to;

    // PRS-specific fields
    QString trainNo;
    QString quota;
    QString doj;            // Date of Journey
    QString classCode;

    // Common fields
    QString passengerCount;
    QString totalFare;
    QString operatorName;
    QString paymentMode;

    // QR / payment
    QString qrString;

    // Passenger list (for PRS)
    QVariantList passengerList;
};

#endif // TICKETDATA_H
