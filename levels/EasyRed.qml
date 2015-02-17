import QtQuick 2.4
import "../content" as Brq

Brq.Level {
    id: level

    bonusBalls: 3

    background.gradient: Gradient {
        GradientStop { position: 0.0; color: "Red" }
        GradientStop { position: 1.0; color: "Black" }
    }

    Component.onCompleted: {
        var brickWidth = 20;
        var brickHeight = 40
        for (var i = 20; i <= 600 - brickWidth; i += brickWidth * 3) {
            for (var j = 20; j <= 400 - brickHeight; j += brickHeight) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Red";
                brick.strength = 3;
            }
        }
    }
}
