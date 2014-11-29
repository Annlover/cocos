local SpritePig = class("SpritePig",function()
    return cc.Sprite:create()
end)

function SpritePig:create()
    local pig = SpritePig.new()
    pig:init()
    return pig
end

function SpritePig:init()
    local winSize = cc.Director:getInstance():getWinSize()
    self:setSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("hero_01.png"))
    self:setPosition(cc.p(70, 50))
    self:f_createAnimate(6, 60)
--    local body = cc.PhysicsBody:create()
--    body:applyImpulse(cc.p(0, 10))
--    body:setVelocity(cc.p(0, 120))
--    self:setPhysicsBody(body)
--    self:runAction(cc.MoveTo:create(2,self:getPositionX() + 70, self:getPositionY() + 200))
--    schedule(self,SpritePig:f_followPlane(),0)
    return true
end

function SpritePig:f_createAnimate(count, fps)
    local panimation = cc.Animation:create()
    panimation:setDelayPerUnit(1.0 / fps);
    for id = 1,count do
        local buff = string.format("hero_0%d.png", id)
        panimation:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(buff))
    end
    self:runAction(cc.RepeatForever:create(cc.Animate:create(panimation)))
end

return SpritePig