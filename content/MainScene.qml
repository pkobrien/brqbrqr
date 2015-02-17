import QtQuick 2.4
import "../content" as Brq
import "../gameframe" as GF

GF.Scene {
    id: scene

    property var activeBall
    property Component ballComponent: Qt.createComponent("../content/Ball.qml")
    property int ballCount: 3
    property bool ballLoaded: false
    property real batFriction: 0.5
    property point gravity: Qt.point(0, 0)

    function failure(ball) {
        var systemBall = (ball.objectName === "SystemBall");
        ball.destroy();
        if (systemBall) {
            scene.loadBall();
        }
    }

    function launchBall() {
        scene.world.running = true;
        if (!scene.ballLoaded) {
            return;
        }
        scene.activeBall.x = bat.x + bat.width / 2; // To remove the binding.
        scene.activeBall.y = bat.y - 40; // To remove the binding.
        scene.activeBall.linearVelocity.y = scene.activeBall.minLinearVelocityY;
        scene.ballLoaded = false;
    }

    function loadBall() {
        if (scene.ballCount <= 0) {
            return;
        }
        var props = {"objectName": "SystemBall", "x": bat.x + bat.width / 2, "y": bat.y - 40};
        scene.activeBall = scene.ballComponent.createObject(scene, props);
        scene.activeBall.x = Qt.binding(function() { return bat.x + bat.width / 2; });
        scene.activeBall.y = Qt.binding(function() { return bat.y - 40; });
        scene.ballLoaded = true;
        scene.ballCount--;
    }

//    function reset() {
//    }

    function start() {
        scene.loadBall();
        scene.world.running = true;
    }

    width: 600
    height: 500

    status: qsTr("Balls: %1  Bricks: %2  [Debug: %4]  [Paused: %5]  [Gravity: %6]  [Y Velocity: %7]").arg(
                ballCount).arg(levelLoader.item.brickCount).arg(debug).arg(!world.running).arg(
                world.gravity).arg(activeBall.linearVelocity.y)

    world: Brq.MainWorld { gravity: scene.gravity }

    Brq.Bat {
        id: bat
        x: scene.width / 2 - bat.width / 2
        y: levelLoader.item.height + 60
        friction: scene.batFriction
    }

    Brq.Boundaries {
        id: boundaries
        bottomBoundary.onBeginContact: {
            var name = other.getBody().target.objectName;
            if (name === "ball" || name === "SystemBall") {
                var ball = other.getBody().target;
                scene.failure(ball);
            }
        }
    }

    Brq.LevelLoader {
        id: levelLoader
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: launchBall();
        onPositionChanged: bat.synch(mouse);
    }

    Component.onCompleted: start();

    Keys.onEnterPressed: world.running = !world.running;
    Keys.onEscapePressed: debug = !debug;
    Keys.onRightPressed: levelLoader.next();
    Keys.onSpacePressed: bat.bump();
}
