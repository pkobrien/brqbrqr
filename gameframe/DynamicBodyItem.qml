import Box2D 2.0 as B2
import "../gameframe" as GF

GF.BaseBodyItem {
    id: item

    property bool bullet: false

    body.bodyType: B2.Body.Dynamic

    onBulletChanged: body.bullet = bullet

    onHeightChanged: console.error("Do not set a height on a Dynamic Body Item.");
    onWidthChanged: console.error("Do not set a width on a Dynamic Body Item.");
}
