import QtQuick 2.4
import Box2D 2.0 as B2
import "." as GF

Item {
    id: scene

    property bool debug: false
    property string status
    property var world

    focus: true

    GF.DebugDraw {
        id: debugDraw
    }
}
