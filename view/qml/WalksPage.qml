import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "WalksPage"
    id: cloudsPageId
    shouldTileImage: true
    canAugmentImage: false

    function drawImage() {
        Controller.generateWalkImage(widthSelectorId.dimension,
                                     heightSelectorId.dimension,
                                     fillModeSelectorId.selectorIndex,
                                     balancedSwitchId.checked,
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
            spacing: largePadding
            leftPadding: mediumPadding

            SliderSelector {
                id: widthSelectorId
                title: qsTr("Width")
                fromValue: 2
                toValue: maxImageDimension
                stepValue: 1
                initialValue: defaultImageDimension
                isAlwaysEven: false
            }
            SliderSelector {
                id: heightSelectorId
                title: qsTr("Height")
                fromValue: 2
                toValue: maxImageDimension
                stepValue: 1
                initialValue: defaultImageDimension
                isAlwaysEven: false
            }
            TumblerSelector {
                id: fillModeSelectorId
                title: qsTr("Fill Mode")
                selectorModel: ImmutableList.walkFillModes()
                width: widthSelectorId.width
                height: heightSelectorId.height * 0.8
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
