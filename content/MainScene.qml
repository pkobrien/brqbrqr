import QtQuick 2.4
import "../content" as Brq
import "../gameframe" as GF
import "../levels" as Levels

GF.Scene {
    id: scene

    property int ballCount: 3

    function fail(ball) {
        ball.launched = false;
        ball.angularVelocity = 0;
        ball.linearVelocity = Qt.point(0, 0);
        scene.ballCount--;
        position(ball);
    }

    function launch(ball) {
        if (ball.launched) {
            return;
        }
        ball.launched = true;
        var impulse = Qt.point(0, 10);
        var location = ball.body.getWorldCenter();
        ball.applyLinearImpulse(impulse, location);
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

//    status: qsTr("Ball Linear Velocity: %1  X: %2  Y: %3  [Debug: %4]  [Paused: %5]").arg(
//                 ball.linearVelocity).arg(ball.x).arg(ball.y).arg(debug).arg(!world.running)

    status: qsTr("Balls: %1  Bricks: %2  [Debug: %4]  [Paused: %5]").arg(
                 scene.ballCount).arg(level.brickCount).arg(debug).arg(!world.running)

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

    Brq.Ball {
        id: ball
        property bool launched: false
        Component.onCompleted: { scene.ballCount--; position(ball); }
    }

    Brq.Bat {
        id: bat
        x: scene.width / 2 - bat.width / 2
        y: level.height + 60
    }

    Brq.Boundaries {
        id: boundaries
        bottomBoundary.onBeginContact: fail(ball);
    }

    Levels.Level004 {
        id: level
        background.parent: scene
        background.width: scene.width
        background.height: scene.height
        background.visible: !debug
        background.z: -1
        Component.onCompleted: scene.ballCount += level.bonusBalls;
    }

    MouseArea {
        anchors.fill: scene
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

    Keys.onEnterPressed: scene.world.running = !scene.world.running;
    Keys.onEscapePressed: debug = !debug;
    Keys.onSpacePressed: bat.bump();
}
