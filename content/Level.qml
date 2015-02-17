import QtQuick 2.4

Item {
    id: level

    property alias background: background
    property int bonusBalls: 1
    property Component brickComponent: Qt.createComponent("../content/Brick.qml")
    property int brickCount: 0
    property var world

    signal loaded()

    function registerBrick(brick) {
        brick.onBrokenChanged.connect(level._brickBroke);
    }

    function _brickBroke() {
        level.brickCount--;
    }

    width: 600
    height: 400

    onLoaded: {
        level.world = parent.world;
        var count = 0;
        for (var i = 0; i < level.children.length; i++) {
            var child = level.children[i];
            if (child.objectName === "brick") {
                registerBrick(child);
                count++;
            }
        }
        level.brickCount = count;
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "Black"
    }
}
