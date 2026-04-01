#include "qrservice.h"

QString QrService::generateUpiQr(
    const QString &amount,
    const QString &transactionId
    )
{
    // UPI QR format (Railway-style, offline)

    QString qrString =
        "upi://pay?"
        "pa=railway@upi"
        "&pn=INDIAN RAILWAYS"
        "&am=" + amount +
        "&tr=" + transactionId +
        "&cu=INR";

    return qrString;
}
