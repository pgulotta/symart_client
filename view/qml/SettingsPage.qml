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
            implicitWidth: 200
            implicitHeight: 200
            interactive: true
            model: wallpaperScheduleModelId
            header: HtmlText {
                text: qsTr("Manage Wallpaper")
                isUpperCase: true
                isTitle: true
            }
            delegate: RadioDelegate {
                id: radioDelegateId
                indicator: Rectangle {
                    implicitWidth: 26
                    implicitHeight: 26
                    x: radioDelegateId.width - width - radioDelegateId.rightPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    color: "transparent"
                    border.color: radioDelegateId.down ? Qt.darker(
                                                             Constants.accentColor) : Qt.lighter(
                                                             Constants.accentColor)

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        visible: radioDelegateId.checked
                        color: radioDelegateId.down ? Qt.darker(
                                                          Constants.accentColor) : Qt.lighter(
                                                          Constants.accentColor)
                    }
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 38
                    visible: radioDelegateId.down || radioDelegateId.highlighted
                    color: radioDelegateId.down ? Constants.linkTextColor : Constants.disabledTextColor
                }
                text: model.name

                checked: model.itemIndex === wallpaperSelection
                focusPolicy: Qt.StrongFocus
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
