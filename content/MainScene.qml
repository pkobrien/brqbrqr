import QtQuick 2.4
import "../content" as Brq
import "../gameframe" as GF
import "../levels" as Levels

GF.Scene {
    id: scene

    function fail(ball) {
        ball.launched = false;
        ball.linearVelocity = Qt.point(0, 0)
        // TODO Update number of balls left to play.
        position(ball);
    }

    function launch(ball) {
        if (ball.launched) {
            return;
        }
        ball.launched = true;
        var impulse = Qt.point(0, 10);
        var location = ball.body.getWorldCenter();
        ball.body.applyLinearImpulse(impulse, location);
    }

    function position(ball) {
        ball.x = bat.x + bat.width / 2;
        ball.y = bat.y - (ball.radius * 4);
    }

    function reset() {
    }

    function start() {
        scene.world.running = true;
        launch(ball);
    }

    width: 600
    height: 500

    status: qsTr("Ball Linear Velocity: %1  Rotation: %2  X: %3  Y: %4").arg(ball.linearVelocity).arg(ball.rotation).arg(ball.x).arg(ball.y)

    world.pixelsPerMeter: 20
    world.gravity: Qt.point(0, 0)

//    world.onPreSolve: {
//        var targetA = contact.fixtureA.getBody().target;
//        var targetB = contact.fixtureB.getBody().target;
//        console.log("A:", targetA, "B:", targetB)
//        if (targetA.isBall && contact.fixtureB === topBeltFixture)
//            contact.tangentSpeed = -3.0;
//        else if (targetB.isBall && contact.fixtureA === topBeltFixture)
//            contact.tangentSpeed = 3.0;
//    }

//    world.onPostSolve: {
//        var entityA = contact.fixtureA.parent
//        var entityB = contact.fixtureB.parent
//        if (entityA.objectName === "asteroid" || entityB.objectName === "asteroid") {
//            var asteroidObject
//            if (entityA.objectName === "bullet" || entityB.objectName === "bullet") {
//                var bulletObject;
//                if (entityA.objectName === "bullet") {
//                    asteroidObject = entityB;
//                    bulletObject = entityA;
//                } else {
//                    asteroidObject = entityA;
//                    bulletObject = entityB;
//                }
//                bulletObject.destroy();
//                asteroidObject.damage();
//            }
//        }
//        console.log(entityA.objectName, entityB.objectName)
//    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: debug ? "White" : "DarkSlateGray"
    }

    Rectangle {
        id: base
        height: 8
        width: parent.width
        anchors.bottom: parent.bottom
        color: "Green"
    }

    Brq.Ball {
        id: ball
        property bool launched: false
        Component.onCompleted: position(ball);
    }

    Brq.Bat {
        id: bat
        anchors.top: level.bottom
        anchors.topMargin: 60
        x: scene.width / 2 - bat.width / 2
//        onBeginContact: console.log(other, "hit the bat");
    }

    Brq.Boundaries {
        id: boundaries
        bottomBoundary.onBeginContact: { fail(ball); base.color = "Red"; }
        bottomBoundary.onEndContact: base.color = "Yellow";
    }

    Levels.LevelOne {
        id: level
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            scene.start()
        }
        onPositionChanged: {
            bat.synch(mouse);
            if (!ball.launched) {
                position(ball);
            }
        }
    }

    Component.onCompleted: {
        scene.world.running = true;
//        console.log(1.0/60.0, world.timeStep, world.positionIterations, world.velocityIterations)
    }

    Keys.onEscapePressed: scene.world.running = !scene.world.running;
    Keys.onSpacePressed: debug = !debug;
}
