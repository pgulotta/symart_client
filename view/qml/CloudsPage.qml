import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "CloudsPage"
    id: cloudsPageId
    shouldTileImage: true

    function drawImage() {
        imageSource = Controller.getCloudsQuery(
                    dimensionSelectorId.dimension,
                    symmetrySelectorId.selectorIndex)
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension + ", "
                + symmetrySelectorId.title + "=" + ImmutableList.symmetryGroups(
                    )[symmetrySelectorId.selectorIndex]
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
                isAlwaysEven: true
            }
            TumblerSelector {
                id: symmetrySelectorId
                title: "Symmetry"
                selectorModel: ImmutableList.symmetryGroups()
                width: dimensionSelectorId.width
                height: width * 1.2
            }

            ColorSelector {
                id: colorSelecto1rId
                title: "Color 1"
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
                selectedColor: "#FFFF00"
            }
            ColorSelector {
                id: colorSelector2Id
                title: "Color 2"
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
                selectedColor: "#FF00FF"
            }
            ColorSelector {
                id: colorSelector3Id
                title: "Color 3"
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
                selectedColor: "#00FFFF"
            }
        }
    }
}
