import QtQuick 2.4
import "../content" as Brq

Item {
    id: ball

    property real duration: 2
    property real xIncrement: 4
    property real yIncrement: 4

    width: 16
    height: width

    Behavior on x { PropertyAnimation{ duration: ball.duration } }
    Behavior on y { PropertyAnimation{ duration: ball.duration } }

    Rectangle {
        id: visual
        anchors.fill: ball
        border { color: "Gray"; width: 1 }
        color: "Black"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "Red" }
            GradientStop { position: 0.3; color: "Yellow" }
            GradientStop { position: 1.0; color: "Black" }
        }
        rotation: -30
        radius: width / 2
    }
}
