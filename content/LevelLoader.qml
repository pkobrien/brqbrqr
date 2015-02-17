import QtQuick 2.4

Loader {
    id: levelLoader

    property int index: 0
    property var levels: ["Level001", "Level002", "Level003", "Level004", "Level005"]
    property string path: "../levels/" + levels[index] + ".qml"
    property var world: parent.world

    function next() {
        _load(index + 1);
    }

    function onBrickCountChanged() {
        if (item.brickCount === 0) {
            next();
        }
    }

    function previous() {
        _load(index - 1);
    }

    function _load(level) {
        world.running = false;
        level = Math.min(Math.max(level, 0), levels.length - 1);
        index = level % levels.length;
        source = path;
    }

    width: 600
    height: 400
    onLoaded: {
        item.background.parent = Qt.binding(function() { return parent; });
        item.background.width = Qt.binding(function() { return parent.width; });
        item.background.height = Qt.binding(function() { return parent.height; });
        item.background.visible = Qt.binding(function() { return !world.debug; });;
        item.background.z = -1;
        item.loaded();
        item.onBrickCountChanged.connect(onBrickCountChanged);
        parent.ballCount += item.bonusBalls;
    }

    Component.onCompleted: source = path;
}
