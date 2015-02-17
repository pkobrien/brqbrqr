import QtQuick 2.4
import Box2D 2.0 as B2
import "../gameframe" as GF

GF.KinematicBody {
    id: bat

    property real friction: 0
    property real _minX: 0
    property real _maxX: parent.width - bat.width
    property real _initY: -1

    function bump() {
        console.log("bump:", y, _initY)
        if (y !== _initY) {
            return;
        }
        bat.linearVelocity.y = -2;
    }

    function hit(ball, impulse) {
//        ball.linearVelocity.y = -Math.max(ball.linearVelocity.y, ball.minLinearVelocityY)
//        var location = ball.worldCenter;  //ball.getWorldCenter();
//        ball.applyLinearImpulse(impulse, location);
    }

    function position(newX) {
        bat.x = Math.min(Math.max(newX, bat._minX), bat._maxX);
    }

    function synch(mouse) {
        var newX = mouse.x - bat.width / 2;
        bat.position(newX);
    }

    width: 80
    height: 20

    onYChanged: {
        if (_initY < 0) {
            _initY = y;
            return;
        }
        if (y < _initY - height / 2) {
            y = _initY;
            linearVelocity.y = 0;
        }
    }

    fixtures: [
        B2.Circle {
            id: leftCircle
            radius: bat.height / 2
            x: 0
            friction: bat.friction
            restitution: 1
            onBeginContact: {
                visualLeftCircle.border.width += 3;
            }
            onEndContact: {
                visualLeftCircle.border.width -= 3;
                var impulse = Qt.point(-0.1, -0.5);
                bat.hit(other.getBody().target, impulse);
            }
        },
        B2.Box {
            id: box
            width: bat.width - (leftCircle.radius + rightCircle.radius)
            height: bat.height * 0.75
            x: leftCircle.radius
            y: bat.height * 0.25
            friction: bat.friction
            restitution: 1
            onBeginContact: {
                visualBox.border.width += 3;
            }
            onEndContact: {
                visualBox.border.width -= 3;
                var impulse = Qt.point(0, -0.1);
                bat.hit(other.getBody().target, impulse);
            }
        },
        B2.Circle {
            id: rightCircle
            radius: bat.height / 2
            x: leftCircle.radius + box.width - rightCircle.radius
            friction: bat.friction
            restitution: 1
            onBeginContact: {
                visualRightCircle.border.width += 3;
            }
            onEndContact: {
                visualRightCircle.border.width -= 3;
                var impulse = Qt.point(0.1, -0.5);
                bat.hit(other.getBody().target, impulse);
            }
        }
    ]

    Rectangle {
        id: visualBox
        width: box.width
        height: box.height
        x: box.x
        y: box.y
        border { color: "Yellow"; width: 1 }
        color: "Black"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "Red" }
            GradientStop { position: 1.0; color: "Black" }
        }
        radius: 0
    }

    Rectangle {
        id: visualLeftCircle
        width: leftCircle.radius * 2
        height: width
        x: leftCircle.x
        y: leftCircle.y
        border { color: "Yellow"; width: 1 }
        color: "Black"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "Red" }
            GradientStop { position: 1.0; color: "Black" }
        }
        radius: leftCircle.radius
        rotation: -45
    }

    Rectangle {
        id: visualRightCircle
        width: rightCircle.radius * 2
        height: width
        x: rightCircle.x
        y: rightCircle.y
        border { color: "Yellow"; width: 1 }
        color: "Black"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "Red" }
            GradientStop { position: 1.0; color: "Black" }
        }
        radius: rightCircle.radius
        rotation: 45
    }
}
