import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

GroupBox {
    id: symmetryLabelId
    property alias symmetryIndex: symmetrytumblerId.currentIndex
    title: "Symmetry"
    Tumbler {
        id: symmetrytumblerId
        implicitHeight: parent.height
        model: ImmutableList.symmetryGroups()
        width: symmetryLabelId.width * .9
        delegate: Text {
            text: modelData
            horizontalAlignment: Text.AlignHCenter

            color: Material.foreground
            opacity: 1.0 - Math.abs(
                         Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2.3)
            verticalAlignment: Text.AlignVCenter
        }
    }
}
