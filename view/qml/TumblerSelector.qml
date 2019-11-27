import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

SelectorGroupBox {
    id: selectorGroupBoxlId
    focus: true

    property alias selectorModel: tumblerId.model
    property alias selectorIndex: tumblerId.currentIndex

    Tumbler {
        id: tumblerId
        implicitHeight: parent.height
        wrap: true
        onModelChanged: currentIndex = model.length / 3
        width: selectorGroupBoxlId.width * .9
        delegate: Text {
            id: delegateId
            text: modelData
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: Material.foreground
            opacity: (tumblerId.count < 3) ? 1.0 : 1.0 - Math.abs(
                                                 Tumbler.displacement)
                                             / (Tumbler.tumbler.visibleItemCount * 0.25)
        }

        onCurrentIndexChanged: forceActiveFocus()

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
