import QtQuick 2.15
import QtQuick.Controls 2.15
import TicketVendingGUI_2 1.0

Item {
    id: root
    width: 439
    height: 326

    // ── DATA SOURCES & FALLBACK SPECIMENS ──
    property var activeTicket: (typeof Backend !== "undefined" && Backend && Backend.tickets && Backend.tickets.length > 0) ? Backend.tickets[0] : null

    // Default specimen values matching the reference specification
    readonly property string valFrom:       (activeTicket && activeTicket.From) ? activeTicket.From : "NDLS"
    readonly property string valTo:         (activeTicket && activeTicket.To) ? activeTicket.To : "MAS"
    readonly property string valTrainNo:    (activeTicket && activeTicket.Train_No) ? activeTicket.Train_No : "12616"
    readonly property string valQuota:      (activeTicket && activeTicket.Quota) ? activeTicket.Quota : "GN"
    readonly property string valDate:       (activeTicket && activeTicket.Date) ? activeTicket.Date : "14 / 07"
    readonly property string valTotalPass:  (activeTicket && activeTicket.Total_Passengers) ? String(activeTicket.Total_Passengers).padStart(2, '0') : "06"
    readonly property string valClass:      (activeTicket && activeTicket.Class) ? activeTicket.Class : "SL"
    readonly property string valFare:       (activeTicket && activeTicket.Fare) ? (Number(activeTicket.Fare).toFixed(2)) : "4680.00"
    readonly property string valBoarding:   (activeTicket && activeTicket.Boarding_Point) ? activeTicket.Boarding_Point : "NDLS"
    readonly property string valResvUpto:   (activeTicket && activeTicket.Reservation_Upto) ? activeTicket.Reservation_Upto : "MAS"
    readonly property string valPaymentMode:(activeTicket && activeTicket.Payment_Mode) ? activeTicket.Payment_Mode : "UPI-QR CODE"
    readonly property string valOperator:   (activeTicket && activeTicket.Operator_Name) ? activeTicket.Operator_Name : "Amit Kumar"

    readonly property string valQrString: (activeTicket && activeTicket.qrString)
        ? activeTicket.qrString
        : (typeof Backend !== "undefined" && Backend && Backend.currentQrString)
            ? Backend.currentQrString
            : "upi://pay?pa=railway@upi&pn=INDIAN%20RAILWAYS&am=4680.00&tr=TXN12616&cu=INR"

    // Passenger Roster (Exact reference specimen)
    readonly property var defaultPassengers: [
        { name: "Ravi",     sex: "M", age: "23", status: "S4 - 66" },
        { name: "AmitK",    sex: "F", age: "34", status: "S4 - 65" },
        { name: "TARAN",    sex: "M", age: "33", status: "S4 - 67" },
        { name: "Neeraj",   sex: "M", age: "22", status: "S4 - 68" },
        { name: "Sangeeta", sex: "M", age: "34", status: "S4 - 69" },
        { name: "Kshitiz",  sex: "M", age: "23", status: "S4 - 70" }
    ]
    readonly property var passengerList: (typeof Backend !== "undefined" && Backend && Backend.passengers && Backend.passengers.length > 0) ? Backend.passengers : defaultPassengers

    // ── COLOR SYSTEM ──
    readonly property color cMaroon: "#400000"
    readonly property color cFareBg: "#410000"
    readonly property color cBlack:  "#000000"
    readonly property color cWhite:  "#FFFFFF"
    readonly property color cBorder: "#C0C0C0"

    // ── FONT CONSTANTS ──
    readonly property string fSerif: "Times New Roman"
    readonly property string fCond:  "Arial"
    readonly property string fHindi: "Nirmala UI"

    // ── MASTER KIOSK CONTAINER ──
    Rectangle {
        id: canvas
        anchors.fill: parent
        color: cWhite
        border.color: cBorder
        border.width: 3

        // ══════════════════════════════════════════════════════
        // 1. HEADER (y: 3 to 48, Height: 45px)
        // ══════════════════════════════════════════════════════
        Rectangle {
            id: headerBox
            x: 3
            y: 3
            width: 433
            height: 45
            color: cWhite

            // "Ticket Information" Title
            Text {
                id: headerTitle
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.verticalCenter: parent.verticalCenter
                text: "Ticket Information"
                font.family: "Georgia"
                font.pixelSize: 28
                font.bold: true
                color: root.cMaroon
            }

            // Operator Code / CLIENT
            Column {
                id: operatorCol
                anchors.right: emblemImg.left
                anchors.rightMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                spacing: 1

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Operator Code"
                    font.family: "Arial"
                    font.pixelSize: 8
                    font.bold: true
                    color: root.cMaroon
                }
                Rectangle {
                    width: 52
                    height: 1
                    color: root.cMaroon
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "CLIENT"
                    font.family: root.fCond
                    font.pixelSize: 10
                    font.bold: true
                    color: root.cBlack
                }
            }

            // Official Indian Railways Logo
            Image {
                id: emblemImg
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 40
                height: 40
                source: "qrc:/railway_logo.png"
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            // Bottom Divider
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 3
                color: root.cBorder
            }
        }

        // ══════════════════════════════════════════════════════
        // 2. ROW 1: FROM / TO (y: 51 to 89, Height: 38px)
        // ══════════════════════════════════════════════════════
        Rectangle {
            id: row1
            x: 3
            y: 51
            width: 433
            height: 38
            color: root.cBorder

            // From Label (w: 48)
            Rectangle {
                x: 0; y: 0; width: 48; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "From"; font.family: root.fSerif; font.pixelSize: 14; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "कहाँ से"; font.family: root.fHindi; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }

            // From Value (NDLS, w: 158)
            Rectangle {
                x: 51; y: 0; width: 158; height: 38; color: root.cBlack
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.valFrom
                    font.family: root.fCond
                    font.pixelSize: 26
                    font.bold: true
                    color: root.cWhite
                }
            }

            // To Label (w: 55)
            Rectangle {
                x: 212; y: 0; width: 55; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "To"; font.family: root.fSerif; font.pixelSize: 14; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "कहाँ तक"; font.family: root.fHindi; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }

            // To Value (MAS, w: 163)
            Rectangle {
                x: 270; y: 0; width: 163; height: 38; color: root.cBlack
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.valTo
                    font.family: root.fCond
                    font.pixelSize: 26
                    font.bold: true
                    color: root.cWhite
                }
            }
        }

        // Horizontal Divider 1
        Rectangle { x: 3; y: 89; width: 433; height: 3; color: root.cBorder }

        // ══════════════════════════════════════════════════════
        // 3. ROW 2: TRAIN NO / QUOTA (y: 92 to 130, Height: 38px)
        // ══════════════════════════════════════════════════════
        Rectangle {
            id: row2
            x: 3
            y: 92
            width: 433
            height: 38
            color: root.cBorder

            // Train No Label (w: 48)
            Rectangle {
                x: 0; y: 0; width: 48; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Train No."; font.family: root.fSerif; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "गाड़ी सं."; font.family: root.fHindi; font.pixelSize: 10; font.bold: true; color: root.cMaroon }
                }
            }

            // Train No Value (12616, w: 158)
            Rectangle {
                x: 51; y: 0; width: 158; height: 38; color: root.cBlack
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.valTrainNo
                    font.family: root.fCond
                    font.pixelSize: 26
                    font.bold: true
                    color: root.cWhite
                }
            }

            // Quota Label (w: 55)
            Rectangle {
                x: 212; y: 0; width: 55; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Quota"; font.family: root.fSerif; font.pixelSize: 13; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "कोटा"; font.family: root.fHindi; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }

            // Quota Value (GN, w: 163)
            Rectangle {
                x: 270; y: 0; width: 163; height: 38; color: root.cBlack
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.valQuota
                    font.family: root.fCond
                    font.pixelSize: 26
                    font.bold: true
                    color: root.cWhite
                }
            }
        }

        // Horizontal Divider 2
        Rectangle { x: 3; y: 130; width: 433; height: 3; color: root.cBorder }

        // ══════════════════════════════════════════════════════
        // 4. ROW 3: DATE / TOTAL PASSENGERS / CLASS / FARE (y: 133 to 171, Height: 38px)
        // ══════════════════════════════════════════════════════
        Rectangle {
            id: row3
            x: 3
            y: 133
            width: 433
            height: 38
            color: root.cBorder

            // Date Label (w: 48)
            Rectangle {
                x: 0; y: 0; width: 48; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Date"; font.family: root.fSerif; font.pixelSize: 13; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "दिनांक"; font.family: root.fHindi; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }

            // Date Value (14 / 07, w: 78, Centered & Non-cramped)
            Rectangle {
                id: dateBox
                x: 51; y: 0; width: 78; height: 38; color: root.cBlack
                clip: true

                Text {
                    anchors.fill: parent
                    anchors.leftMargin: 2
                    anchors.rightMargin: 2
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: root.valDate
                    font.family: root.fCond
                    font.pixelSize: 20
                    font.bold: true
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 14
                    color: root.cWhite
                }
            }

            // Total Passangers (w: 77)
            Rectangle {
                x: 132; y: 0; width: 77; height: 38; color: root.cBlack
                Column {
                    anchors.centerIn: parent
                    spacing: 1
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Total Passangers"; font.family: root.fSerif; font.pixelSize: 8; font.bold: true; color: root.cWhite }
                    Rectangle { width: 68; height: 1; color: root.cWhite; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: root.valTotalPass; font.family: root.fCond; font.pixelSize: 18; font.bold: true; color: root.cWhite }
                }
            }

            // Class (w: 55)
            Rectangle {
                x: 212; y: 0; width: 55; height: 38; color: root.cBlack
                Column {
                    anchors.centerIn: parent
                    spacing: 1
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Class"; font.family: root.fSerif; font.pixelSize: 10; font.bold: true; color: root.cWhite }
                    Rectangle { width: 44; height: 1; color: root.cWhite; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: root.valClass; font.family: root.fCond; font.pixelSize: 18; font.bold: true; color: root.cWhite }
                }
            }

            // Fare Label (w: 58)
            Rectangle {
                x: 270; y: 0; width: 58; height: 38; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Fare"; font.family: root.fSerif; font.pixelSize: 13; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "किराया"; font.family: root.fHindi; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                }
            }

            // Fare Value (4680.00, w: 102, Dark Maroon, Perfectly centered & dynamically scaled)
            Rectangle {
                id: fareBox
                x: 331; y: 0; width: 102; height: 38; color: root.cFareBg
                clip: true

                Text {
                    id: fareText
                    anchors.fill: parent
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: root.valFare
                    font.family: root.fCond
                    font.pixelSize: 24
                    font.bold: true
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 12
                    color: root.cWhite
                }
            }
        }

        // Horizontal Divider 3
        Rectangle { x: 3; y: 171; width: 433; height: 3; color: root.cBorder }

        // ══════════════════════════════════════════════════════
        // 5. MID-SECTION: ROWS 4 & 5 + SPANNING QR PANEL (y: 174 to 286, Height: 112px)
        // ══════════════════════════════════════════════════════
        Item {
            id: midSection
            x: 3
            y: 174
            width: 433
            height: 112

            // ── LEFT COLUMN (w: 328) ──
            Item {
                x: 0; y: 0; width: 328; height: 112

                // Row 4: Boarding Point & Reservation Up To (h: 38px)
                Rectangle {
                    x: 0; y: 0; width: 328; height: 38; color: root.cBorder

                    // Boarding Point Label (w: 76)
                    Rectangle {
                        x: 0; y: 0; width: 76; height: 38; color: root.cWhite
                        Column {
                            anchors.centerIn: parent
                            spacing: 0
                            Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Boarding"; font.family: root.fSerif; font.pixelSize: 12; font.bold: true; color: root.cMaroon }
                            Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Point"; font.family: root.fSerif; font.pixelSize: 12; font.bold: true; color: root.cMaroon }
                        }
                    }

                    // Boarding Point Value (NDLS, w: 86)
                    Rectangle {
                        x: 79; y: 0; width: 86; height: 38; color: root.cBlack
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: root.valBoarding
                            font.family: root.fCond
                            font.pixelSize: 26
                            font.bold: true
                            color: root.cWhite
                        }
                    }

                    // Reservation Up To Label (w: 69)
                    Rectangle {
                        x: 168; y: 0; width: 69; height: 38; color: root.cWhite
                        Column {
                            anchors.centerIn: parent
                            spacing: 0
                            Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Reservation"; font.family: root.fSerif; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                            Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Up To"; font.family: root.fSerif; font.pixelSize: 11; font.bold: true; color: root.cMaroon }
                        }
                    }

                    // Reservation Up To Value (MAS, w: 88)
                    Rectangle {
                        x: 240; y: 0; width: 88; height: 38; color: root.cBlack
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.verticalCenter: parent.verticalCenter
                            text: root.valResvUpto
                            font.family: root.fCond
                            font.pixelSize: 26
                            font.bold: true
                            color: root.cWhite
                        }
                    }
                }

                // Horizontal Divider between Row 4 and Row 5
                Rectangle { x: 0; y: 38; width: 328; height: 3; color: root.cBorder }

                // Row 5: Passenger Table & Payment Mode Panel (y: 41 to 112, Height: 71px)
                Item {
                    x: 0; y: 41; width: 328; height: 71

                    // Passenger Roster Table (w: 237, h: 71)
                    Rectangle {
                        id: tableBox
                        x: 0; y: 0; width: 237; height: 71
                        color: root.cBlack
                        clip: true

                        // Table Header (h: 11px)
                        Rectangle {
                            id: tableHdr
                            x: 0; y: 0; width: 237; height: 11
                            color: root.cWhite

                            Text {
                                x: 4
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Passenger Name"
                                font.family: "Arial"
                                font.pixelSize: 8
                                font.bold: true
                                color: root.cMaroon
                            }
                            Rectangle { x: 144; y: 0; width: 1; height: 11; color: root.cBorder }
                            Text {
                                x: 145; width: 28
                                horizontalAlignment: Text.AlignHCenter
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Sex"
                                font.family: "Arial"
                                font.pixelSize: 8
                                font.bold: true
                                color: root.cMaroon
                            }
                            Rectangle { x: 173; y: 0; width: 1; height: 11; color: root.cBorder }
                            Text {
                                x: 174; width: 28
                                horizontalAlignment: Text.AlignHCenter
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Age"
                                font.family: "Arial"
                                font.pixelSize: 8
                                font.bold: true
                                color: root.cMaroon
                            }
                            Rectangle { x: 202; y: 0; width: 1; height: 11; color: root.cBorder }
                            Text {
                                x: 203; width: 34
                                horizontalAlignment: Text.AlignHCenter
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Status"
                                font.family: "Arial"
                                font.pixelSize: 8
                                font.bold: true
                                color: root.cMaroon
                            }
                        }

                        // 6 Passenger Rows (each 10px tall, total 60px)
                        Column {
                            x: 0; y: 11; width: 237; height: 60
                            spacing: 0

                            Repeater {
                                model: root.passengerList.slice(0, 6)
                                delegate: Rectangle {
                                    width: 237
                                    height: 10
                                    color: root.cBlack
                                    border.color: "#333333"
                                    border.width: 0.5

                                    Text {
                                        x: 4
                                        width: 138
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: modelData.name || modelData.Passenger_Name || ""
                                        font.family: root.fCond
                                        font.pixelSize: 8
                                        font.bold: true
                                        color: root.cWhite
                                        elide: Text.ElideRight
                                    }
                                    Rectangle { x: 144; y: 0; width: 1; height: 10; color: "#444444" }
                                    Text {
                                        x: 145; width: 28
                                        horizontalAlignment: Text.AlignHCenter
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: modelData.sex || modelData.Sex || ""
                                        font.family: root.fCond
                                        font.pixelSize: 8
                                        font.bold: true
                                        color: root.cWhite
                                    }
                                    Rectangle { x: 173; y: 0; width: 1; height: 10; color: "#444444" }
                                    Text {
                                        x: 174; width: 28
                                        horizontalAlignment: Text.AlignHCenter
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: String(modelData.age || modelData.Age || "")
                                        font.family: root.fCond
                                        font.pixelSize: 8
                                        font.bold: true
                                        color: root.cWhite
                                    }
                                    Rectangle { x: 202; y: 0; width: 1; height: 10; color: "#444444" }
                                    Text {
                                        x: 203; width: 34
                                        horizontalAlignment: Text.AlignHCenter
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: modelData.status || modelData.Status || ""
                                        font.family: root.fCond
                                        font.pixelSize: 8
                                        font.bold: true
                                        color: root.cWhite
                                    }
                                }
                            }
                        }
                    }

                    // Vertical Divider between Passenger Table and Payment Mode
                    Rectangle { x: 237; y: 0; width: 3; height: 71; color: root.cBorder }

                    // Payment Mode Panel (w: 88, Height: 71)
                    Rectangle {
                        x: 240; y: 0; width: 88; height: 71
                        color: root.cBlack
                        clip: true

                        Column {
                            anchors.centerIn: parent
                            spacing: 1
                            width: parent.width - 6

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Payment"
                                font.family: root.fSerif
                                font.pixelSize: 14
                                font.bold: true
                                color: root.cWhite
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Mode"
                                font.family: root.fSerif
                                font.pixelSize: 14
                                font.bold: true
                                color: root.cWhite
                            }
                            Rectangle {
                                width: 72
                                height: 1
                                color: root.cWhite
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Item { width: 1; height: 2 }
                            Text {
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                text: root.valPaymentMode
                                font.family: root.fCond
                                font.pixelSize: 11
                                font.bold: true
                                fontSizeMode: Text.Fit
                                minimumPixelSize: 8
                                color: root.cWhite
                            }
                        }
                    }
                }
            }

            // Vertical Divider separating Mid-Left Column from QR Panel
            Rectangle { x: 328; y: 0; width: 3; height: 112; color: root.cBorder }

            // ── RIGHT COLUMN: SPANNING DYNAMIC 2D QR BARCODE PANEL (w: 102, h: 112) ──
            Rectangle {
                id: qrContainer
                x: 331; y: 0; width: 102; height: 112
                color: root.cWhite
                clip: true

                QRCodeItem {
                    id: qrCodeDisplay
                    anchors.fill: parent
                    anchors.margins: 4
                    qrText: root.valQrString
                    quietZone: 2
                }
            }
        }

        // Horizontal Divider 4
        Rectangle { x: 3; y: 286; width: 433; height: 3; color: root.cBorder }

        // ══════════════════════════════════════════════════════
        // 6. ROW 6: FOOTER (y: 289 to 323, Height: 34px)
        // ══════════════════════════════════════════════════════
        Rectangle {
            id: footerRow
            x: 3
            y: 289
            width: 433
            height: 34
            color: root.cBorder

            // Operator Name Label (w: 76)
            Rectangle {
                x: 0; y: 0; width: 76; height: 34; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Operator"; font.family: root.fSerif; font.pixelSize: 12; font.bold: true; color: root.cMaroon }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "Name"; font.family: root.fSerif; font.pixelSize: 12; font.bold: true; color: root.cMaroon }
                }
            }

            // Operator Name Value (Amit Kumar, w: 249)
            Rectangle {
                x: 79; y: 0; width: 249; height: 34; color: root.cBlack
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.valOperator
                    font.family: root.fSerif
                    font.pixelSize: 18
                    font.bold: true
                    color: root.cWhite
                }
            }

            // Zonal Railway & Division Info (w: 102, y: 0)
            Rectangle {
                x: 331; y: 0; width: 102; height: 34; color: root.cWhite
                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "North Eastern Railway"; font.family: "Arial"; font.pixelSize: 9; font.bold: true; color: root.cBlack }
                    Text { anchors.horizontalCenter: parent.horizontalCenter; text: "वाराणसी मंडल"; font.family: root.fHindi; font.pixelSize: 11; font.bold: true; color: root.cBlack }
                }
            }
        }
    }
}
