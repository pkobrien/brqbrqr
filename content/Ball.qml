import QtQuick 2.4
import Box2D 2.0 as B2
import "../gameframe" as GF

GF.DynamicBody {
    id: ball

    property real radius: 10

    angularDamping: 0.5
    objectName: "ball"
    sleepingAllowed: false

    fixtures: B2.Circle {
        id: circle
        radius: ball.radius
        x: -radius
        y: -radius
        density: 1
        friction: 0.01
        restitution: 1
    }

    Rectangle {
        id: visual
        width: ball.radius * 2
        height: width
        anchors.centerIn: ball
        border.color: "Yellow"
        border.width: 1
        color: "White"
        radius: width / 2
        smooth: true
        gradient: Gradient {
            GradientStop { position: 0.0; color: "Yellow" }
            GradientStop { position: 1.0; color: "Black" }
        }
    }
}
