import QtQuick 2.4
import "../gameframe" as GF

GF.Scene {
    id: scene

    property int level: 0

    anchors.fill: parent

    signal nextScene()

    Rectangle {
        color: "Black"
        anchors.fill: parent
    }

    Text {
        color: "White"
        anchors.centerIn: parent
        text: "Level " + level + " completed! Click anywhere for next level."
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            nextScene();
        }
    }
}
