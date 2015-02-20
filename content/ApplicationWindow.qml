import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import "../content" as Brq
import GameFrame 1.0 as GF

GF.ApplicationWindow {
    id: applicationWindow

    width: game.width
    height: game.height + statusBar.height

    maximumWidth: width
    maximumHeight: height

    minimumWidth: width
    minimumHeight: height

    title: "BrqBrqr (Brick Breaker, a Breakout clone)"

    Brq.Game {
        id: game
    }

    statusBar: StatusBar {
        width: game.width
        RowLayout {
            anchors.fill: parent
            Label { text: game.status }
        }
    }
}
