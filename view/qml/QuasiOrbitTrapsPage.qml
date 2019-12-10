import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    id: quasiOrbitTrapsPageId
    objectName: "QuasiOrbitTrapsPage"
    shouldTileImage: false
    canAugmentImage: false
    isImageTileable: false

    function drawImage() {
        Controller.generateQuasiTrapImage(colorSelectorId.selectedColor,
                                          functionSelectorId.selectorIndex,
                                          widthSelectorId.dimension,
                                          heightSelectorId.dimension,
                                          symmetrySelectorId.selectorIndex,
                                          quasiperiodSelectorId.dimension)
    }

    function selectionDescription() {
        return widthSelectorId.title + "=" + widthSelectorId.dimension
                + ", " + heightSelectorId.title + "=" + heightSelectorId.dimension
                + ", " + quasiperiodSelectorId.title + "=" + quasiperiodSelectorId.dimension
                + ", " + functionSelectorId.title + "=" + ImmutableList.formTypes(
                    )[functionSelectorId.selectorIndex]
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
                title: qsTr("Width")
                fromValue: 2
                toValue: 2048
                stepValue: 1
                initialValue: 512
                isAlwaysEven: false
            }
            SliderSelector {
                id: heightSelectorId
                title: qsTr("Height")
                fromValue: 2
                toValue: 2048
                stepValue: 1
                initialValue: 512
                isAlwaysEven: false
            }
            ColorSelector {
                id: colorSelectorId
                width: 100
            }
            SliderSelector {
                id: quasiperiodSelectorId
                title: qsTr("Quasiperiod")
                fromValue: 1.00
                toValue: maxImageDimension
                stepValue: 1
                initialValue: 128.00
                isAlwaysEven: false
                decimals: 2
            }
            TumblerSelector {
                id: symmetrySelectorId
                title: qsTr("Symmetry")
                selectorModel: ImmutableList.quasiSymmetry()
                width: quasiperiodSelectorId.width
                height: quasiperiodSelectorId.height * 0.8
                onSelectorModelChanged: selectorIndex = 0
            }
            TumblerSelector {
                id: functionSelectorId
                title: qsTr("Function")
                selectorModel: ImmutableList.formTypes()
                width: quasiperiodSelectorId.width
                height: symmetrySelectorId.height
            }
        }
    }
}
