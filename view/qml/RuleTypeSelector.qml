import QtQuick 2.13
import QtQuick.Controls 2.5

SelectorGroupBox {
    id: selectorGroupBoxlId

    property int initialIndex: 0
    property alias selectorIndex: tumblerId.selectorIndex
    property alias weight: weightId.text
    property alias usePastelColors: usePastelColorsId.checked

    focus: true
    title: qsTr("Rule Type")

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
                width: selectorGroupBoxlId.width * .5
                onSelectorModelChanged: selectorIndex = initialIndex
            }
            Column {
                leftPadding: exlargePadding
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
            width: 200
            text: qsTr("Use Pastel Colors")
            checked: false
        }
    }

    function getRuleName() {
        return ImmutableList.ruleTypes()[selectorIndex]
    }
}
