import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "script.js" as MyScript


ApplicationWindow {
    function newColorGenerate() {
        resetButtons()
        var newColor = MyScript.generateColorFromSet(firstColorButton.color,
                                                     secondColorButton.color,
                                                     thirdColorButton.color,
                                                     2,
                                                     Qt.rgba)
        if(newColor == colorBox.color) {
            newColorGenerate()
        }
        else {
            colorBox.color = newColor
        }
    }

    signal resetButtons()

    onResetButtons: {
        firstColorButton.inactive()
        secondColorButton.inactive()
        thirdColorButton.inactive()
    }


    id: root
    visible: true
    width: 200
    height: 480
    title: qsTr("Hello World")

    property color red: Qt.rgba(1,0,0)
    property color green: Qt.rgba(0,1,0)
    property color blue: Qt.rgba(0,0,1)

    property int buttonsSize: root.width/6

    function colorSum() {
        if(firstColorButton.active) {
            if(secondColorButton.active) {
                if(thirdColorButton.active) {
                    return MyScript.colorSum(firstColorButton.color, secondColorButton.color, thirdColorButton.color, Qt.rgba)
                }
                else {
                    return MyScript.colorSum(firstColorButton.color, secondColorButton.color, Qt.rgba)
                }
            }
            else if(thirdColorButton.active) {
                return MyScript.colorSum(firstColorButton.color, thirdColorButton.color, Qt.rgba)
            }
            else {
                return MyScript.colorSum(firstColorButton.color, Qt.rgba)
            }
        }
        else if(secondColorButton.active) {
            if(thirdColorButton.active) {
                return MyScript.colorSum(secondColorButton.color, thirdColorButton.color, Qt.rgba)
            }
            else {
                return MyScript.colorSum(secondColorButton.color, Qt.rgba)
            }
        }
        else if(thirdColorButton.active) {
            return MyScript.colorSum(thirdColorButton.color, Qt.rgba)
        }

        return MyScript.colorSum(Qt.rgba)
    }

    header: ToolBar {
        id: toolBar
        RowLayout {
            anchors.fill: parent
            ToolButton {
                text: qsTr("...")
            }
            Item {
                Layout.fillWidth: true
                Label {
                    anchors.centerIn: parent
                    text: qsTr("COLOROPUS")
                    font.pointSize: 12
                    font.bold: true
                }
            }
            ToolButton {
                text: qsTr("-")
            }
        }
    }

    Label {
        id: resultLabel

        anchors.centerIn: parent
        text: qsTr("GREAT!")
        font.bold: true
        scale: 2
        z: 50

        SequentialAnimation {
            id: resultLabelAnimation
            running: true
            ParallelAnimation {
                SequentialAnimation {
                    NumberAnimation {
                        target: resultLabel
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 300
                    }
                    PauseAnimation {
                        duration: 400
                    }
                    NumberAnimation {
                        target: resultLabel
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 300
                    }
                }

                NumberAnimation {
                    target: resultLabel
                    property: "scale"
                    from: 1
                    to: 2
                    duration: 1000
                }
            }
        }

    }

    ColumnLayout {
        anchors.fill: parent

        Pane {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Grid {
                id: grid
                spacing: 0
                anchors.fill: parent
                columns: Math.floor(Math.sqrt(repeater.model))
                Repeater {
                    id: repeater
                    model: 10000
                    Rectangle {
                        width: grid.width / grid.columns
                        height: width
                        color: MyScript.getRandomColor(Qt.rgba)
                    }
                }
            }
        }

        Pane {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                id: colorBox
                width: Math.min(parent.width, parent.height)/2
                height: width
                anchors.centerIn: parent
                border.width: 1
                border.color: "black"
                //radius: width/2

                Image {
                    anchors.fill: parent
                    source: "2fons.ru-17444.png"
                    fillMode: Image.Tile
                }
            }
        }

        Pane {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                id: addedColorBox
                width: Math.min(parent.width, parent.height)/2
                height: width
                anchors.centerIn: parent
                color: colorSum()
                border.width: 1
                border.color: "black"
                radius: width/2
                onColorChanged: {
                    if(colorBox.color == addedColorBox.color) {
                        resultLabelAnimation.running = false
                        resultLabelAnimation.running = true
                        newColorGenerate()
                    }
                }
            }
        }

        Pane {
            Layout.fillWidth: true
            RowLayout {
                anchors.fill: parent
                ColorButton {
                    id: firstColorButton
                    color: Qt.rgba(250/255, 128/255, 114/255, 1)
                }
                ColorButton {
                    id: secondColorButton
                    color: Qt.rgba(107/255, 142/255, 35/255, 1)
                }
                ColorButton {
                    id: thirdColorButton
                    color: Qt.rgba(70/255, 130/255, 180/255, 1)
                }
            }
        }
    }
}
