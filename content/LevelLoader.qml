import QtQuick 2.4

Loader {
    id: levelLoader

    property bool debug: parent.debug
    property int index: 0
    property var levels: ["Level001", "Level002", "Level003", "Level004", "Level005"]
    property string path: "../levels/" + levels[index] + ".qml"
    property var world: parent.world

    function next() {
        world.running = false;
        index = (index + 1) % levels.length;
        source = path;
        world.running = true;
    }

    function onBrickCountChanged() {
        if (item.brickCount === 0) {
            next();
        }
    }

    width: 600
    height: 400
    onLoaded: {
        item.background.parent = Qt.binding(function() { return parent; });
        item.background.width = Qt.binding(function() { return parent.width; });
        item.background.height = Qt.binding(function() { return parent.height; });
        item.background.visible = Qt.binding(function() { return !parent.debug; });;
        item.background.z = -1;
        item.onLoaded();
        item.onBrickCountChanged.connect(onBrickCountChanged);
        parent.ballCount += item.bonusBalls;
    }

    Component.onCompleted: source = path;
}
