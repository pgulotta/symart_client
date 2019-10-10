import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import com.twentysixapps.constants 1.0

Text {
    text: formatNumber(modelData)
    color: Material.foreground
    opacity: 1.0 - Math.abs(
                 Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    function formatNumber(number) {
        console.log("formatNumber:  " + number)
        return number < 10 && number >= 0 ? "0" + number : number.toString()
    }
}
