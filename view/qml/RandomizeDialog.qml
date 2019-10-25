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

    property int xSelection: 2
    property int ySelection: 2

    title: "Randomize"
    modal: true
    focus: true
    standardButtons: Dialog.Cancel | Dialog.Ok

    enter: EnterTransition {}

    exit: ExitTransition {}

    RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
            Layout.alignment: Qt.AlignHCenter
            DimensionSelector {
                id: xSelectorId
                title: "X"
                dimension: xSelection
                fromValue: 1
                toValue: 99
                initialValue: 50
                isAlwaysEven: false
            }
            DimensionSelector {
                id: ySelectorId
                title: "Y"
                dimension: ySelection
                fromValue: 1
                toValue: 99
                initialValue: 50
                isAlwaysEven: false
            }
        }
    }

    function openDialog() {
        dialogId.open()
    }
}
