import QtQuick 2.15
import QtQuick.Controls 2.15
import TicketVendingGUI_2 1.0

Item {
    id: root
    width: 439
    height: 326

    readonly property color cMaroon: "#400000"
    readonly property color cFareBg: "#410000"
    readonly property color cBlack:  "#000000"
    readonly property color cWhite:  "#FFFFFF"
    readonly property color cBorder: "#C0C0C0"

    Rectangle {
        anchors.fill: parent
        color: cWhite
        border.color: cBorder
        border.width: 3

        // HEADER
        Rectangle {
            x: 3; y: 3; width: 433; height: 45; color: cWhite
            Row {
                x: 6; anchors.verticalCenter: parent.verticalCenter; spacing: 14
                Column {
                    spacing: 1
                    Text { text: "Terminal ID"; font.pixelSize: 8; font.bold: true; color: root.cMaroon }
                    Rectangle { width: 44; height: 1; color: root.cMaroon }
                    Text { text: "-------"; font.pixelSize: 9; font.bold: true; color: root.cBlack }
                }
                Column {
                    spacing: 1
                    Text { text: "Windows No."; font.pixelSize: 8; font.bold: true; color: root.cMaroon }
                    Rectangle { width: 44; height: 1; color: root.cMaroon }
                    Text { text: "--"; font.pixelSize: 9; font.bold: true; color: root.cBlack }
                }
            }

            Text {
                anchors.centerIn: parent
                text: "Ticket Information"
                font.family: "Georgia"
                font.pixelSize: 30
                font.bold: true
                color: root.cMaroon
            }

            Image {
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 44; height: 44
                source: "qrc:/railway_logo.png"
                fillMode: Image.PreserveAspectFit
            }
            Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 3; color: root.cBorder }
        }

        // ROW 1: From / To
        Rectangle {
            x: 3; y: 51; width: 433; height: 38; color: root.cBorder
            Rectangle {
                x: 0; y: 0; width: 48; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "From"; font.pixelSize: 14; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "कहाँ से"; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }
            Rectangle {
                x: 51; y: 0; width: 158; height: 38; color: root.cBlack
                Text { anchors.left: parent.left; anchors.leftMargin: 8; anchors.verticalCenter: parent.verticalCenter; text: "NDLS"; font.pixelSize: 24; font.bold: true; color: root.cWhite }
            }
            Rectangle {
                x: 212; y: 0; width: 55; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "To"; font.pixelSize: 14; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "कहाँ तक"; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }
            Rectangle {
                x: 270; y: 0; width: 163; height: 38; color: root.cBlack
                Text { anchors.left: parent.left; anchors.leftMargin: 8; anchors.verticalCenter: parent.verticalCenter; text: "GZB"; font.pixelSize: 24; font.bold: true; color: root.cWhite }
            }
        }
        Rectangle { x: 3; y: 89; width: 433; height: 3; color: root.cBorder }

        // ROW 2: Date / Adult / Child / Class / Fare
        Rectangle {
            x: 3; y: 92; width: 433; height: 38; color: root.cBorder
            Rectangle {
                x: 0; y: 0; width: 48; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Date"; font.pixelSize: 13; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "दिनांक"; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }
            Rectangle {
                x: 51; y: 0; width: 72; height: 38; color: root.cBlack
                Text { anchors.centerIn: parent; text: "--/--/----"; font.pixelSize: 16; font.bold: true; color: root.cWhite }
            }
            Rectangle {
                x: 126; y: 0; width: 44; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Adult"; font.pixelSize: 10; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Child"; font.pixelSize: 10; font.bold: true; color: root.cMaroon }
                }
            }
            Rectangle {
                x: 173; y: 0; width: 36; height: 38; color: root.cBlack
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "--"; font.pixelSize: 12; font.bold: true; color: root.cWhite }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "--"; font.pixelSize: 12; font.bold: true; color: root.cWhite }
                }
            }
            Rectangle {
                x: 212; y: 0; width: 55; height: 38; color: root.cBlack
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Class"; font.pixelSize: 10; font.bold: true; color: root.cWhite }
                    Rectangle { width: 44; height: 1; color: root.cWhite }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "--"; font.pixelSize: 14; font.bold: true; color: root.cWhite }
                }
            }
            Rectangle {
                x: 270; y: 0; width: 58; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Fare"; font.pixelSize: 13; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "किराया"; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }
            Rectangle {
                x: 331; y: 0; width: 102; height: 38; color: root.cFareBg
                Text { anchors.centerIn: parent; text: "**.**"; font.pixelSize: 27; font.bold: true; color: root.cWhite }
            }
        }
        Rectangle { x: 3; y: 130; width: 433; height: 3; color: root.cBorder }

        // ROW 3: Type of Train / Pay Mode / QR Code (spanning)
        Rectangle {
            x: 3; y: 133; width: 433; height: 153; color: root.cBorder
            Item {
                x: 0; y: 0; width: 328; height: 153
                // Train Type Row (h: 56)
                Rectangle {
                    x: 0; y: 0; width: 328; height: 56; color: root.cBorder
                    Rectangle {
                        x: 0; y: 0; width: 76; height: 56; color: root.cWhite
                        Column {
                            anchors.centerIn: parent
                            Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Type of Train"; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                            Text { anchors.horizontalCenter: parent.horizontalCenter; text: "ट्रेन का प्रकार"; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                        }
                    }
                    Rectangle {
                        x: 79; y: 0; width: 92; height: 56; color: root.cBlack
                        Text { anchors.centerIn: parent; text: "Ordinary"; font.pixelSize: 16; font.bold: true; color: root.cWhite }
                    }
                    Rectangle {
                        x: 174; y: 0; width: 63; height: 56; color: root.cWhite
                        Text { anchors.centerIn: parent; text: "Pay Mode"; font.pixelSize: 12; font.bold: true; color: root.cMaroon }
                    }
                    Rectangle {
                        x: 240; y: 0; width: 88; height: 56; color: root.cBlack
                        Text { anchors.centerIn: parent; text: "UPI-QR"; font.pixelSize: 14; font.bold: true; color: root.cWhite }
                    }
                }
                Rectangle { x: 0; y: 56; width: 328; height: 3; color: root.cBorder }

                // Transaction Type Row (h: 56)
                Rectangle {
                    x: 0; y: 59; width: 328; height: 94; color: root.cBorder
                    Rectangle {
                        x: 0; y: 0; width: 76; height: 94; color: root.cWhite
                        Text { anchors.centerIn: parent; text: "Transaction\nType"; font.pixelSize: 12; font.bold: true; color: root.cMaroon; horizontalAlignment: Text.AlignHCenter }
                    }
                    Rectangle {
                        x: 79; y: 0; width: 92; height: 94; color: root.cBlack
                        Text { anchors.centerIn: parent; text: "Journey Ticket"; font.pixelSize: 14; font.bold: true; color: root.cWhite }
                    }
                    Rectangle {
                        x: 174; y: 0; width: 154; height: 94; color: root.cBlack
                    }
                }
            }

            Rectangle { x: 328; y: 0; width: 3; height: 153; color: root.cBorder }

            // QR Code Container
            Rectangle {
                x: 331; y: 0; width: 102; height: 153; color: root.cWhite
                clip: true
                QRCodeItem {
                    anchors.fill: parent
                    anchors.margins: 4
                    qrText: (typeof Backend !== "undefined" && Backend && Backend.currentQrString)
                        ? Backend.currentQrString
                        : "upi://pay?pa=railway@upi&pn=INDIAN%20RAILWAYS&am=120.00&tr=TXNUTS01&cu=INR"
                    quietZone: 2
                }
            }
        }
        Rectangle { x: 3; y: 286; width: 433; height: 3; color: root.cBorder }

        // ROW 4: Footer
        Rectangle {
            x: 3; y: 289; width: 433; height: 34; color: root.cBorder
            Rectangle {
                x: 0; y: 0; width: 76; height: 34; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Operator"; font.pixelSize: 12; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Name"; font.pixelSize: 12; font.bold: true; color: root.cMaroon }
                }
            }
            Rectangle {
                x: 79; y: 0; width: 249; height: 34; color: root.cBlack
                Text { anchors.left: parent.left; anchors.leftMargin: 8; anchors.verticalCenter: parent.verticalCenter; text: "Operator 1"; font.pixelSize: 18; font.bold: true; color: root.cWhite }
            }
            Rectangle {
                x: 331; y: 0; width: 102; height: 34; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "North Eastern Railway"; font.pixelSize: 9; font.bold: true; color: root.cBlack }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "वाराणसी मंडल"; font.pixelSize: 11; font.bold: true; color: root.cBlack }
                }
            }
        }
    }
}
