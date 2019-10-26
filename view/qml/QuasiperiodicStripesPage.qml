import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "QuasiperiodicStripesPage"
    id: quasiperiodicStripesPageId
    isImageTileable: false
    canAugmentImage: false

    function drawImage() {
        imageSource = Controller.getQuasiperiodicStripesQuery(
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
            leftPadding: largePadding

            SliderSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: 1024
                stepValue: 2
                initialValue: 256
            }

            SliderSelector {
                id: quasiperiodId
                title: "Quasiperiod"
                fromValue: 2
                toValue: 256
                stepValue: 1
                initialValue: 16
                isAlwaysEven: false
                decimals: 0
            }

            SliderSelector {
                id: alphaSelectorId
                title: "Alpha"
                fromValue: 0.01
                toValue: 2.0
                stepValue: 0.01
                initialValue: 1.5
                isAlwaysEven: false
                decimals: 2
            }
        }
    }
}
