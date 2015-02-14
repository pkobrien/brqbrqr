import QtQuick 2.4
import Box2D 2.0 as B2
import "../gameframe" as GF

GF.StaticBodyItem {
    id: bat

    property real _minX: 0
    property real _maxX: parent.width - bat.width

    function hit(ball, impulse) {
        var location = ball.body.getWorldCenter();
        ball.body.applyLinearImpulse(impulse, location);
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

    fixtures: [
        B2.Circle {
            id: leftCircle
            radius: bat.height / 2
            onBeginContact: {
                if (other.getBody().target.objectName === "ball") {
                    visualLeftCircle.border.width += 3;
                    visualLeftCircle.border.color = "Red";
                }
            }
            onEndContact: {
                if (other.getBody().target.objectName === "ball") {
                    visualLeftCircle.border.color = "Yellow";
                    visualLeftCircle.border.width -= 3;
                    var impulse = Qt.point(-0.1, -0.5);
                    bat.hit(other.getBody().target, impulse);
                }
            }
        },
        B2.Box {
            id: box
            width: bat.width - (leftCircle.radius + rightCircle.radius)
            height: bat.height * 0.75
            x: leftCircle.radius
            y: bat.height * 0.25
            friction: 0.8
            restitution: 1
            onBeginContact: {
                if (other.getBody().target.objectName === "ball") {
                    visualBox.border.width += 3;
                    visualBox.border.color = "Red";
                }
            }
            onEndContact: {
                if (other.getBody().target.objectName === "ball") {
                    visualBox.border.color = "Yellow";
                    visualBox.border.width -= 3;
                    var impulse = Qt.point(0, -0.1);
                    bat.hit(other.getBody().target, impulse);
                }
            }
        },
        B2.Circle {
            id: rightCircle
            radius: bat.height / 2
            x: leftCircle.radius + box.width - rightCircle.radius
            onBeginContact: {
                if (other.getBody().target.objectName === "ball") {
                    visualRightCircle.border.width += 3;
                    visualRightCircle.border.color = "Red";
                }
            }
            onEndContact: {
                if (other.getBody().target.objectName === "ball") {
                    visualRightCircle.border.color = "Yellow";
                    visualRightCircle.border.width -= 3;
                    var impulse = Qt.point(0.1, -0.5);
                    bat.hit(other.getBody().target, impulse);
                }
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
