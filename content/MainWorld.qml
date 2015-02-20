import QtQuick 2.4
import GameFrame 1.0 as GF

GF.World {
    id: world

    gravity: Qt.point(0, 0)
    pixelsPerMeter: 20
    running: false

//    onPreSolve: {
//        var targetA = contact.fixtureA.getBody().target;
//        var targetB = contact.fixtureB.getBody().target;
//        console.log("A:", targetA, "B:", targetB)
//        if (targetA.isBall && contact.fixtureB === topBeltFixture)
//            contact.tangentSpeed = -3.0;
//        else if (targetB.isBall && contact.fixtureA === topBeltFixture)
//            contact.tangentSpeed = 3.0;
//    }

//    onPostSolve: {
//        var entityA = contact.fixtureA.parent
//        var entityB = contact.fixtureB.parent
//        if (entityA.objectName === "asteroid" || entityB.objectName === "asteroid") {
//            var asteroidObject
//            if (entityA.objectName === "bullet" || entityB.objectName === "bullet") {
//                var bulletObject;
//                if (entityA.objectName === "bullet") {
//                    asteroidObject = entityB;
//                    bulletObject = entityA;
//                } else {
//                    asteroidObject = entityA;
//                    bulletObject = entityB;
//                }
//                bulletObject.destroy();
//                asteroidObject.damage();
//            }
//        }
//        console.log(entityA.objectName, entityB.objectName)
//    }
}
