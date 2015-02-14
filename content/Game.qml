import QtQuick 2.4
import Box2D 2.0
import "../content" as Brq
import "../gameframe" as GF

GF.Game {
    id: game

    property int currentLevel: 0

    function startNextLevel() {
        game.currentLevel++;
        mainScene.reset();
        game.currentScene = mainScene;
    }

    width: 600
    height: 500

    currentScene: mainScene
    name: "BrqBrqr"
    status: currentScene.status
//    updatesPerSecond: 30

//    Brq.GameIntroScene {
//        id: gameIntroScene
//        onNextScene: {
//            game.currentScene = mainScene;
//        }
//    }

//    Brq.GameOverScene {
//        id: gameOverScene
//    }

//    Brq.LevelCompletedScene {
//        id: levelCompletedScene
//        level: game.currentLevel
//        onNextScene: {
//            game.startNextLevel()
//        }
//    }

    Brq.MainScene {
        id: mainScene
    }

    Keys.onEscapePressed: game.currentScene.world.running = !game.currentScene.world.running;
    Keys.onSpacePressed: game.currentScene.debug = !game.currentScene.debug;
}
