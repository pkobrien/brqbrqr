import QtQuick 2.4
import Box2D 2.0 as B2
import "../gameframe" as GF

GF.KinematicBody {
    id: brick

    property bool broken: strength <= 0 ? true : false
    property color color: "Green"
    property int points: 5
    property int strength: 5

    objectName: "brick"
    width: 20
    height: 20

    fixtures: B2.Box {
        id: box
        width: brick.width
        height: brick.height
        density: 1
        friction: 0
        onEndContact: {
            var name = other.getBody().target.objectName;
            if (name === "ball" || name === "SystemBall") {
                brick.strength--;
                visual.border.width++;
            }
        }
    }

    onBrokenChanged: {
        brick.body.destroy();
        // TODO Add points to a game score, or emit a signal or something.
    }

    Rectangle {
        id: visual
        width: brick.width
        height: brick.height
        border { color: Qt.lighter(color); width: 2 }
        color: brick.color
        gradient: Gradient {
            GradientStop { position: 0.0; color: brick.color }
            GradientStop { position: 1.0; color: "Black" }
        }
        radius: 2
    }

    PropertyAnimation {
        target: brick
        property: "opacity"
        duration: 1000
        to: 0
        easing.type: Easing.OutInBounce
        running: brick.broken
        onRunningChanged: {
            if (!running)
                brick.destroy();
        }
    }
}
