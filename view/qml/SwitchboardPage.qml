import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3

import TopicMetaDataModel 1.0
import com.twentysixapps.symart.constants 1.0

GridView {
    id: switchboardPageId

    property string cellBackColor: Material.primary
    objectName: "SwitchboardPage"

    property int switchboardColumnCount: isWideWidth ? (isMobileDevice ? 3 : 4) : (isMobileDevice ? 2 : 3)
    property int switchboardCellWidth: windowWidth / switchboardColumnCount * 0.92
    property int switchboardCellHeight: switchboardCellWidth
    property int imageCellHeight: switchboardCellWidth * .8
    readonly property int animationDeltaX: rectRadius

    cellWidth: switchboardCellWidth + mediumPadding
    cellHeight: switchboardCellHeight + mediumPadding
    width: Math.min(model.count, switchboardColumnCount) * cellWidth
    height: pageHeight
    anchors.left: parent.left
    anchors.leftMargin: (windowWidth + mediumPadding - (cellWidth * switchboardColumnCount)) / 2
    anchors.topMargin: mediumPadding
    anchors.top: parent.top
    topMargin: mediumPadding
    bottomMargin: mediumPadding
    model: TopicsMetaData

    transitions: [
        Transition {
            NumberAnimation {
                target: switchboardPageId
                from: 0
                to: 1
                properties: "opacity"
                duration: longAnimationDuration
                easing.type: Easing.Linear
            }
        }
    ]

    delegate: Component {
        Rectangle {
            id: switchboardDelegateId
            width: switchboardCellWidth
            height: switchboardCellHeight
            visible: true
            color: cellBackColor
            radius: rectRadius
            SequentialAnimation on x {

                id: hoverAnimationId
                running: false
                loops: 1
                NumberAnimation {
                    from: x
                    to: x + animationDeltaX
                    duration: 100
                    easing.type: Easing.Linear
                }
                NumberAnimation {
                    from: x + animationDeltaX
                    to: x - animationDeltaX
                    duration: 100
                    easing.type: Easing.Linear
                }
                NumberAnimation {
                    from: x - animationDeltaX
                    to: x
                    duration: 100
                    easing.type: Easing.Linear
                }
            }
            MouseArea {
                height: parent.height
                width: parent.width
                hoverEnabled: true
                onClicked: {
                    Controller.initialize()
                    var item = pushSource(model.pageSource)
                    item.topicMetaDataModel = model
                }
                onHoveredChanged: {
                    if (containsMouse)
                        hoverAnimationId.running = true
                    switchboardDelegateId.color
                            = containsMouse ? Constants.foreColor : cellBackColor
                }
            }
            Item {
                id: columnDelegateId
                anchors.fill: parent
                visible: true
                Image {
                    id: selectableImageId
                    source: model.imageSource
                    height: imageCellHeight
                    width: height
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                }
                Label {
                    text: model.title
                    font.pointSize: mediumLargeFontPointSize
                    color: Material.accent
                    wrapMode: Label.WordWrap
                    anchors.centerIn: parent
                }
            }
        }
    }
}
