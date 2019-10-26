import QtQuick 2.12
import QtQuick.Window 2.11
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0
import com.twentysixapps.constants 1.0

Dialog {
    id: dialogId

    title: "Save Image As"
    height: dialogHeight
    width: dialogWidth
    modal: true
    focus: true

    standardButtons: Dialog.Cancel | Dialog.Ok

    enter: EnterTransition {
        itemHeight: 425
        itemWidth: 325
    }

    exit: ExitTransition {}

    Component.onCompleted: listViewId.forceActiveFocus()

    ListModel {
        id: fileExtensionModelId
        ListElement {
            name: "BMP: Windows Bitmap"
            extension: "bmp"
        }
        ListElement {
            name: "JPG: Joint Photographic Experts Group"
            extension: "jpg"
        }
        ListElement {
            name: "JPEG: Joint Photographic Experts Group"
            extension: "jpeg"
        }
        ListElement {
            name: "PNG :Portable Network Graphics"
            extension: "png"
        }
        ListElement {
            name: "PPM: Portable Pixmap"
            extension: "ppm"
        }
        ListElement {
            name: "XBM: X11 Bitmap"
            extension: "xbm"
        }
        ListElement {
            name: "XPM: X11 Pixmap"
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

    function openDialog() {
        dialogId.open()
    }

    function selectedExtension() {
        return fileExtensionModelId.get(listViewId.currentIndex).extension
    }
}
