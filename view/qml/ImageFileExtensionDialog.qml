import QtQuick 2.14
import QtQuick.Controls 2.14
import com.twentysixapps.constants 1.0

MovableDialog {
    id: imageFileExtensionDialogId

    title: qsTr("Save Image As")

    Component.onCompleted: listViewId.forceActiveFocus()
    Rectangle {
        anchors.fill: parent
        color: Constants.primaryColor
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

    function selectedExtension() {
        return fileExtensionModelId.get(listViewId.currentIndex).extension
    }
}
