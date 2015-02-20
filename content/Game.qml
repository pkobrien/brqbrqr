import QtQuick 2.4
import QtQml.StateMachine 1.0 as DSM
import "../gameframe" as GF
import "../scenes" as Scene

GF.Game {
    id: game

    width: 600
    height: 500

    domain: "com.brqbrqr"
    name: "BrqBrqr"
    organization: name
    version: "0.1.0"

    status: activeScene ? activeScene.status : ""

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
//                signal: quitButton.clicked
//                targetState: finalState
//            }

            DSM.State {
                id: welcomeState

                DSM.SignalTransition {
                    signal: gameIntroScene.finished
                    targetState: mainState
                }
                onEntered: game.activate(gameIntroScene);
            }

            DSM.State {
                id: mainState

                DSM.SignalTransition {
                    signal: mainScene.finished
                    targetState: goodbyeState
                }
                onEntered: game.activate(mainScene);
            }

            DSM.State {
                id: goodbyeState

                DSM.SignalTransition {
                    signal: gameOverScene.finished
                    targetState: finalState
                }
                onEntered: game.activate(gameOverScene);
            }
        }

        DSM.FinalState {
            id: finalState
        }
        onFinished: Qt.quit();
    }
}
