#ifndef QRCODEITEM_H
#define QRCODEITEM_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <QString>

class QRCodeItem : public QQuickPaintedItem
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString qrText READ qrText WRITE setQrText NOTIFY qrTextChanged)
    Q_PROPERTY(int quietZone READ quietZone WRITE setQuietZone NOTIFY quietZoneChanged)

public:
    explicit QRCodeItem(QQuickItem *parent = nullptr);

    QString qrText() const { return m_qrText; }
    void setQrText(const QString &text);

    int quietZone() const { return m_quietZone; }
    void setQuietZone(int zone);

    void paint(QPainter *painter) override;

signals:
    void qrTextChanged();
    void quietZoneChanged();

private:
    QString m_qrText;
    int m_quietZone;
};

#endif // QRCODEITEM_H
