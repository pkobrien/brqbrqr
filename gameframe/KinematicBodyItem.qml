import Box2D 2.0 as B2
import "../gameframe" as GF

GF.BaseBodyItem {
    id: item

    body.bodyType: B2.Body.Kinematic
}
