import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: dimensionLabelId

    property int fromValue
    property int toValue
    property alias dimension: sizeSliderId.value

    title: "Dimension"

    Column {
        TextField {
            id: sizeTextId
            horizontalAlignment: Text.AlignHCenter
            Layout.leftMargin: mediumPadding
            onTextChanged: {
                var v = parseInt(text)
                sizeSliderId.value = v + (v % 2)
            }
        }

        Slider {
            id: sizeSliderId
            from: fromValue
            to: toValue
            value: toValue / 4
            live: false
            stepSize: 2
            snapMode: Slider.SnapAlways
            width: parent.width
            onValueChanged: sizeTextId.text = value
        }
    }
}
