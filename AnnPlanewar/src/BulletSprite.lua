BulletSprite = class("BulletSprite",function()
    return cc.Sprite:create()
end)

local scheduler,schedulerID,winSize,pBulletSprite

math.randomseed(os.time())

function BulletSprite:create()
    local bullet = BulletSprite:new()
    bullet:init()
    return bullet
end 

function BulletSprite:init() 
    self:setSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("bullet_%d.png",1)))
    winSize = cc.Director:getInstance():getWinSize()
    self:setPosition(planeLayer:getPosition())
    local flyLen = winSize.height
    local flyVelocity = 320 / 1
end

return BulletSprite