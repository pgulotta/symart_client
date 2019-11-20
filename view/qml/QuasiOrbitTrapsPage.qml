import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "QuasiOrbitTrapsPage"
    id: quasiOrbitTrapsPageId
    shouldTileImage: false
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
            spacing: largePadding
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
            SliderSelector {
                id: quasiperiodSelectorId
                title: "Quasiperiod"
                fromValue: 1
                toValue: 1024
                stepValue: 1
                initialValue: 100
                isAlwaysEven: false
            }
        }
    }


}

