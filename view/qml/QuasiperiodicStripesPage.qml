import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "QuasiperiodicStripesPage"
    id: quasiperiodicStripesPageId
    isImageTileable: false
    canAugmentImage: false

    function drawImage() {
        Controller.generateQuasiperiodicStripesImage(
                    dimensionSelectorId.dimension, quasiperiodId.dimension,
                    alphaSelectorId.dimension)
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension
                + ", " + quasiperiodId.title + "=" + quasiperiodId.dimension
                + ", " + alphaSelectorId.title + "=" + alphaSelectorId.dimension
    }

    controlsView: RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
            leftPadding: mediumPadding

            SliderSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: maxImageDimension
                stepValue: 1
                initialValue: defaultImageDimension
            }

            SliderSelector {
                id: quasiperiodId
                title: qsTr("Quasiperiod")
                fromValue: 2
                toValue: 64
                stepValue: 1
                initialValue: 16
                isAlwaysEven: false
                decimals: 0
            }

            SliderSelector {
                id: alphaSelectorId
                title: qsTr("Alpha Blending")
                fromValue: 0.04
                toValue: 2.0
                stepValue: 0.1
                initialValue: 1.5
                isAlwaysEven: false
                decimals: 2
            }
        }
    }
}
