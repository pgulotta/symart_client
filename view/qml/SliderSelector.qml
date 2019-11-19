import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import com.twentysixapps.constants 1.0

// re:  https://www.labnol.org/home/hue-saturation-luminosity/20104/
SelectorGroupBox {
    id: sliderSelectorId

    property real fromValue
    property real toValue
    property real stepValue
    property real initialValue
    property bool isAlwaysEven: true
    property int decimals: 0

    property alias dimension: sizeTextId.text

    title: "Size"

    Column {
        TextField {
            id: sizeTextId
            overwriteMode: true
            selectByMouse: true
            horizontalAlignment: Text.AlignHCenter
            Layout.leftMargin: mediumPadding
            onTextChanged: sizeSliderId.value = formatValue(text)
        }

        Slider {
            id: sizeSliderId
            from: fromValue
            to: toValue
            value: initialValue
            live: false
            stepSize: stepValue
            snapMode: Slider.SnapAlways
            width: parent.width
            onValueChanged: sizeTextId.text = formatValue(value)
            enabled: sliderSelectorId.enabled
        }
    }

    function formatValue(unformattedValue) {
        var formattedValue
        if (isAlwaysEven) {
            var v = parseFloat(unformattedValue)
            formattedValue = v + (v % 2)
        } else
            formattedValue = parseFloat(unformattedValue)
        return formattedValue.toFixed(decimals)
    }
}
