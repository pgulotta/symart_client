import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

Page {
    id: infoPageId
    objectName: "SettingsPage"
    property alias wallpaperSelection: scheduleSelectorId.selectorIndex

    Material.background: Constants.accentColor

    Column {
        anchors.fill: parent

        Label {
            id: settingsTitleId
            text: qsTr("Settings")
            color: Constants.linkTextColor
            scale: 1.25
            anchors.left: parent.left
            anchors.leftMargin: largePadding
            anchors.top: parent.top
            anchors.topMargin: largePadding
            anchors.bottomMargin: exlargePadding
        }

        TumblerSelector {
            id: scheduleSelectorId
            title: qsTr("Manage Wallpaper")
            selectorModel: wallpaperScheduleModelId
            width: 250
            height: 150
            anchors.top: settingsTitleId.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: exlargePadding
            onSelectorModelChanged: selectorIndex = 0
        }

        ListModel {
            id: wallpaperScheduleModelId
            ListElement {
                name: qsTr("Never Auto-Generate")
            }
            ListElement {
                name: qsTr("Generate Every 15 Minutes")
            }
            ListElement {
                name: qsTr("Generate Hourly")
            }
            ListElement {
                name: qsTr("Generate Daily")
            }
        }
    }
}
