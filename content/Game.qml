import QtQuick 2.4
import Box2D 2.0
import "../content" as Brq
import "../gameframe" as GF
import "../scenes" as Scene

GF.Game {
    id: game

    width: 600
    height: 500

    activeScene: mainScene
    name: "BrqBrqr"
    status: activeScene.status

    //    updatesPerSecond: 30

//    Scene.GameIntro {
//        id: gameIntroScene
//        onNextScene: {
//            game.currentScene = mainScene;
//        }
//    }

//    Scene.GameOver {
//        id: gameOverScene
//    }

    Scene.MainScene {
        id: mainScene
    }
}
