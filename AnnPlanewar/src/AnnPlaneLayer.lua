AnnPlaneLayer = class("AnnPlaneLayer",function()
    return cc.Layer:create()
end)

function AnnPlaneLayer:create()
    local layer = AnnPlaneLayer.new()
    layer:init()
    return layer
end

function AnnPlaneLayer:init()
    cc.SpriteFrameCache:getInstance():addSpriteFrames("pig.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("bullet.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("wsparticle_p01.plist")
    cc.SpriteFrameCache:getInstance():addSpriteFrames("nplane.plist")
    self:addChild(require("SpritePig").create())
    self:f_createSprite()
    return true
end

function AnnPlaneLayer:f_createSprite()
    local winSize = cc.Director:getInstance():getWinSize()
    local plane = cc.Sprite:createWithSpriteFrame(
        cc.SpriteFrameCache:getInstance():getSpriteFrame("mplane.png"))
    plane:setName("MainPlane")
    self:addChild(plane)
    self:setPosition(cc.p(winSize.width / 2,winSize.height / 7))
    self:setAnchorPoint(0.5,0.5)
    self:setContentSize(plane:getContentSize())
--    mp_pig = require("PigSprite"):create()
--    self:addChild(mp_pig)
--    mp_pig:init()
    local touchListener = cc.EventListenerTouchOneByOne:create()
    touchListener:setSwallowTouches(false)
    touchListener:registerScriptHandler(onTouchesBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    touchListener:registerScriptHandler(onTouchesMoved, cc.Handler.EVENT_TOUCH_MOVED)
    touchListener:registerScriptHandler(onTouchesEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local dispatcher = self:getEventDispatcher()
    dispatcher:addEventListenerWithSceneGraphPriority(touchListener, self)
end

local isPlaneTouch = false

function onTouchesEnded(touch, event)
    isPlaneTouch = false
end

function onTouchesMoved(touch, event)
    local target = event:getCurrentTarget()
    local x,y = target:getPosition()
    if isPlaneTouch then
        target:setPosition(touch:getLocation().x, touch:getLocation().y)
    end
end

function onTouchesBegan(touch, event)
    local target = event:getCurrentTarget()
    local width = target:getContentSize().width
    local height = target:getContentSize().height
    local plane_x,plane_y = target:getPosition()
    local rect_x = plane_x - width / 2
    local rect_y = plane_y - height / 2
    local planeRect = cc.rect(rect_x,rect_y,width,height)
    if cc.rectContainsPoint(planeRect,cc.p(touch:getLocation().x,touch:getLocation().y)) then
        isPlaneTouch = true
    else
        isPlaneTouch = false
    end
    return true
end

return AnnPlaneLayer
