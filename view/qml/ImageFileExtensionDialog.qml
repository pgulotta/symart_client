import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import com.twentysixapps.constants 1.0

MovableDialog {
    id: imageFileExtensionDialogId

    title: qsTr("Save Image As")

    property alias saveAsImage: asImageId.checked
    property alias saveAsWallpaper: asWallpaperId.checked

    Component.onCompleted: listViewId.forceActiveFocus()
    ColumnLayout {
        spacing: 0
        anchors.fill: parent
        Switch {
            id: asWallpaperId
            text: qsTr("Wallpaper")
            checked: false
            visible: isAndroidDevice
        }
        Switch {
            id: asImageId
            text: qsTr("Image")
            checked: true
            visible: isAndroidDevice
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            color: asImageId.checked ? Constants.primaryColor : Constants.disabledTextColor
            enabled: asImageId.checked
            ListView {
                id: listViewId
                keyNavigationWraps: true
                anchors.fill: parent
                anchors.margins: smallPadding
                spacing: smallPadding
                model: fileExtensionModelId
                clip: false
                focus: true
                currentIndex: 3
                delegate: Label {
                    id: delegateId
                    text: name
                    focus: true
                    width: listViewId.width - smallPadding
                    height: 40
                    color: Constants.accentColor
                    wrapMode: Label.WordWrap
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: isMobileDevice ? mediumFontPointSize : smallFontPointSize
                    TapHandler {
                        onTapped: listViewId.currentIndex = index
                    }
                }
                interactive: true
                snapMode: ListView.SnapOneItem
                ScrollBar.vertical: ScrollBar {}
                highlight: Rectangle {
                    color: Constants.linkTextColor
                    width: listViewId.width
                }
            }

            ListModel {
                id: fileExtensionModelId
                ListElement {
                    name: qsTr("BMP")
                    extension: "bmp"
                }
                ListElement {
                    name: qsTr("JPG")
                    extension: "jpg"
                }
                ListElement {
                    name: qsTr("JPEG")
                    extension: "jpeg"
                }
                ListElement {
                    name: qsTr("PNG")
                    extension: "png"
                }
                ListElement {
                    name: qsTr("PPM")
                    extension: "ppm"
                }
                ListElement {
                    name: qsTr("XBM")
                    extension: "xbm"
                }
                ListElement {
                    name: qsTr("XPM")
                    extension: "xpm"
                }
            }
        }
    }
    function selectedExtension() {
        return fileExtensionModelId.get(listViewId.currentIndex).extension
    }
}
