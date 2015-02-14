import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import "../content"

Level {
    id: levelOne

    Brick {
        id: brick1
        x: 280
        y: 220
        width: 20
        height: 20
        color: "#008000"
    }

    Brick {
        id: brick2
        x: 80
        y: 20
        width: 20
        height: 20
        color: "#009900"
    }

    Brick {
        id: brick3
        x: 400
        y: 280
        width: 20
        height: 20
    }

    Brick {
        id: brick4
        x: 100
        y: 80
        width: 20
        height: 20
    }
}
