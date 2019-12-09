import QtQuick 2.13

SelectorGroupBox {
    id: colorSelectorId
    focus: true

    property alias selectedColor1: colorSelector1Id.selectedColor
    property alias selectedColor2: colorSelector2Id.selectedColor
    property alias selectedColor3: colorSelector3Id.selectedColor

    title: "Colors"

    Column {
        id: colorsColumnId
        spacing: 0

        ColorSelector {
            id: colorSelector1Id
            width: 80
            height: 32
            selectedColor: "#FFFF00"
        }

        ColorSelector {
            id: colorSelector2Id
            width: 80
            height: 32
            selectedColor: "#FF00FF"
        }

        ColorSelector {
            id: colorSelector3Id
            width: 80
            height: 32
            selectedColor: "#00FFFF"
        }
    }
}
