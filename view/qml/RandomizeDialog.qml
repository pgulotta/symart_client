import QtQuick 2.12
import QtQuick.Layouts 1.3

MovableDialog {
    id: randomizeDialogId

    property int xSelection: 2
    property int ySelection: 2

    title: "Randomize"

    RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
            Layout.alignment: Qt.AlignHCenter
            SliderSelector {
                id: xSelectorId
                title: "X"
                dimension: xSelection
                fromValue: 1
                toValue: 99
                initialValue: 50
                isAlwaysEven: false
            }
            SliderSelector {
                id: ySelectorId
                width: xSelectorId.width
                height: xSelectorId.height
                title: "Y"
                dimension: ySelection
                fromValue: 1
                toValue: 99
                initialValue: 50
                isAlwaysEven: false
            }
        }
    }
}
