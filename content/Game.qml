import QtQuick 2.4
import QtQml.StateMachine 1.0 as DSM
import "../gameframe" as GF
import "../scenes" as Scene

GF.Game {
    id: game

    width: 600
    height: 500

//    activeScene: mainScene
    name: "BrqBrqr"
    status: activeScene ? activeScene.status : ""

    //    updatesPerSecond: 30

    Scene.GameIntro {
        id: gameIntroScene
    }

    Scene.GameOver {
        id: gameOverScene
    }

    Scene.MainScene {
        id: mainScene
    }

    DSM.StateMachine {
        id: stateMachine
        initialState: omniState
        running: true

        DSM.State {
            id: omniState

            initialState: welcomeState
//            DSM.SignalTransition {
//                targetState: finalState
//                signal: quitButton.clicked
//            }
            onEntered: console.log("omniState entered");
            onExited: console.log("omniState exited");

            DSM.State {
                id: welcomeState

                DSM.SignalTransition {
                    signal: gameIntroScene.finished
                    targetState: mainState
                    onTriggered: console.log("gameIntroScene.finished");
                }
                onEntered: {
                    console.log("welcomeState entered");
                    game.activeScene = gameIntroScene;
                    gameIntroScene.visible = true;
                }
                onExited: {
                    console.log("welcomeState exited");
                    game.activeScene = null;
                    gameIntroScene.visible = false;
                }
            }

            DSM.State {
                id: mainState

                DSM.SignalTransition {
                    signal: mainScene.finished
                    targetState: goodbyeState
                    onTriggered: console.log("mainScene.finished");
                }
                onEntered: {
                    console.log("mainState entered");
                    game.activeScene = mainScene;
                    mainScene.visible = true;
                    mainScene.start();
                }
                onExited: {
                    console.log("mainState exited");
                    game.activeScene = null;
                    mainScene.stop();
                    mainScene.visible = false;
                }
            }

            DSM.State {
                id: goodbyeState

                DSM.SignalTransition {
                    signal: gameOverScene.finished
                    targetState: finalState
                    onTriggered: console.log("gameOverScene.finished");
                }
                onEntered: {
                    console.log("goodbyeState entered");
                    game.activeScene = gameOverScene;
                    gameOverScene.visible = true;
                }
                onExited: {
                    console.log("goodbyeState exited");
                    game.activeScene = null;
                    gameOverScene.visible = false;
                }
            }
        }

        DSM.FinalState {
            id: finalState

            onEntered: console.log("finalState entered");
            onExited: console.log("finalState exited");
        }
        onFinished: Qt.quit();
    }
}
