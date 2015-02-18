import QtQuick 2.4
import Box2D 2.0 as B2
import "." as GF

Item {
    id: scene

    property string status
    property var world
    property var _debugDraw

    signal finished()

    focus: visible
    visible: false

    Component.onCompleted: {
        if (world) {
            var comp = Qt.createComponent("DebugDraw.qml");
            _debugDraw = comp.createObject(scene);
        }
    }
}
