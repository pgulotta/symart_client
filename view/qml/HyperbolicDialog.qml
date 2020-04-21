import QtQuick 2.12
import QtQuick.Layouts 1.3

MovableDialog {
    id: hyperbolicDialogId

    property alias sizeSelection: sizeSelectorId.dimension
    property alias projectionSelection: projectionSelectorId.selectorIndex

    title: qsTr("Hyperbolic Image")
    x: 0

    RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
            Layout.alignment: Qt.AlignHCenter
            SliderSelector {
                id: sizeSelectorId
                title: qsTr("Size")
                fromValue: 2
                toValue: maxImageDimension
                initialValue: defaultImageDimension
                isAlwaysEven: true
            }
            TumblerSelector {
                id: projectionSelectorId
                title: qsTr("Projection")
                selectorModel: ImmutableList.projectionTypes()
                width: sizeSelectorId.width
                height: width * 0.8
                onSelectorModelChanged: selectorIndex = 0
            }
        }
    }
}
