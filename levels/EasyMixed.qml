import QtQuick 2.4
import "../content" as Brq

Brq.Level {
    id: level

    bonusBalls: 2

    background.gradient: Gradient {
        GradientStop { position: 0.0; color: "Black" }
        GradientStop { position: 0.5; color: "Yellow" }
        GradientStop { position: 1.0; color: "Black" }
    }

    Brq.Ball {
        x: 100
        y: 200
        color: "Red"
    }

    Brq.Ball {
        x: 300
        y: 200
        color: "Orange"
        angularVelocity: 5000
        friction: 0.5
        linearVelocity.x: 10
        linearVelocity.y: 30
    }

    Brq.Ball {
        x: 500
        y: 200
        color: "Purple"
    }

    Component.onCompleted: {
        // Green bricks
        var brickWidth = 40;
        var brickHeight = 40;
        for (var i = 60; i <= 600 - (brickWidth + 60); i += brickWidth) {
            for (var j = 0; j <= 120 - brickHeight; j += brickHeight) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Green";
                brick.strength = 1;
            }
        }
        // Yellow bricks
        var brickWidth = 40;
        var brickHeight = 20;
        for (var i = 40; i <= 600 - brickWidth; i += brickWidth * 2) {
            for (var j = 300; j <= 380 - brickHeight; j += brickHeight * 2) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Yellow";
                brick.strength = 2;
            }
        }
        for (var i = 0; i <= 600 - brickWidth; i += brickWidth * 2) {
            for (var j = 320; j <= 380 - brickHeight; j += brickHeight * 2) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Yellow";
                brick.strength = 2;
            }
        }
        // Red bricks
        var brickWidth = 20;
        var brickHeight = 40
        for (var i = 160; i <= 180; i += brickWidth) {
            for (var j = 120; j <= 320 - brickHeight; j += brickHeight) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Red";
                brick.strength = 3;
            }
        }
        for (var i = 400; i <= 420; i += brickWidth) {
            for (var j = 120; j <= 320 - brickHeight; j += brickHeight) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Red";
                brick.strength = 3;
            }
        }
        // Blue bricks
        var brickWidth = 20;
        var brickHeight = 20;
        for (var i = 0; i <= 40 - brickWidth; i += brickWidth) {
            for (var j = 0; j <= 320 - brickHeight; j += brickHeight) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Blue";
                brick.strength = 1;
            }
        }
        for (var i = 560; i <= 600 - brickWidth; i += brickWidth) {
            for (var j = 0; j <= 320 - brickHeight; j += brickHeight) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Blue";
                brick.strength = 1;
            }
        }
    }
}
