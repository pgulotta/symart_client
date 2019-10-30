import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "CloudsPage"
    id: cloudsPageId
    shouldTileImage: true
    canAugmentImage: false

    function drawImage() {
        imageSource = Controller.getWalkImageQuery(
                    widthSelectorId.dimension, heightSelectorId.dimension,
                    fillModeSelectorId.selectorIndex, balancedSwitchId.checked,
                    tileableSwitchId.checked)
    }

    function selectionDescription() {
        return widthSelectorId.title + "=" + widthSelectorId.dimension
                + ", " + heightSelectorId.title + "=" + heightSelectorId.dimension
                + ", " + fillModeSelectorId.title + "=" + ImmutableList.walkFillModes(
                    )[fillModeSelectorId.selectorIndex] + ", "
                + balancedSwitchId.text + "=" + balancedSwitchId.checked + ", "
                + tileableSwitchId.text + "=" + tileableSwitchId.checked
    }

    controlsView: RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
            leftPadding: largePadding

            SliderSelector {
                id: widthSelectorId
                title: "Width"
                fromValue: 2
                toValue: 1024
                stepValue: 2
                initialValue: 256
                isAlwaysEven: false
            }
            SliderSelector {
                id: heightSelectorId
                title: "Height"
                fromValue: 2
                toValue: 1024
                stepValue: 2
                initialValue: 256
                isAlwaysEven: false
            }
            TumblerSelector {
                id: fillModeSelectorId
                title: "Fill Mode"
                selectorModel: ImmutableList.walkFillModes()
                width: widthSelectorId.width
                height: width
            }
            Switch {
                id: balancedSwitchId
                text: qsTr("Balanced")
                checked: true
            }
            Switch {
                id: tileableSwitchId
                text: qsTr("Tile-able")
                checked: true
                onCheckedChanged: {
                    isImageTileable = checked
                    shouldTileImage = checked
                    drawImage()
                }
            }
        }
    }
}
