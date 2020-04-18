import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

Page {
    id: infoPageId
    objectName: "SettingsPage"
    property int wallpaperSelection: 0

    Material.background: Constants.accentColor

    Column {
        spacing: exlargePadding
        anchors.left: parent.left
        anchors.leftMargin: largePadding
        anchors.top: parent.top
        anchors.topMargin: largePadding
        Label {
            id: settingsTitleId
            text: qsTr("Settings")
            color: Constants.linkTextColor
            scale: 1.25
            leftPadding: largePadding
        }

        ButtonGroup {
            id: buttonGroupId
        }
        ListView {
            id: scheduleSelectorId
            width: 250
            height: 150
            interactive: true
            model: wallpaperScheduleModelId
            delegate: RadioDelegate {
                text: model.name
                checked: model.itemIndex === wallpaperSelection
                ButtonGroup.group: buttonGroupId
                onClicked: if (checked) {
                               wallpaperSelection = model.itemIndex
                           }
            }
        }

        ListModel {
            id: wallpaperScheduleModelId
            ListElement {
                name: qsTr("Never Auto-Generate")
                itemIndex: 0
            }
            ListElement {
                name: qsTr("Generate Every 15 Minutes")
                itemIndex: 1
            }
            ListElement {
                name: qsTr("Generate Hourly")
                itemIndex: 3
            }
            ListElement {
                name: qsTr("Generate Daily")
                itemIndex: 4
            }
        }
    }
}
