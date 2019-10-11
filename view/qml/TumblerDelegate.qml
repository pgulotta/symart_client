import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

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
