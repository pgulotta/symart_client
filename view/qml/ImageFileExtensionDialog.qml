import QtQuick 2.13
import QtQuick.Controls 2.4
import com.twentysixapps.constants 1.0

MovableDialog {
    id: imageFileExtensionDialogId

    title: qsTr("Save Image As")
    height: 400
    width: 300

    enter: EnterTransition {
        itemHeight: imageFileExtensionDialogId.height
        itemWidth: imageFileExtensionDialogId.width
    }
    Component.onCompleted: listViewId.forceActiveFocus()

    ListModel {
        id: fileExtensionModelId
        ListElement {
            name: qsTr("BMP: Windows Bitmap")
            extension: "bmp"
        }
        ListElement {
            name: qsTr("JPG: Joint Photographic Experts Group")
            extension: "jpg"
        }
        ListElement {
            name: qsTr("JPEG: Joint Photographic Experts Group")
            extension: "jpeg"
        }
        ListElement {
            name: qsTr("PNG :Portable Network Graphics")
            extension: "png"
        }
        ListElement {
            name: qsTr("PPM: Portable Pixmap")
            extension: "ppm"
        }
        ListElement {
            name: qsTr("XBM: X11 Bitmap")
            extension: "xbm"
        }
        ListElement {
            name: qsTr("XPM: X11 Pixmap")
            extension: "xpm"
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Constants.primaryColor

        ListView {
            id: listViewId
            keyNavigationWraps: true
            anchors.fill: parent
            anchors.margins: smallPadding
            anchors.topMargin: smallPadding
            spacing: mediumPadding
            model: fileExtensionModelId
            clip: true
            focus: true
            currentIndex: 3
            delegate: Label {
                id: delegateId
                text: name
                focus: true
                anchors.margins: smallPadding
                color: Constants.accentColor
                padding: smallPadding
                bottomPadding: smallPadding
                TapHandler {
                    onTapped: listViewId.currentIndex = index
                }
            }
            ScrollBar.vertical: ScrollBar {}
            highlight: Rectangle {
                color: Constants.accentColor
                height: listViewId.height
                width: listViewId.width
                opacity: 0.25
            }
            interactive: true
            snapMode: ListView.SnapOneItem
        }
    }

    function selectedExtension() {
        return fileExtensionModelId.get(listViewId.currentIndex).extension
    }
}
