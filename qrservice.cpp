#include "qrservice.h"
#include "qrcodegen.hpp"
#include <QPainter>
#include <algorithm>

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

QImage QrService::generateQrImage(
    const QString &qrString,
    int targetSize,
    int quietZone
    )
{
    if (targetSize < 16) targetSize = 256;
    if (quietZone < 0) quietZone = 2;

    QImage img(targetSize, targetSize, QImage::Format_RGB32);
    img.fill(Qt::white);

    if (qrString.trimmed().isEmpty()) {
        return img;
    }

    try {
        qrcodegen::QrCode qr = qrcodegen::QrCode::encodeText(
            qrString.toUtf8().constData(),
            qrcodegen::QrCode::Ecc::MEDIUM
        );

        int qrModules = qr.getSize();
        int totalModules = qrModules + 2 * quietZone;
        if (totalModules <= 0) return img;

        int modulePx = targetSize / totalModules;
        if (modulePx < 1) modulePx = 1;

        int drawnSize = modulePx * totalModules;
        int offsetX = (targetSize - drawnSize) / 2;
        int offsetY = (targetSize - drawnSize) / 2;

        QPainter painter(&img);
        painter.setRenderHint(QPainter::Antialiasing, false);
        painter.setPen(Qt::NoPen);
        painter.setBrush(Qt::black);

        for (int y = 0; y < qrModules; ++y) {
            for (int x = 0; x < qrModules; ++x) {
                if (qr.getModule(x, y)) {
                    painter.drawRect(
                        offsetX + (x + quietZone) * modulePx,
                        offsetY + (y + quietZone) * modulePx,
                        modulePx,
                        modulePx
                    );
                }
            }
        }
    } catch (...) {
        // Return blank white image on error
    }

    return img;
}
