import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

GroupBox {
    id: symmetryLabelId
    property alias symmetryIndex: symmetrytumblerId.currentIndex
    title: "Symmetry"
    font.bold: activeFocus
    font.italic: activeFocus

    Tumbler {
        id: symmetrytumblerId
        implicitHeight: parent.height
        wrap: true
        model: ImmutableList.symmetryGroups()
        width: symmetryLabelId.width * .9
        focusPolicy: Qt.StrongFocus
        delegate: Text {
            text: modelData
            horizontalAlignment: Text.AlignHCenter
            color: Material.foreground
            opacity: 1.0 - Math.abs(
                         Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2.3)
            verticalAlignment: Text.AlignVCenter
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
