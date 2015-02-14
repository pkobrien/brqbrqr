import QtQuick 2.4
import Box2D 2.0 as B2

Item {
    id: scene

    property bool debug: false
    property string status
    property alias world: world

    focus: true

    B2.DebugDraw {
        opacity: 0.75
        visible: scene.debug
        world: scene.world
        z: 99
    }

    B2.World {
        id: world
        gravity: Qt.point(0, 10)
        pixelsPerMeter: 10
        running: false
    }
}
