import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

SelectorGroupBox {
    id: selectorGroupBoxlId

    property alias tumblerModel: tumblerId.model
    property alias tumblerIndex: tumblerId.currentIndex

    Tumbler {
        id: tumblerId
        implicitHeight: parent.height
        wrap: true
        onModelChanged: currentIndex = model.length / 2
        width: selectorGroupBoxlId.width * .9
        delegate: Text {
            text: modelData
            horizontalAlignment: Text.AlignHCenter
            color: Material.foreground
            opacity: 1.0 - Math.abs(
                         Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount * 0.5)
            verticalAlignment: Text.AlignVCenter
        }

        onCurrentIndexChanged: {
            currentItem.opacity = 1.0
            forceActiveFocus()
        }

        Keys.onUpPressed: {
            increaseIndex()
        }
        Keys.onDownPressed: {
            decreaseIndex()
        }
        function decreaseIndex() {
            currentIndex = (currentIndex - 1 < 0) ? currentIndex = model.length
                                                    - 1 : currentIndex - 1
        }
        function increaseIndex() {
            currentIndex = (currentIndex + 1 >= model.length) ? 0 : currentIndex + 1
        }
    }
}
