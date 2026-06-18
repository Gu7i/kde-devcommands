import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 2.0 as QQC2
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kirigami 2.20 as Kirigami
import "../code/DefaultData.js" as DefaultData

Item {
    id: configRoot

    // ── Config binding ─────────────────────────────────────────────────────
    property string cfg_tabsJson: ""

    // ── State ──────────────────────────────────────────────────────────────
    property var parsedData:       []
    property int selectedTabIndex: 0
    property int editingCmdIndex:  -2   // -2=none, -1=new, >=0=editing
    property bool editingTabName:  false

    // ── Init ───────────────────────────────────────────────────────────────
    Component.onCompleted: {
        if (!cfg_tabsJson || cfg_tabsJson === "") {
            var def = JSON.parse(JSON.stringify(DefaultData.TABS))
            parsedData   = def
            cfg_tabsJson = JSON.stringify(def)
        } else {
            try {
                parsedData = JSON.parse(cfg_tabsJson)
            } catch(e) {
                var def2 = JSON.parse(JSON.stringify(DefaultData.TABS))
                parsedData   = def2
                cfg_tabsJson = JSON.stringify(def2)
            }
        }
        if (selectedTabIndex >= parsedData.length) selectedTabIndex = 0
    }

    // ── Mutation helpers ───────────────────────────────────────────────────
    function saveData(d) {
        parsedData   = d
        cfg_tabsJson = JSON.stringify(d)
    }

    function addTab(label) {
        var d = JSON.parse(JSON.stringify(parsedData))
        d.push({ id: "tab_" + Date.now(), label: label.trim().toUpperCase(), commands: [] })
        saveData(d)
        selectedTabIndex = d.length - 1
    }

    function removeTab(idx) {
        var d = JSON.parse(JSON.stringify(parsedData))
        d.splice(idx, 1)
        var newSel = (selectedTabIndex >= d.length) ? Math.max(0, d.length - 1) : selectedTabIndex
        saveData(d)
        selectedTabIndex = newSel
    }

    function renameTab(idx, label) {
        var d = JSON.parse(JSON.stringify(parsedData))
        d[idx].label = label.trim().toUpperCase()
        saveData(d)
    }

    function addCommand(tabIdx, key, desc) {
        var d = JSON.parse(JSON.stringify(parsedData))
        if (!d[tabIdx].commands) d[tabIdx].commands = []
        d[tabIdx].commands.push({ key: key.trim(), desc: desc.trim() })
        saveData(d)
    }

    function updateCommand(tabIdx, cmdIdx, key, desc) {
        var d = JSON.parse(JSON.stringify(parsedData))
        d[tabIdx].commands[cmdIdx] = { key: key.trim(), desc: desc.trim() }
        saveData(d)
    }

    function removeCommand(tabIdx, cmdIdx) {
        var d = JSON.parse(JSON.stringify(parsedData))
        d[tabIdx].commands.splice(cmdIdx, 1)
        saveData(d)
    }

    function resetDefaults() {
        var def = JSON.parse(JSON.stringify(DefaultData.TABS))
        saveData(def)
        selectedTabIndex = 0
        editingCmdIndex  = -2
        editingTabName   = false
    }

    // ── Scrollable content ─────────────────────────────────────────────────
    QQC2.ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: Kirigami.Units.largeSpacing

            // Side padding via a wrapper approach on each section
            // using Layout.leftMargin / Layout.rightMargin

            // ── SECTION: Pestañas ──────────────────────────────────────────
            Kirigami.Separator {
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Kirigami.Heading {
                text: "Pestañas"
                level: 3
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Repeater {
                model: configRoot.parsedData
                delegate: RowLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin:  Kirigami.Units.largeSpacing
                    Layout.rightMargin: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    Rectangle {
                        width: 10; height: 10; radius: 1
                        color: index === configRoot.selectedTabIndex ? "#00cc00" : "transparent"
                        border.color: "#aaaaaa"; border.width: 1
                    }

                    PlasmaComponents.Label {
                        text: modelData.label || ("Tab " + index)
                        font.bold: index === configRoot.selectedTabIndex
                        Layout.fillWidth: true
                    }

                    PlasmaComponents.Label {
                        text: (modelData.commands || []).length + " cmds"
                        opacity: 0.5
                        font.pixelSize: Kirigami.Units.gridUnit * 0.75
                    }

                    PlasmaComponents.ToolButton {
                        icon.name: "cursor-arrow"
                        flat: true
                        enabled: index !== configRoot.selectedTabIndex
                        onClicked: {
                            configRoot.selectedTabIndex = index
                            configRoot.editingCmdIndex  = -2
                            configRoot.editingTabName   = false
                        }
                        PlasmaComponents.ToolTip { text: "Seleccionar pestaña" }
                    }

                    PlasmaComponents.ToolButton {
                        icon.name: "document-edit"
                        flat: true
                        onClicked: {
                            configRoot.selectedTabIndex = index
                            configRoot.editingTabName   = true
                            tabNameField.text = modelData.label || ""
                            tabNameField.forceActiveFocus()
                        }
                        PlasmaComponents.ToolTip { text: "Renombrar pestaña" }
                    }

                    PlasmaComponents.ToolButton {
                        icon.name: "list-remove"
                        flat: true
                        enabled: configRoot.parsedData.length > 1
                        onClicked: configRoot.removeTab(index)
                        PlasmaComponents.ToolTip { text: "Eliminar pestaña" }
                    }
                }
            }

            // Tab name editor
            Kirigami.Separator {
                visible: configRoot.editingTabName
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Kirigami.FormLayout {
                visible: configRoot.editingTabName
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing

                PlasmaComponents.TextField {
                    id: tabNameField
                    Kirigami.FormData.label: "Nombre de pestaña:"
                    placeholderText: "ej: PYTHON"
                    Keys.onReturnPressed: saveTabName()
                    Keys.onEscapePressed: configRoot.editingTabName = false
                }

                RowLayout {
                    Kirigami.FormData.label: ""
                    spacing: Kirigami.Units.smallSpacing
                    PlasmaComponents.Button {
                        text: "Cancelar"
                        onClicked: configRoot.editingTabName = false
                    }
                    PlasmaComponents.Button {
                        text: "Renombrar"
                        enabled: tabNameField.text.trim().length > 0
                        onClicked: saveTabName()
                    }
                }
            }

            // Add new tab
            Kirigami.Separator {
                visible: !configRoot.editingTabName
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            RowLayout {
                visible: !configRoot.editingTabName
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
                spacing: Kirigami.Units.smallSpacing

                PlasmaComponents.TextField {
                    id: newTabField
                    Layout.fillWidth: true
                    placeholderText: "Nombre de nueva pestaña (ej: PYTHON)"
                    Keys.onReturnPressed: addNewTab()
                }

                PlasmaComponents.Button {
                    text: "Añadir pestaña"
                    icon.name: "list-add"
                    enabled: newTabField.text.trim().length > 0
                    onClicked: addNewTab()
                }
            }

            // ── SECTION: Comandos ──────────────────────────────────────────
            Kirigami.Separator {
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Kirigami.Heading {
                text: configRoot.parsedData[configRoot.selectedTabIndex]
                      ? ("Comandos de " + configRoot.parsedData[configRoot.selectedTabIndex].label)
                      : "Comandos"
                level: 3
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Repeater {
                model: (configRoot.parsedData[configRoot.selectedTabIndex] || {}).commands || []
                delegate: RowLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin:  Kirigami.Units.largeSpacing
                    Layout.rightMargin: Kirigami.Units.largeSpacing
                    spacing: Kirigami.Units.smallSpacing

                    PlasmaComponents.Label {
                        text: modelData.key || ""
                        font.bold: true
                        Layout.preferredWidth: Kirigami.Units.gridUnit * 10
                        elide: Text.ElideRight
                    }
                    PlasmaComponents.Label {
                        text: modelData.desc || ""
                        opacity: 0.7
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }

                    PlasmaComponents.ToolButton {
                        icon.name: "document-edit"
                        flat: true
                        onClicked: {
                            configRoot.editingCmdIndex = index
                            editKeyField.text  = modelData.key  || ""
                            editDescField.text = modelData.desc || ""
                            editKeyField.forceActiveFocus()
                        }
                        PlasmaComponents.ToolTip { text: "Editar comando" }
                    }
                    PlasmaComponents.ToolButton {
                        icon.name: "list-remove"
                        flat: true
                        onClicked: configRoot.removeCommand(configRoot.selectedTabIndex, index)
                        PlasmaComponents.ToolTip { text: "Eliminar comando" }
                    }
                }
            }

            // Edit existing command
            Kirigami.Separator {
                visible: configRoot.editingCmdIndex >= 0
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Kirigami.FormLayout {
                visible: configRoot.editingCmdIndex >= 0
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing

                PlasmaComponents.TextField {
                    id: editKeyField
                    Kirigami.FormData.label: "Atajo / Comando:"
                    placeholderText: "ej: Ctrl+P"
                }
                PlasmaComponents.TextField {
                    id: editDescField
                    Kirigami.FormData.label: "Descripción:"
                    placeholderText: "ej: Abrir archivo rápido"
                    Keys.onReturnPressed: saveEditCmd()
                }
                RowLayout {
                    Kirigami.FormData.label: ""
                    spacing: Kirigami.Units.smallSpacing
                    PlasmaComponents.Button {
                        text: "Cancelar"
                        onClicked: configRoot.editingCmdIndex = -2
                    }
                    PlasmaComponents.Button {
                        text: "Guardar"
                        enabled: editKeyField.text.trim().length > 0
                        onClicked: saveEditCmd()
                    }
                }
            }

            // Add new command
            Kirigami.Separator {
                visible: configRoot.editingCmdIndex === -2
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Kirigami.Heading {
                visible: configRoot.editingCmdIndex === -2
                text: "Añadir comando"
                level: 4
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            Kirigami.FormLayout {
                visible: configRoot.editingCmdIndex === -2
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing

                PlasmaComponents.TextField {
                    id: newKeyField
                    Kirigami.FormData.label: "Atajo / Comando:"
                    placeholderText: "ej: Ctrl+Shift+P"
                }
                PlasmaComponents.TextField {
                    id: newDescField
                    Kirigami.FormData.label: "Descripción:"
                    placeholderText: "ej: Paleta de comandos"
                    Keys.onReturnPressed: addNewCmd()
                }
                PlasmaComponents.Button {
                    Kirigami.FormData.label: ""
                    text: "Añadir comando"
                    icon.name: "list-add"
                    enabled: newKeyField.text.trim().length > 0
                    onClicked: addNewCmd()
                }
            }

            // ── SECTION: Acciones ──────────────────────────────────────────
            Kirigami.Separator {
                Layout.fillWidth: true
                Layout.leftMargin:  Kirigami.Units.largeSpacing
                Layout.rightMargin: Kirigami.Units.largeSpacing
            }

            PlasmaComponents.Button {
                text: "Restablecer valores predeterminados"
                icon.name: "edit-reset"
                Layout.leftMargin: Kirigami.Units.largeSpacing
                onClicked: configRoot.resetDefaults()
                PlasmaComponents.ToolTip { text: "Restaura todas las pestañas y comandos por defecto" }
            }

            Item {
                Layout.preferredHeight: Kirigami.Units.largeSpacing * 2
            }
        }
    }

    // ── Helper functions (fuera del layout) ────────────────────────────────
    function saveTabName() {
        if (tabNameField.text.trim().length > 0) {
            configRoot.renameTab(configRoot.selectedTabIndex, tabNameField.text)
            configRoot.editingTabName = false
        }
    }

    function addNewTab() {
        if (newTabField.text.trim().length > 0) {
            configRoot.addTab(newTabField.text)
            newTabField.text = ""
        }
    }

    function addNewCmd() {
        if (newKeyField.text.trim().length > 0) {
            configRoot.addCommand(configRoot.selectedTabIndex, newKeyField.text, newDescField.text)
            newKeyField.text  = ""
            newDescField.text = ""
        }
    }

    function saveEditCmd() {
        if (configRoot.editingCmdIndex >= 0 && editKeyField.text.trim().length > 0) {
            configRoot.updateCommand(configRoot.selectedTabIndex, configRoot.editingCmdIndex, editKeyField.text, editDescField.text)
            configRoot.editingCmdIndex = -2
        }
    }
}
