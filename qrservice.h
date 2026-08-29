#ifndef QRSERVICE_H
#define QRSERVICE_H

#include <QString>
#include <QImage>

class QrService
{
public:
    // Generates UPI QR string (offline, dynamic)
    static QString generateUpiQr(
        const QString &amount,
        const QString &transactionId
        );

    // Generates rendered QImage for a given QR string
    static QImage generateQrImage(
        const QString &qrString,
        int targetSize = 256,
        int quietZone = 2
        );
};

#endif // QRSERVICE_H
