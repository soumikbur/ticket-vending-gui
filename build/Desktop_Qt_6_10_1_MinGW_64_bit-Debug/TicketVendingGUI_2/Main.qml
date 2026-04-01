import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: app
    visible: true
    width: 900
    height: 650
    title: "Ticket Vending GUI"

    Component.onCompleted: {
        console.log("🚀 App started → loading tickets")
        Backend.loadTickets()
    }

    Loader {
        id: screenLoader
        anchors.fill: parent
        source: "PRSDisplay_responsive.qml"
    }
}
