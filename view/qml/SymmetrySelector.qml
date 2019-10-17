import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

SelectorGroupBox {
    id: symmetryLabelId
    property alias tumblerIndex: symmetrytumblerId.currentIndex
    title: "Symmetry"

    Tumbler {
        id: symmetrytumblerId
        implicitHeight: parent.height
        wrap: true
        model: ImmutableList.symmetryGroups()
        onModelChanged: currentIndex = model.length / 2
        width: symmetryLabelId.width * .9
        delegate: Text {
            text: modelData
            horizontalAlignment: Text.AlignHCenter
            color: Material.foreground
            opacity: 1.0 - Math.abs(
                         Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2.3)
            verticalAlignment: Text.AlignVCenter
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
