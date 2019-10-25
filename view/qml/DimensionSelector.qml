import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: dimensionLabelId

    property real fromValue
    property real toValue
    property real stepValue
    property real initialValue
    property bool isAlwaysEven

    property alias dimension: sizeSliderId.value

    title: "Dimension"

    Column {
        TextField {
            id: sizeTextId
            horizontalAlignment: Text.AlignHCenter
            Layout.leftMargin: mediumPadding
            onTextChanged: {
                if (isAlwaysEven) {
                    var v = parseInt(text)
                    sizeSliderId.value = v + (v % 2)
                }
            }
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
            onValueChanged: sizeTextId.text = value
        }
    }
}
