import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Pane {
    id: root

    property variant color: red
    property bool active: false
    function inactive() {
        active = false
    }

    onActiveChanged: {
        if(active) {
            buttonActiveAnimation.running = true
        }
        else {
            buttonInactiveAnimation.running = true
        }
    }

    Layout.fillWidth: true
    Rectangle {
        id: firstColorButton
        anchors.centerIn: parent
        width: buttonsSize
        height: width
        color: root.color
        radius: width/2
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(active) {
                    active = false
                }
                else {
                    active = true
                }


            }
        }
        NumberAnimation {
            id: buttonActiveAnimation
            target: firstColorButton
            property: "scale"
            from: 1
            to: 1.3
            duration: 200
        }
        NumberAnimation {
            id: buttonInactiveAnimation
            target: firstColorButton
            property: "scale"
            from: 1.3
            to: 1
            duration: 200
        }

    }
}
