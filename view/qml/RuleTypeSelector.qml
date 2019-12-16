import QtQuick 2.14
import QtQuick.Controls 2.14

SelectorGroupBox {
    id: selectorGroupBoxlId

    property int initialIndex: 0
    property alias selectorIndex: tumblerId.selectorIndex
    property alias weight: weightId.text
    property alias usePastelColors: usePastelColorsId.checked

    focus: true
    title: qsTr("Rule Type")
    width: 190
    Column {
        id: columnId
        Row {
            id: rowId
            focus: true
            TumblerSelector {
                id: tumblerId
                title: qsTr("Type")
                selectorModel: ImmutableList.ruleTypes()
                height: 110
                width: selectorGroupBoxlId.width * .55
                onSelectorModelChanged: selectorIndex = initialIndex
            }
            Column {
                leftPadding: largePadding
                Label {
                    text: qsTr("Weight")
                }
                NumericInput {
                    id: weightId
                    canEdit: true
                    text: "1"
                    defaultText: "1"
                    minumumValue: 0
                }
            }
        }
        Switch {
            id: usePastelColorsId
            width: columnId.width
            text: qsTr("Use Pastels")
            checked: false
        }
    }

    function getRuleName() {
        return ImmutableList.ruleTypes()[selectorIndex]
    }
}
