import QtQuick 2.4
import "../content" as Brq

Brq.Level {
    id: level

    bonusBalls: 0

    background.gradient: Gradient {
        GradientStop { position: 0.0; color: "Black" }
        GradientStop { position: 1.0; color: "Blue" }
    }

    Component.onCompleted: {
        level.init();
        var brickWidth = 20;
        var brickHeight = 20
        for (var i = 20; i <= 600 - brickWidth; i += brickWidth * 3) {
            for (var j = 20; j <= 400 - brickHeight; j += brickHeight * 3) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Blue";
                brick.strength = 1;
                level.register(brick);
            }
        }
        level.completed();
    }
}
