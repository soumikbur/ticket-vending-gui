import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: app
    visible: true
    width: 439
    height: 326
    minimumWidth: 439
    minimumHeight: 326
    title: "Ticket Information - Indian Railways (QFRDS)"
    color: "#2B2B2B"

    Component.onCompleted: {
        console.log("🚀 QFRDS started → initializing display")
        if (typeof Backend !== "undefined" && Backend) {
            Backend.loadTickets()
        }
        timerGrab.start()
    }

    Timer {
        id: timerGrab
        interval: 1000
        repeat: false
        onTriggered: {
            scaledCanvas.grabToImage(function(result) {
                var savePath = "C:/Users/User/.gemini/antigravity-ide/brain/0b15a71f-0c66-44aa-8bf4-20cf95aef61f/qt_rendered_kiosk.png";
                result.saveToFile(savePath);
                console.log("✅ Saved native Qt QML render to: " + savePath);
            });
        }
    }

    Item {
        id: rootContainer
        anchors.fill: parent

        readonly property real designWidth: 439
        readonly property real designHeight: 326
        readonly property real scaleFactor: Math.min(width / designWidth, height / designHeight)

        Item {
            id: scaledCanvas
            width: rootContainer.designWidth
            height: rootContainer.designHeight
            scale: rootContainer.scaleFactor
            anchors.centerIn: parent

            Loader {
                id: screenLoader
                anchors.fill: parent
                source: (typeof Backend !== "undefined" && Backend && Backend.currentMode === "UTS")
                        ? "UTSDisplay.qml"
                        : "PRSDisplay_responsive.qml"
            }
        }
    }
}
