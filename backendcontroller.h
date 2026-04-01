// #ifndef BACKENDCONTROLLER_H
// #define BACKENDCONTROLLER_H

// #include <QObject>
// #include <QVariantMap>

// class BackendController : public QObject
// {
//     Q_OBJECT

//     Q_PROPERTY(QVariantMap prsModel READ prsModel NOTIFY prsModelChanged)
//     Q_PROPERTY(QString currentMode READ currentMode NOTIFY modeChanged)

// public:
//     explicit BackendController(QObject *parent = nullptr);

//     QVariantMap prsModel() const;
//     QString currentMode() const;

//     Q_INVOKABLE void loadPRS();
//     Q_INVOKABLE void loadUTS();

// signals:
//     void prsModelChanged();
//     void modeChanged();

// private:
//     QString m_currentMode;
//     QVariantMap m_prsModel;   // 🔑 THIS WAS MISSING
// };

// #endif // BACKENDCONTROLLER_H
// #ifndef BACKENDCONTROLLER_H
// #define BACKENDCONTROLLER_H

// #include <QObject>
// #include <QVariantList>
// #include <QVariantMap>

// class BackendController : public QObject
// {
//     Q_OBJECT

//     Q_PROPERTY(QVariantList tickets READ tickets NOTIFY ticketsChanged)
//     Q_PROPERTY(QVariantList passengers READ passengers NOTIFY passengersChanged)

// public:
//     explicit BackendController(QObject *parent = nullptr);

//     Q_INVOKABLE void loadTickets();
//     Q_INVOKABLE void loadPassengers(int ticketId);

//     QVariantList tickets() const;
//     QVariantList passengers() const;

// signals:
//     void ticketsChanged();
//     void passengersChanged();

// private:
//     QVariantList m_tickets;
//     QVariantList m_passengers;
// };

// #endif
#ifndef BACKENDCONTROLLER_H
#define BACKENDCONTROLLER_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>

class BackendController : public QObject
{
    Q_OBJECT

    // ===== MODE PROPERTY (CRITICAL) =====
    Q_PROPERTY(QString currentMode READ currentMode NOTIFY currentModeChanged)

    // ===== CSV DATA =====
    Q_PROPERTY(QVariantList tickets READ tickets NOTIFY ticketsChanged)
    Q_PROPERTY(QVariantList passengers READ passengers NOTIFY passengersChanged)

public:
    explicit BackendController(QObject *parent = nullptr);

    // ===== MODE =====
    QString currentMode() const;

    // ===== CSV LOADERS =====
    Q_INVOKABLE void loadTickets();
    Q_INVOKABLE void loadPassengers(int ticketId);

    QVariantList tickets() const;
    QVariantList passengers() const;

signals:
    // ===== MODE =====
    void currentModeChanged();

    // ===== DATA =====
    void ticketsChanged();
    void passengersChanged();

private:
    // ===== MODE =====
    QString m_currentMode;   // "PRS" or "UTS"

    // ===== DATA =====
    QVariantList m_tickets;
    QVariantList m_passengers;
};

#endif
