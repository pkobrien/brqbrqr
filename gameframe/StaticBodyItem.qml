import Box2D 2.0 as B2
import "../gameframe" as GF

GF.BaseBodyItem {
    id: item

    awake: false
    body.bodyType: B2.Body.Static
    sleepingAllowed: true
}
