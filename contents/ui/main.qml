import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kirigami 2.20 as Kirigami
import "../code/DefaultData.js" as DefaultData

PlasmoidItem {
    id: root

    preferredRepresentation: compactRepresentation

    // ── Theme ──────────────────────────────────────────────────────────────
    readonly property color clrBg:     "#c0c0c0"
    readonly property color clrCard:   "#d4d4d4"
    readonly property color clrHdr:    "#111111"
    readonly property color clrBorder: "#111111"
    readonly property color clrGreen:  "#00ff00"
    readonly property color clrText:   "#111111"
    readonly property color clrSub:    "#333333"
    readonly property color clrMuted:  "#666666"
    readonly property color clrBtn:    "#b8b8b8"
    readonly property string mono:     "Courier New"

    // ── State ──────────────────────────────────────────────────────────────
    property var    tabsData:       []
    property int    activeTabIndex: 0
    property bool   searchVisible:  false
    property string searchText:     ""
    property bool   copiedVisible:  false
    property string copiedText:     ""

    // ── Clipboard ─────────────────────────────────────────────────────────
    TextEdit {
        id: clipHelper
        visible: false
        text: ""
    }

    function copyToClipboard(text) {
        clipHelper.text = text
        clipHelper.forceActiveFocus()
        clipHelper.selectAll()
        clipHelper.copy()
        root.copiedText = text
        root.copiedVisible = true
        copiedTimer.restart()
    }

    Timer {
        id: copiedTimer
        interval: 1600
        onTriggered: root.copiedVisible = false
    }

    // ── Data loading ───────────────────────────────────────────────────────
    function loadData() {
        var json = Plasmoid.configuration.tabsJson
        if (!json || json === "") {
            tabsData = JSON.parse(JSON.stringify(DefaultData.TABS))
        } else {
            try {
                tabsData = JSON.parse(json)
            } catch(e) {
                tabsData = JSON.parse(JSON.stringify(DefaultData.TABS))
            }
        }
        if (activeTabIndex >= tabsData.length) activeTabIndex = 0
    }

    Component.onCompleted: loadData()

    Connections {
        target: Plasmoid.configuration
        function onTabsJsonChanged() { root.loadData() }
    }

    // ── Filtered commands for active tab ───────────────────────────────────
    property var currentCommands: {
        if (tabsData.length === 0 || !tabsData[activeTabIndex]) return []
        var cmds = tabsData[activeTabIndex].commands || []
        var q = searchText.toLowerCase()
        if (q === "") return cmds
        return cmds.filter(function(c) {
            return (c.key || "").toLowerCase().indexOf(q) >= 0 ||
                   (c.desc || "").toLowerCase().indexOf(q) >= 0
        })
    }

    // ── Compact ────────────────────────────────────────────────────────────
    compactRepresentation: MouseArea {
        hoverEnabled: true
        onClicked: root.expanded = !root.expanded
        Kirigami.Icon {
            anchors.centerIn: parent
            source: "input-keyboard"
            width: Math.min(parent.width, parent.height) * 0.85
            height: width
            opacity: parent.containsMouse ? 0.7 : 1.0
            Behavior on opacity { NumberAnimation { duration: 100 } }
        }
    }

    // ── Full representation ────────────────────────────────────────────────
    fullRepresentation: Rectangle {
        id: fullRep
        color: root.clrBg

        Layout.minimumWidth:    Kirigami.Units.gridUnit * 22
        Layout.preferredWidth:  Kirigami.Units.gridUnit * 25
        Layout.minimumHeight:   Kirigami.Units.gridUnit * 20
        Layout.preferredHeight: Kirigami.Units.gridUnit * 40

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // ── HEADER ────────────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: 64
                color: root.clrCard

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width; height: 2
                    color: root.clrBorder
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 8; anchors.rightMargin: 8
                    spacing: 0

                    Row {
                        spacing: 6; Layout.fillWidth: true

                        Column {
                            anchors.verticalCenter: parent.verticalCenter; spacing: 2
                            Row {
                                spacing: 0
                                property var bars: [2,1,4,1,2,1,3,1,2,4,1,2,1,3,2,1]
                                Repeater {
                                    model: parent.bars.length
                                    Rectangle { width: parent.parent.bars[index]; height: 28; color: index % 2 === 0 ? root.clrHdr : "transparent" }
                                }
                            }
                            Text { text: "1 04-52-901"; font.family: root.mono; font.pixelSize: 7; color: root.clrSub }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter; spacing: 3
                            Text {
                                text: "DEV COMMANDS"
                                font.family: root.mono; font.pixelSize: 15; font.bold: true; font.letterSpacing: 2
                                color: root.clrText
                            }
                            Text {
                                text: "PLASMA WIDGET  //  COMMAND REFERENCE"
                                font.family: root.mono; font.pixelSize: 9; font.letterSpacing: 1
                                color: root.clrSub
                            }
                        }
                    }

                    Rectangle { width: 1; Layout.fillHeight: true; color: root.clrBorder; opacity: 0.3 }

                    Column {
                        width: 54; Layout.fillHeight: true; leftPadding: 8; spacing: 2
                        Item { height: 8 }
                        Text { text: "TABS"; font.family: root.mono; font.pixelSize: 9; font.letterSpacing: 1; font.bold: true; color: root.clrSub }
                        Text {
                            text: root.tabsData.length.toString().padStart(2, "0")
                            font.family: root.mono; font.pixelSize: 22; font.bold: true; font.letterSpacing: 2; color: root.clrText
                        }
                    }

                    Rectangle { width: 1; Layout.fillHeight: true; color: root.clrBorder; opacity: 0.3 }

                    Column {
                        width: 58; Layout.fillHeight: true; leftPadding: 8; spacing: 2
                        Item { height: 8 }
                        Text { text: "CMDS"; font.family: root.mono; font.pixelSize: 9; font.letterSpacing: 1; font.bold: true; color: root.clrSub }
                        Text {
                            text: {
                                if (!root.tabsData[root.activeTabIndex]) return "00"
                                return (root.tabsData[root.activeTabIndex].commands || []).length.toString().padStart(2, "0")
                            }
                            font.family: root.mono; font.pixelSize: 22; font.bold: true; font.letterSpacing: 2; color: root.clrText
                        }
                    }
                }
            }

            // ── TAB BAR ───────────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true; height: 36
                color: "#c8c8c8"
                Rectangle { anchors.bottom: parent.bottom; width: parent.width; height: 1; color: root.clrBorder }

                Flickable {
                    anchors { fill: parent; leftMargin: 4; rightMargin: 58 }
                    contentWidth: tabRow.implicitWidth
                    clip: true
                    flickableDirection: Flickable.HorizontalFlick

                    Row {
                        id: tabRow
                        spacing: 3; height: parent.height; topPadding: 5

                        Repeater {
                            model: root.tabsData
                            delegate: Rectangle {
                                property bool isActive: index === root.activeTabIndex
                                height: 28
                                width: tabLbl.implicitWidth + 22
                                color:        isActive ? root.clrHdr : root.clrBtn
                                border.color: root.clrBorder; border.width: 1

                                Rectangle {
                                    visible: isActive
                                    anchors.top: parent.top
                                    width: parent.width; height: 3
                                    color: root.clrGreen
                                }

                                Text {
                                    id: tabLbl
                                    anchors.centerIn: parent
                                    text: modelData.label || ("TAB" + index)
                                    font.family: root.mono; font.pixelSize: 10; font.bold: true; font.letterSpacing: 1
                                    color: isActive ? root.clrGreen : root.clrText
                                }

                                HoverHandler { id: tabHov }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        root.activeTabIndex = index
                                        root.searchText = ""
                                        searchField.text = ""
                                    }
                                }
                                PlasmaComponents.ToolTip {
                                    text: (modelData.commands || []).length + " comandos"
                                    visible: tabHov.hovered
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    anchors { right: parent.right; verticalCenter: parent.verticalCenter; rightMargin: 5 }
                    width: 50; height: 26
                    color: root.searchVisible ? root.clrGreen : root.clrBtn
                    border.color: root.clrBorder; border.width: 1.5
                    Text {
                        anchors.centerIn: parent; text: "⌕ SRC"
                        font.family: root.mono; font.pixelSize: 9; font.bold: true
                        color: root.searchVisible ? "#000" : root.clrText
                    }
                    HoverHandler { id: srcHov }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.searchVisible = !root.searchVisible
                            if (!root.searchVisible) { root.searchText = ""; searchField.text = "" }
                            else searchField.forceActiveFocus()
                        }
                    }
                    PlasmaComponents.ToolTip { text: "Buscar en esta pestaña"; visible: srcHov.hovered }
                }
            }

            // ── SEARCH BAR ────────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: root.searchVisible ? 30 : 0
                visible: root.searchVisible
                color: "#b8b8b8"
                border.color: root.clrBorder; border.width: 1
                clip: true

                Row {
                    anchors { fill: parent; leftMargin: 10; rightMargin: 10 }
                    spacing: 6

                    Text { anchors.verticalCenter: parent.verticalCenter; text: "⌕"; font.family: root.mono; font.pixelSize: 13; color: root.clrSub }

                    TextInput {
                        id: searchField
                        width: parent.width - 50
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: root.mono; font.pixelSize: 9; font.letterSpacing: 1
                        color: root.clrText
                        onTextChanged: root.searchText = text
                        Keys.onEscapePressed: {
                            root.searchVisible = false
                            root.searchText    = ""
                            text = ""
                        }
                    }

                    Text { anchors.verticalCenter: parent.verticalCenter; text: "ESC"; font.family: root.mono; font.pixelSize: 7; font.letterSpacing: 1; color: root.clrMuted }
                }
            }

            // ── COMMANDS: column header ───────────────────────────────────
            Rectangle {
                Layout.fillWidth: true; height: 22
                color: "#b0b0b0"
                border.color: root.clrBorder; border.width: 1
                visible: root.currentCommands.length > 0

                Text {
                    anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                    text: "SHORTCUT / COMANDO  ·  DESCRIPCIÓN  ·  CLICK PARA COPIAR"
                    font.family: root.mono; font.pixelSize: 8; font.bold: true; font.letterSpacing: 1
                    color: root.clrSub
                }
            }

            // ── COMMANDS: empty state ─────────────────────────────────────
            Item {
                Layout.fillWidth: true; Layout.fillHeight: true
                visible: root.currentCommands.length === 0
                Column {
                    anchors.centerIn: parent; spacing: 6
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: root.tabsData.length === 0 ? "SIN PESTAÑAS" : "SIN RESULTADOS"
                        font.family: root.mono; font.pixelSize: 11; font.bold: true; font.letterSpacing: 3
                        color: root.clrMuted
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: root.tabsData.length === 0
                        text: "CONFIGURA PESTAÑAS EN AJUSTES DEL WIDGET"
                        font.family: root.mono; font.pixelSize: 8; font.letterSpacing: 2
                        color: root.clrMuted
                    }
                }
            }

            // ── COMMANDS: list ────────────────────────────────────────────
            PlasmaComponents.ScrollView {
                Layout.fillWidth: true; Layout.fillHeight: true
                clip: true
                visible: root.currentCommands.length > 0

                Column {
                    width: parent ? parent.width : 0

                    Repeater {
                        model: root.currentCommands
                        delegate: Rectangle {
                            id: cmdRow
                            width: parent ? parent.width : 0
                            height: cmdCol.implicitHeight + 14
                            property bool isHovered: false
                            color: isHovered ? "#ccc" : (index % 2 === 0 ? root.clrCard : root.clrBg)

                            Rectangle {
                                anchors.bottom: parent.bottom
                                width: parent.width; height: 1; color: root.clrBorder; opacity: 0.25
                            }

                            Rectangle {
                                visible: cmdRow.isHovered
                                x: 0; y: 0; width: 3; height: parent.height
                                color: root.clrGreen
                            }

                            Column {
                                id: cmdCol
                                anchors { left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter }
                                anchors.leftMargin: 10; anchors.rightMargin: 10
                                spacing: 2

                                Text {
                                    width: parent.width
                                    text: modelData.key || ""
                                    font.family: root.mono; font.pixelSize: 11; font.bold: true; font.letterSpacing: 0.5
                                    color: root.clrText
                                    wrapMode: Text.NoWrap
                                }

                                Text {
                                    width: parent.width
                                    text: modelData.desc || ""
                                    font.family: root.mono; font.pixelSize: 10; font.bold: true
                                    color: root.clrSub
                                    wrapMode: Text.NoWrap
                                }
                            }

                            HoverHandler { onHoveredChanged: cmdRow.isHovered = hovered }
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.copyToClipboard(modelData.key || "")
                            }
                        }
                    }
                }
            }

            // ── COPIED TOAST ──────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: root.copiedVisible ? 28 : 0
                visible: height > 0
                color: root.clrGreen
                clip: true

                Row {
                    anchors { fill: parent; leftMargin: 10; rightMargin: 10 }
                    spacing: 8

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "✓ COPIADO:"
                        font.family: root.mono; font.pixelSize: 10; font.bold: true; color: "#000"
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - 90
                        text: root.copiedText
                        font.family: root.mono; font.pixelSize: 9; color: "#000"; elide: Text.ElideRight
                    }
                }

                Behavior on height { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            }

            // ── FOOTER ────────────────────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true; height: 36
                color: "#c8c8c8"
                Rectangle { anchors.top: parent.top; width: parent.width; height: 2; color: root.clrBorder }

                Row {
                    anchors { fill: parent; leftMargin: 10; rightMargin: 10 }
                    spacing: 8

                    Row {
                        spacing: 0; anchors.verticalCenter: parent.verticalCenter
                        property var bars: [1,3,1,2,4,1,2,1,3,2,1,4,1,2]
                        Repeater {
                            model: parent.bars.length
                            Rectangle { width: parent.parent.bars[index]; height: 20; color: index % 2 === 0 ? root.clrBorder : "transparent" }
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter; spacing: 2
                        Text { text: "KDE::PLASMA DEV COMMANDS"; font.family: root.mono; font.pixelSize: 9; font.bold: true; font.letterSpacing: 2; color: root.clrSub }
                        Text { text: "1 094-72-602  //  v1.0"; font.family: root.mono; font.pixelSize: 8; font.letterSpacing: 1; color: root.clrMuted }
                    }

                    Item { width: parent.width - 200 }

                    Row {
                        spacing: 0; anchors.verticalCenter: parent.verticalCenter
                        property var bars: [2,1,3,1,2,4,1,2,1,3,1,2,1,3]
                        Repeater {
                            model: parent.bars.length
                            Rectangle { width: parent.parent.bars[index]; height: 20; color: index % 2 === 0 ? root.clrBorder : "transparent" }
                        }
                    }
                }
            }
        }
    }
}
