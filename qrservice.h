#ifndef QRSERVICE_H
#define QRSERVICE_H

#include <QString>

class QrService
{
public:
    // Generates UPI QR string (offline, dynamic)
    static QString generateUpiQr(
        const QString &amount,
        const QString &transactionId
        );
};

#endif // QRSERVICE_H
