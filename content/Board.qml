import QtQuick 2.4
import "../content" as Brq

Item {
    id: board

    property var balls: []
    property var bats: []
    property var bricks: []

    function begin() {
        ball.x = 0;
        ball.y = 0;
        ball.xIncrement = 2;
        ball.yIncrement = 4;
        ball.visible = true;
        timer.start();
    }

    function breaktime() { timer.stop() }

    function cycle() {
        for (var i = 0; i < board.balls.length; i++) {
            var ball = board.balls[i];
            move(ball);
        }
    }

    function move(ball) {
        if (!ball.visible) {
            return;
        }
        var nextX = ball.x + ball.xIncrement;
        var nextY = ball.y + ball.yIncrement;
        if (nextX < 0 || nextX > boundary.width - ball.width) {
            ball.xIncrement = -ball.xIncrement;
            return;
        }
        if (nextY < 0) {
            ball.yIncrement = -ball.yIncrement;
            return;
        }
        if (nextY > boundary.height - ball.height) {
            ball.visible = false;
        }
        if (ball.yIncrement > 0) {
            for (var i = 0; i < board.bats.length; i++) {
                var bat = board.bats[i];
                if (nextY + ball.height > bat.y && nextY < bat.y + bat.height &&
                    nextX + ball.width > bat.x && nextX < bat.x + bat.width) {
                    // We have a ball/bat collision.
                    var offset = Math.PI * Math.max(Math.min(nextX - bat.x, bat.width), 0) / bat.width;
                    var ry = Math.max(Math.sin(offset), 0.3);
                    var velocity = 4
                    ball.yIncrement = ry * -velocity;
                    if (ball.xIncrement < 0) {
                        velocity = -velocity
                    }
                    var apply = false;
                    if (ball.xIncrement > 0 && nextX + ball.width / 2 > bat.x + bat.width / 2) {
                        apply = true;
                    } else if (ball.xIncrement < 0 && nextX + ball.width / 2 < bat.x + bat.width / 2) {
                        apply = true;
                    }
                    if (apply) {
                        ball.xIncrement = (1 - ry) * velocity;
                    }
//                    console.log("off:", offset, "ry:", ry, "vel:", velocity, "apply:", apply, "ball.xInc:", ball.xIncrement, "ball.yInc:", ball.yIncrement)
                    return;
                }
            }
        }
        ball.x = nextX;
        ball.y = nextY;
    }

    width: 640
    height: 480

    Rectangle {
        id: visual
        anchors.fill: parent
        color: "Gray"
    }

    Rectangle {
        id: boundary
        width: 600
        height: 400
        anchors.centerIn: board
        border.color: "Black"
        border.width: 1
        color: "DarkSlateGray"
    }

    Brq.Ball {
        id: ball
        parent: boundary
        duration: timer.interval / 2
        x: 0
        y: 0
//        xIncrement: ball.xIncrement * 2
//        yIncrement: ball.yIncrement * 2
        xIncrement: 2
        yIncrement: 4
        Component.onCompleted: board.balls.push(ball)
    }

//    Brq.Ball {
//        id: ball2
//        parent: boundary
//        duration: timer.interval / 2
//        x: boundary.width / 2 - ball.width / 2
//        y: boundary.height / 2 - ball.height / 2
//        Component.onCompleted: board.balls.push(ball2)
//    }

//    Brq.Ball {
//        id: ball3
//        parent: boundary
//        duration: timer.interval / 2
//        x: boundary.width - ball.width
//        y: boundary.height - ball.height
//        xIncrement: 2
//        yIncrement: 3
//        Component.onCompleted: board.balls.push(ball3)
//    }

//    Brq.Ball {
//        id: ball4
//        parent: boundary
//        duration: timer.interval / 2
//        x: 100
//        y: 33
//        xIncrement: 10
//        yIncrement: 1
//        Component.onCompleted: board.balls.push(ball4)
//    }

    Brq.Bat {
        id: bat
        parent: boundary
        duration: timer.interval / 2
        x: boundary.width / 2 - bat.width / 2
        y: boundary.height - bat.height - 8
        Component.onCompleted: board.bats.push(bat)
    }

    MouseArea {
        id: mouseArea
        anchors {top: visual.top; bottom: visual.bottom}
        anchors {left: boundary.left; right: boundary.right}
        hoverEnabled: true
        onPositionChanged: {
            bat.synch(mouse);
        }
    }

    Timer {
        id: timer
        interval: 16
        repeat: true
        onTriggered: { cycle() }
    }

    focus: true
    Keys.onEscapePressed: breaktime()
    Keys.onLeftPressed: bat.move(-20)
    Keys.onRightPressed: bat.move(20)
    Keys.onSpacePressed: begin()
}
