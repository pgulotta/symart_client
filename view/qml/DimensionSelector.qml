import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import com.twentysixapps.constants 1.0

GroupBox {
    id: dimensionLabelId
    title: "Dimension"
    property alias dimension:  sizeSliderId.value
    Column {
        TextField {
            text: sizeSliderId.value
            horizontalAlignment: Text.AlignHCenter
            Layout.leftMargin: mediumPadding
            onTextChanged: {
                var v = parseInt(text)
                sizeSliderId.value = v + (v % 2)
            }
        }

        Slider {
            id: sizeSliderId
            from: 2
            to: 1000
            value: 256
            live: false
            stepSize: 2
            snapMode: Slider.SnapAlways
            width: parent.width
        }
    }
}
