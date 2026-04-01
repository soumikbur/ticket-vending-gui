import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    anchors.fill: parent

    // ── SLOT 1 ──
    readonly property var slot1: [
        { pname: "Ravi",        sex: "M", age: "23", status: "S4 - 66" },
        { pname: "AmitK",       sex: "F", age: "34", status: "S4 - 65" },
        { pname: "TARAN",       sex: "M", age: "33", status: "S4 - 67" },
        { pname: "Neeraj",      sex: "M", age: "22", status: "S4 - 68" },
        { pname: "Sangeeta",    sex: "M", age: "34", status: "S4 - 69" },
        { pname: "Kshitiz",     sex: "M", age: "23", status: "S4 - 70" }
    ]

    // ── SLOT 2 ──
    readonly property var slot2: [
        { pname: "Priya Sharma",  sex: "F", age: "28", status: "S4 - 71" },
        { pname: "Rahul Gupta",   sex: "M", age: "45", status: "S4 - 72" },
        { pname: "Anjali Singh",  sex: "F", age: "19", status: "S4 - 73" },
        { pname: "Vikram Das",    sex: "M", age: "52", status: "S4 - 74" },
        { pname: "Meena Patel",   sex: "F", age: "37", status: "S4 - 75" },
        { pname: "Arjun Reddy",   sex: "M", age: "31", status: "S4 - 76" }
    ]

    // ── ACTIVE SLOT — change slot1 → slot2 here to switch ──
    // property var activePassengers: slot1
    property var activePassengers: slot2   // <-- uncomment this & comment above to see slot2

    // ── Ticket data ──
    readonly property var ticket: ({
        from:       "NDLS",
        to:         "MAS",
        trainNo:    "12616",
        quota:      "GN",
        date:       "14/ 07",
        totalPass:  "06",
        cls:        "SL",
        fare:       "4680.00",
        boarding:   "NDLS",
        resvUpto:   "MAS",
        operator:   "Amit Kumar"
    })

    // ══════════════════════════════════════════════════════════════════
    //  COLOURS
    // ══════════════════════════════════════════════════════════════════
    readonly property color cCream:  "#FFFFFF"
    readonly property color cBlack:  "#000000"
    readonly property color cMaroon: "#3B0000"
    readonly property color cDarkM:  "#5C0A0A"
    readonly property color cGold:   "#C8A040"
    readonly property color cGap:    "#FFFFFF"   // gap between cells = cream

    // ══════════════════════════════════════════════════════════════════
    //  MAIN CANVAS
    // ══════════════════════════════════════════════════════════════════
    Rectangle {
        id: canvas
        anchors.fill: parent
        anchors.margins: 10
        color: cCream

        // ── All proportional math ──
        property real cw: width
        property real ch: height
        property real gap: cw * 0.004          // ~4px gap at 1000px width

        // ── Column fractions (rows 1-3: 4-column grid) ──
        property real lbl1W: 0.086             // "From" / "Train No" / "Date" label
        property real val1W: 0.370             // NDLS value / 12616 / 14-07
        property real lbl2W: 0.068             // "To" / "Quota" / "Fare" label
        // val2 fills rest

        // ── Row-3 extra columns (Date row) ──
        property real dateW:  0.100            // date value cell
        property real totalW: 0.155            // Total Passangers cell
        property real classW: 0.092            // Class cell
        property real fareLW: 0.067            // Fare label

        // ── Rows 4+5 column fractions ──
        property real brdLW:  0.100            // "Boarding Point" label
        property real brdVW:  0.100            // NDLS value
        property real rsvLW:  0.130            // "Reservation Up To" label
        property real qrPanW: 0.210            // QR panel (rightmost, spans rows 4+5)
        // rsvVal fills middle

        // ── Row height fractions ──
        property real hHdr:  0.128
        property real hR1:   0.090
        property real hR2:   0.090
        property real hR3:   0.092
        property real hR4:   0.106
        property real hFtr:  0.092
        // hR5 (passenger table) = remaining between R4 and footer

        // ── Computed Y positions ──
        property real yHdr: 0
        property real yR1:  hHdr + gap/ch
        property real yR2:  yR1  + hR1 + gap/ch
        property real yR3:  yR2  + hR2 + gap/ch
        property real yR4:  yR3  + hR3 + gap/ch
        property real yR5:  yR4  + hR4 + gap/ch
        property real yFtr: 1.0  - hFtr
        property real hR5:  yFtr - yR5 - gap/ch

        // ── Computed X positions (rows 1-3) ──
        property real xV1:  lbl1W + gap/cw
        property real xL2:  xV1 + val1W + gap/cw
        property real xV2:  xL2 + lbl2W + gap/cw

        // ── Computed X positions (row 3 extras) ──
        property real xDate:  lbl1W + gap/cw
        property real xTotal: xDate  + dateW  + gap/cw
        property real xClass: xTotal + totalW + gap/cw
        property real xFareL: xClass + classW + gap/cw
        property real xFareV: xFareL + fareLW + gap/cw

        // ── Computed X positions (rows 4+5) ──
        property real xBrdV:  brdLW + gap/cw
        property real xRsvL:  xBrdV + brdVW + gap/cw
        property real xRsvV:  xRsvL + rsvLW + gap/cw
        property real xQrP:   1.0 - qrPanW

        // ══════════════
        //  HEADER
        // ══════════════
        Item {
            x: 0
            y: canvas.yHdr * canvas.ch
            width:  canvas.cw
            height: canvas.hHdr * canvas.ch

            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.005
                anchors.verticalCenter: parent.verticalCenter
                text: "Ticket Information"
                color: root.cMaroon
                font.family: "Georgia"
                font.pixelSize: Math.min(parent.height * 0.68, parent.width * 0.068)
                font.bold: true
                font.italic: true
            }

            Column {
                anchors.right: emblem.left
                anchors.rightMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 4
                spacing: 1
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Operator Code"
                    font.pixelSize: 9
                    color: root.cMaroon
                }
                Rectangle { width: 72; height: 1; color: root.cMaroon }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "CLIENT"
                    font.pixelSize: 10
                    font.bold: true
                    color: root.cMaroon
                }
            }

            Rectangle {
                id: emblem
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: -2
                width: Math.min(parent.height * 1.05, 72)
                height: width
                radius: width / 2
                color: "#8B1010"
                border.color: root.cGold
                border.width: 3

                Column {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 1
                    spacing: 1
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 1
                        Rectangle { width: 5; height: 7;  color: root.cGold; radius: 1 }
                        Rectangle { width: 9; height: 9;  color: root.cGold; radius: 1 }
                        Rectangle { width: 7; height: 7;  color: root.cGold; radius: 1 }
                        Rectangle { width: 5; height: 7;  color: root.cGold; radius: 1 }
                    }
                    Rectangle {
                        width: 31
                        height: 2
                        color: root.cGold
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Row {
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 5
                        Rectangle { width: 7; height: 4; color: root.cGold; radius: 4 }
                        Rectangle { width: 7; height: 4; color: root.cGold; radius: 4 }
                        Rectangle { width: 7; height: 4; color: root.cGold; radius: 4 }
                    }
                }
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 3
                    width: 42
                    height: 15
                    color: "#6B0000"
                    radius: 2
                    Text {
                        anchors.centerIn: parent
                        text: "भारतीय रेल"
                        font.pixelSize: 7
                        font.bold: true
                        color: "#FFFFFF"
                    }
                }
            }
        }

        // ══════════════
        //  ROW 1 : FROM / TO
        // ══════════════
        Item {
            x: 0
            y: canvas.yR1 * canvas.ch
            width:  canvas.cw
            height: canvas.hR1 * canvas.ch

            // "From" label
            Rectangle {
                x: 0
                y: 0
                width:  canvas.lbl1W * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "From";     color: root.cMaroon; font.pixelSize: Math.max(12, parent.parent.height*0.22); font.bold: true }
                    Text { text: "कहाँ  से"; color: root.cMaroon; font.pixelSize: Math.max(8,  parent.parent.height*0.15) }
                }
            }
            // FROM value
            Rectangle {
                x: canvas.xV1 * canvas.cw
                y: 0
                width:  canvas.val1W * canvas.cw
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.from
                    color: "#FFFFFF"
                    font.bold: true
                    font.pixelSize: parent.height * 0.55
                }
            }
            // "To" label
            Rectangle {
                x: canvas.xL2 * canvas.cw
                y: 0
                width:  canvas.lbl2W * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "To";        color: root.cMaroon; font.pixelSize: Math.max(12, parent.parent.height*0.22); font.bold: true }
                    Text { text: "कहाँ  तक"; color: root.cMaroon; font.pixelSize: Math.max(8,  parent.parent.height*0.15) }
                }
            }
            // TO value
            Rectangle {
                x: canvas.xV2 * canvas.cw
                y: 0
                width:  canvas.cw - canvas.xV2 * canvas.cw
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.to
                    color: "#FFFFFF"
                    font.bold: true
                    font.pixelSize: parent.height * 0.55
                }
            }
        }

        // ══════════════
        //  ROW 2 : TRAIN NO / QUOTA
        // ══════════════
        Item {
            x: 0
            y: canvas.yR2 * canvas.ch
            width:  canvas.cw
            height: canvas.hR2 * canvas.ch

            Rectangle {
                x: 0
                y: 0
                width:  canvas.lbl1W * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "Train No."; color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.20); font.bold: true }
                    Text { text: "गाड़ी  सं."; color: root.cMaroon; font.pixelSize: Math.max(8,  parent.parent.height*0.15) }
                }
            }
            Rectangle {
                x: canvas.xV1 * canvas.cw
                y: 0
                width:  canvas.val1W * canvas.cw
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.trainNo
                    color: "#FFFFFF"
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: parent.height * 0.55
                }
            }
            Rectangle {
                x: canvas.xL2 * canvas.cw
                y: 0
                width:  canvas.lbl2W * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "Quota"; color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.20); font.bold: true }
                    Text { text: "कोटा";  color: root.cMaroon; font.pixelSize: Math.max(8,  parent.parent.height*0.15) }
                }
            }
            Rectangle {
                x: canvas.xV2 * canvas.cw
                y: 0
                width:  canvas.cw - canvas.xV2 * canvas.cw
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.quota
                    color: "#FFFFFF"
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: parent.height * 0.55
                }
            }
        }

        // ══════════════
        //  ROW 3 : DATE / TOTAL PASS / CLASS / FARE
        // ══════════════
        Item {
            x: 0
            y: canvas.yR3 * canvas.ch
            width:  canvas.cw
            height: canvas.hR3 * canvas.ch

            // Date label
            Rectangle {
                x: 0
                y: 0
                width:  canvas.lbl1W * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "Date";   color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.20); font.bold: true }
                    Text { text: "दिनांक"; color: root.cMaroon; font.pixelSize: Math.max(8,  parent.parent.height*0.15) }
                }
            }
            // Date value
            Rectangle {
                x: canvas.xDate * canvas.cw
                y: 0
                width:  canvas.dateW * canvas.cw
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.date
                    color: "#FFFFFF"
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: parent.height * 0.42
                }
            }
            // Total Passangers — split label/value
            Rectangle {
                x: canvas.xTotal * canvas.cw
                y: 0
                width:  canvas.totalW * canvas.cw
                height: parent.height
                color: root.cBlack

                Rectangle {
                    id: tpTop
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height * 0.50
                    color: root.cBlack
                    Text {
                        anchors.centerIn: parent
                        text: "Total Passangers"
                        color: "#FFFFFF"
                        font.family: "Georgia"
                        font.bold: true
                        font.pixelSize: Math.max(9, parent.height * 0.34)
                    }
                }
                Rectangle {
                    anchors.top: tpTop.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: "#FFFFFF"
                }
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height * 0.50
                    color: root.cBlack
                    Text {
                        anchors.centerIn: parent
                        text: root.ticket.totalPass
                        color: "#FFFFFF"
                        font.family: "Georgia"
                        font.bold: true
                        font.pixelSize: Math.max(12, parent.height * 0.40)
                    }
                }
            }
            // Class — split label/value
            Rectangle {
                x: canvas.xClass * canvas.cw
                y: 0
                width:  canvas.classW * canvas.cw
                height: parent.height
                color: root.cBlack

                Rectangle {
                    id: clsTop
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height * 0.50
                    color: root.cBlack
                    Text {
                        anchors.centerIn: parent
                        text: "Class"
                        color: "#FFFFFF"
                        font.family: "Georgia"
                        font.bold: true
                        font.italic: true
                        font.pixelSize: Math.max(9, parent.height * 0.34)
                    }
                }
                Rectangle {
                    anchors.top: clsTop.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: "#FFFFFF"
                }
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height * 0.50
                    color: root.cBlack
                    Text {
                        anchors.centerIn: parent
                        text: root.ticket.cls
                        color: "#FFFFFF"
                        font.family: "Georgia"
                        font.bold: true
                        font.pixelSize: Math.max(12, parent.height * 0.40)
                    }
                }
            }
            // Fare label
            Rectangle {
                x: canvas.xFareL * canvas.cw
                y: 0
                width:  canvas.fareLW * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "Fare";    color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.20); font.bold: true }
                    Text { text: "किराया"; color: root.cMaroon; font.pixelSize: Math.max(8,  parent.parent.height*0.15) }
                }
            }
            // Fare value
            Rectangle {
                x: canvas.xFareV * canvas.cw
                y: 0
                width:  canvas.cw - canvas.xFareV * canvas.cw
                height: parent.height
                color: root.cDarkM
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.fare
                    color: "#FFFFFF"
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: parent.height * 0.55
                }
            }
        }

        // ══════════════════════════════════════════════════════════
        //  ROW 4 : BOARDING / RESERVATION — left part
        // ══════════════════════════════════════════════════════════
        Item {
            x: 0
            y: canvas.yR4 * canvas.ch
            width:  (canvas.xQrP - canvas.gap/canvas.cw) * canvas.cw
            height: canvas.hR4 * canvas.ch

            // "Boarding Point" label
            Rectangle {
                x: 0
                y: 0
                width:  canvas.brdLW * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "Boarding"; color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.20); font.bold: true }
                    Text { text: "Point";   color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.20); font.bold: true }
                }
            }
            // Boarding value
            Rectangle {
                x: canvas.xBrdV * canvas.cw
                y: 0
                width:  canvas.brdVW * canvas.cw
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.boarding
                    color: "#FFFFFF"
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: parent.height * 0.42
                }
            }
            // "Reservation Up To" label
            Rectangle {
                x: canvas.xRsvL * canvas.cw
                y: 0
                width:  canvas.rsvLW * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.06
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "Reservation"; color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.19); font.bold: true }
                    Text { text: "Up To";       color: root.cMaroon; font.pixelSize: Math.max(11, parent.parent.height*0.19); font.bold: true }
                }
            }
            // Reservation value
            Rectangle {
                x: canvas.xRsvV * canvas.cw
                y: 0
                width:  parent.width - canvas.xRsvV * canvas.cw
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.centerIn: parent
                    text: root.ticket.resvUpto
                    color: "#FFFFFF"
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: parent.height * 0.42
                }
            }
        }

        // ══════════════════════════════════════════════════════════
        //  ROW 5 : PASSENGER TABLE — left part
        // ══════════════════════════════════════════════════════════
        Item {
            x: 0
            y: canvas.yR5 * canvas.ch
            width:  (canvas.xQrP - canvas.gap/canvas.cw) * canvas.cw
            height: canvas.hR5 * canvas.ch

            Rectangle {
                anchors.fill: parent
                color: root.cBlack
                border.color: "#444444"
                border.width: 1

                Column {
                    anchors.fill: parent

                    // Header row
                    Row {
                        id: tableHeader
                        width: parent.width
                        height: parent.height * 0.135

                        Rectangle {
                            width: parent.width * 0.540
                            height: parent.height
                            color: "#FFFFFF"
                            border.color: "#AAAAAA"
                            border.width: 1
                            Text { anchors.centerIn: parent; text: "Passanger Name"; font.pixelSize: Math.max(9, parent.height*0.40); font.bold: true; color: "#000000" }
                        }
                        Rectangle {
                            width: parent.width * 0.130
                            height: parent.height
                            color: "#FFFFFF"
                            border.color: "#AAAAAA"
                            border.width: 1
                            Text { anchors.centerIn: parent; text: "Sex"; font.pixelSize: Math.max(9, parent.height*0.40); font.bold: true; color: "#000000" }
                        }
                        Rectangle {
                            width: parent.width * 0.130
                            height: parent.height
                            color: "#FFFFFF"
                            border.color: "#AAAAAA"
                            border.width: 1
                            Text { anchors.centerIn: parent; text: "Age"; font.pixelSize: Math.max(9, parent.height*0.40); font.bold: true; color: "#000000" }
                        }
                        Rectangle {
                            width: parent.width * 0.200
                            height: parent.height
                            color: "#FFFFFF"
                            border.color: "#AAAAAA"
                            border.width: 1
                            Text { anchors.centerIn: parent; text: "Status"; font.pixelSize: Math.max(9, parent.height*0.40); font.bold: true; color: "#000000" }
                        }
                    }

                    // Data rows
                    Repeater {
                        model: root.activePassengers
                        delegate: Row {
                            property real rowH: (parent.height - tableHeader.height) / root.activePassengers.length
                            width: parent.width
                            height: rowH

                            Rectangle {
                                width: parent.width * 0.540
                                height: parent.height
                                color: root.cBlack
                                border.color: "#333333"
                                border.width: 1
                                Text {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 6
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData.pname
                                    color: "#FFFFFF"
                                    font.pixelSize: Math.max(9, parent.height * 0.42)
                                }
                            }
                            Rectangle {
                                width: parent.width * 0.130
                                height: parent.height
                                color: root.cBlack
                                border.color: "#333333"
                                border.width: 1
                                Text { anchors.centerIn: parent; text: modelData.sex; color: "#FFFFFF"; font.pixelSize: Math.max(9, parent.height*0.42) }
                            }
                            Rectangle {
                                width: parent.width * 0.130
                                height: parent.height
                                color: root.cBlack
                                border.color: "#333333"
                                border.width: 1
                                Text { anchors.centerIn: parent; text: modelData.age; color: "#FFFFFF"; font.pixelSize: Math.max(9, parent.height*0.42) }
                            }
                            Rectangle {
                                width: parent.width * 0.200
                                height: parent.height
                                color: root.cBlack
                                border.color: "#333333"
                                border.width: 1
                                Text { anchors.centerIn: parent; text: modelData.status; color: "#FFFFFF"; font.pixelSize: Math.max(8, parent.height*0.38) }
                            }
                        }
                    }
                }
            }
        }

        // ══════════════════════════════════════════════════════════
        //  QR PANEL — spans rows 4+5 on the right
        // ══════════════════════════════════════════════════════════
        Rectangle {
            x: canvas.xQrP * canvas.cw
            y: canvas.yR4  * canvas.ch
            width:  canvas.qrPanW * canvas.cw
            height: (canvas.hR4 + canvas.gap/canvas.ch + canvas.hR5) * canvas.ch
            color: root.cBlack

            // QR Code image — top portion
            Rectangle {
                id: qrImageBox
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 4
                height: parent.height * 0.52
                color: root.cBlack

                Image {
                    anchors.fill: parent
                    anchors.margins: 2
                    source: "qr_code.png"
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }

            // Divider
            Rectangle {
                anchors.top: qrImageBox.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: "#555555"
            }

            // "Payment Mode" label — middle
            Rectangle {
                anchors.top: qrImageBox.bottom
                anchors.bottom: upiStrip.top
                anchors.left: parent.left
                anchors.right: parent.right
                color: root.cBlack
                Column {
                    anchors.centerIn: parent
                    spacing: 3
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Payment"
                        color: "#FFFFFF"
                        font.family: "Georgia"
                        font.bold: true
                        font.pixelSize: Math.max(14, parent.parent.height * 0.12)
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Mode"
                        color: "#FFFFFF"
                        font.family: "Georgia"
                        font.bold: true
                        font.pixelSize: Math.max(14, parent.parent.height * 0.12)
                    }
                }
            }

            // Divider above UPI strip
            Rectangle {
                anchors.bottom: upiStrip.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 2
                color: root.cMaroon
            }

            // "UPI-QR CODE" bottom strip
            Rectangle {
                id: upiStrip
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height * 0.088
                color: root.cCream
                Text {
                    anchors.centerIn: parent
                    text: "UPI-QR CODE"
                    color: root.cMaroon
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: Math.max(10, parent.height * 0.52)
                }
            }
        }

        // ══════════════
        //  FOOTER
        // ══════════════
        Item {
            x: 0
            y: canvas.yFtr * canvas.ch
            width:  canvas.cw
            height: canvas.hFtr * canvas.ch

            // "Operator Name" label
            Rectangle {
                x: 0
                y: 0
                width:  canvas.lbl1W * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.08
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text { text: "Operator"; color: root.cMaroon; font.pixelSize: Math.max(12, parent.parent.height*0.20); font.bold: true }
                    Text { text: "Name";     color: root.cMaroon; font.pixelSize: Math.max(12, parent.parent.height*0.20); font.bold: true }
                }
            }
            // Operator value
            Rectangle {
                x: canvas.xV1 * canvas.cw
                y: 0
                width:  canvas.cw - canvas.xV1 * canvas.cw - canvas.qrPanW * canvas.cw - canvas.gap
                height: parent.height
                color: root.cBlack
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.015
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.ticket.operator
                    color: "#FFFFFF"
                    font.family: "Georgia"
                    font.bold: true
                    font.pixelSize: parent.height * 0.50
                }
            }
            // North Eastern Railway
            Rectangle {
                x: canvas.xQrP * canvas.cw
                y: 0
                width:  canvas.qrPanW * canvas.cw
                height: parent.height
                color: root.cCream
                Column {
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.06
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    Text {
                        anchors.right: parent.right
                        text: "North Eastern Railway"
                        color: root.cMaroon
                        font.family: "Georgia"
                        font.bold: true
                        font.pixelSize: Math.max(10, parent.parent.height * 0.18)
                    }
                    Text {
                        anchors.right: parent.right
                        text: "वाराणसी   मंडल"
                        color: root.cMaroon
                        font.pixelSize: Math.max(9, parent.parent.height * 0.16)
                    }
                }
            }
        }

    } // canvas
}
