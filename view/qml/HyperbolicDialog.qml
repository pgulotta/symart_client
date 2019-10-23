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

    property alias sizeSelection: sizeSelectorId.dimension
    property alias projectionSelection: projectionSelectorId.selectorIndex

    title: "Hyperbolic Image"
    modal: true
    standardButtons: Dialog.Cancel | Dialog.Ok
    clip: true

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
                id: sizeSelectorId
                title: "Size"
                fromValue: 2
                toValue: 1024
            }
            TumblerSelector {
                id: projectionSelectorId
                title: "Projection"
                selectorModel: ImmutableList.projectionTypes()
                width: sizeSelectorId.width
                height: width
            }
        }
    }

    function openDialog() {
        dialogId.open()
    }
}
