#include "qrcodeitem.h"
#include "qrcodegen.hpp"
#include <algorithm>

QRCodeItem::QRCodeItem(QQuickItem *parent)
    : QQuickPaintedItem(parent),
      m_quietZone(2)
{
    setOpaquePainting(true);
}

void QRCodeItem::setQrText(const QString &text)
{
    if (m_qrText != text) {
        m_qrText = text;
        emit qrTextChanged();
        update();
    }
}

void QRCodeItem::setQuietZone(int zone)
{
    if (zone < 0) zone = 0;
    if (m_quietZone != zone) {
        m_quietZone = zone;
        emit quietZoneChanged();
        update();
    }
}

void QRCodeItem::paint(QPainter *painter)
{
    if (!painter) return;

    // Clean white background
    painter->fillRect(boundingRect(), Qt::white);

    if (m_qrText.trimmed().isEmpty()) {
        return;
    }

    try {
        qrcodegen::QrCode qr = qrcodegen::QrCode::encodeText(
            m_qrText.toUtf8().constData(),
            qrcodegen::QrCode::Ecc::MEDIUM
        );

        int qrModules = qr.getSize();
        int totalModules = qrModules + 2 * m_quietZone;
        if (totalModules <= 0) return;

        qreal availableSize = std::min(width(), height());
        // Integer module size for sharp, non-interpolated module boundaries
        int modulePx = static_cast<int>(availableSize / totalModules);
        if (modulePx < 1) modulePx = 1;

        int drawnSize = modulePx * totalModules;
        qreal offsetX = (width() - drawnSize) / 2.0;
        qreal offsetY = (height() - drawnSize) / 2.0;

        painter->setRenderHint(QPainter::Antialiasing, false);
        painter->setPen(Qt::NoPen);
        painter->setBrush(Qt::black);

        for (int y = 0; y < qrModules; ++y) {
            for (int x = 0; x < qrModules; ++x) {
                if (qr.getModule(x, y)) {
                    painter->drawRect(QRectF(
                        offsetX + (x + m_quietZone) * modulePx,
                        offsetY + (y + m_quietZone) * modulePx,
                        modulePx,
                        modulePx
                    ));
                }
            }
        }
    } catch (...) {
        // If encoding fails, keep white background
    }
}
