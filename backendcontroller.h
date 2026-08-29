#ifndef BACKENDCONTROLLER_H
#define BACKENDCONTROLLER_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>

class BackendController : public QObject
{
    Q_OBJECT

    // ===== MODE PROPERTY =====
    Q_PROPERTY(QString currentMode READ currentMode NOTIFY currentModeChanged)

    // ===== CSV DATA =====
    Q_PROPERTY(QVariantList tickets READ tickets NOTIFY ticketsChanged)
    Q_PROPERTY(QVariantList passengers READ passengers NOTIFY passengersChanged)

    // ===== DYNAMIC QR STRING =====
    Q_PROPERTY(QString currentQrString READ currentQrString NOTIFY currentQrStringChanged)

public:
    explicit BackendController(QObject *parent = nullptr);

    // ===== MODE =====
    QString currentMode() const;

    // ===== CSV LOADERS =====
    Q_INVOKABLE void loadTickets();
    Q_INVOKABLE void loadPassengers(int ticketId);

    // ===== QR HELPER =====
    Q_INVOKABLE QString getQrStringForTicket(int ticketIndex) const;

    QVariantList tickets() const;
    QVariantList passengers() const;
    QString currentQrString() const;

signals:
    // ===== MODE =====
    void currentModeChanged();

    // ===== DATA =====
    void ticketsChanged();
    void passengersChanged();
    void currentQrStringChanged();

private:
    // ===== MODE =====
    QString m_currentMode;   // "PRS" or "UTS"

    // ===== DATA =====
    QVariantList m_tickets;
    QVariantList m_passengers;
    QString m_currentQrString;
};

#endif
