import QtQuick 2.4
import "../content" as Brq

Item {
    id: bat

    property real duration: 2
    property real maxX: parent.width - bat.width

    function move(distance) {
        var newX = bat.x + distance;
        bat.position(newX);
    }

    function position(newX) {
        bat.x = Math.min(Math.max(newX, 0), bat.maxX);
    }

    function synch(mouse) {
        var newX = mouse.x - bat.width / 2;
        bat.position(newX);
    }

    width: 80
    height: 8

    Behavior on x { PropertyAnimation{ duration: bat.duration } }

    Rectangle {
        id: visual
        anchors.fill: bat
        border { color: "Yellow"; width: 1 }
        color: "Black"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "Red" }
            GradientStop { position: 1.0; color: "Black" }
        }
        radius: 1
    }
}
