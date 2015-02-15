import QtQuick 2.4

Item {
    id: level

    property alias background: background
    property int bonusBalls: 1
    property Component brickComponent
    property int brickCount: 0
    property var world: parent.world

    function init() {
        level.brickComponent = Qt.createComponent("../content/Brick.qml");
    }

    function completed() {
        level._countBricks();
    }

    function register(brick) {
        brick.onBrokenChanged.connect(level._brickBroke);
    }

    function _brickBroke() {
        level.brickCount--;
    }

    function _countBricks() {
        var count = 0;
        for (var i = 0; i < level.children.length; i++) {
            var child = level.children[i];
            if (child.objectName === "brick") {
                count++;
            }
        }
        level.brickCount = count;
    }

    width: 600
    height: 400

    Rectangle {
        id: background
        anchors.fill: parent
        color: "Black"
    }
}
