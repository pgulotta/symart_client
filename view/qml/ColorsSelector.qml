import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: colorSelectorId
    focus: true

    property alias selectedColor1: colorSelector1Id.selectedColor
    property alias selectedColor2: colorSelector2Id.selectedColor
    property alias selectedColor3: colorSelector3Id.selectedColor

    title: "Colors"

    Column {
        id: colorsColumnId
        spacing: mediumPadding

        ColorSelector {
            id: colorSelector1Id
            width: 80
            height: 40
        }

        ColorSelector {
            id: colorSelector2Id
            width: 80
            height: 40
        }

        ColorSelector {
            id: colorSelector3Id
            width: 80
            height: 40
        }
    }
}
