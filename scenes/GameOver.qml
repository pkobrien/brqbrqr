import QtQuick 2.4
import "../gameframe" as GF

GF.Scene {
    id: scene

    anchors.fill: parent

    Rectangle {
        color: "Black"
        anchors.fill: parent
    }

    Text {
        color: "White"
        anchors.centerIn: parent
        text: "Game Over! Click anywhere to quit."
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            scene.finished();
        }
    }
}
