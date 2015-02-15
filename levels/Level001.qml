import QtQuick 2.4
import "../content" as Brq

Brq.Level {
    id: level

    background.gradient: Gradient {
        GradientStop { position: 0.0; color: "Green" }
        GradientStop { position: 1.0; color: "Black" }
    }

    Component.onCompleted: {
        level.init();
        var brickWidth = 40;
        var brickHeight = 40
        for (var i = 0; i <= 600 - brickWidth; i += brickWidth) {
            for (var j = 100; j <= 300 - brickHeight; j += brickHeight) {
                var props = {"x": i, "y": j, "width": brickWidth, "height": brickHeight}
                var brick = level.brickComponent.createObject(level, props);
                brick.color = "Green";
                brick.strength = 1;
                level.register(brick);
            }
        }
        level.completed();
    }
}
