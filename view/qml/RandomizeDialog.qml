import QtQuick 2.12
import QtQuick.Window 2.11
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0
import com.twentysixapps.constants 1.0

Item {
    visible: false

    Dialog {
        id: dialogId
        title: "Randomize"
        modal: true
        standardButtons: Dialog.Cancel | Dialog.Ok
        clip: true
        //onAccepted:
        enter: EnterTransition {}

        exit: ExitTransition {}

        RowLayout {
            id: controlsViewId
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            Column {
                spacing: exlargePadding
                leftPadding: largePadding

                DimensionSelector {
                    id: xSelectorId
                    title: "X"
                }
                DimensionSelector {
                    id: ySelectorId
                    title: "Y"
                }
            }
        }
    }
    function openDialog() {
        dialogId.open()
    }
}
