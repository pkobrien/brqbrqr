import QtQuick 2.4
import Box2D 2.0 as B2

B2.World {
    id: world

    gravity: Qt.point(0, 10)
    pixelsPerMeter: 10
    running: false

    onPreSolve: { }

    onPostSolve: { }
}
