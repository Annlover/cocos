local SpriteStar = class("SpriteStar",function()
    return cc.Sprite:create()
end)

function SpriteStar:create()
    local star = SpriteStar.new()
    star:init()
    return star
end

local randomX,randomY 
math.randomseed(os.time())

function SpriteStar:init()
    local winSize = cc.Director:getInstance():getWinSize()
    self:setSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("stars_01.png"))
    self:setPosition(cc.p(70, 50))
    self:f_createAnimate(8, 15)
    local body = cc.PhysicsBody:create()
    body:applyImpulse(cc.p(0, 10))
    randomX = math.random(-40,40)
    randomY = math.random(50,140)
    body:setVelocity(cc.p(randomX, randomY))
    self:setPhysicsBody(body)
--    self:runAction(cc.MoveTo:create(2,self:getPositionX() + 70, self:getPositionY() + 200))
--    schedule(self,PigSprite:f_followPlane(),0)
    return true
end

function SpriteStar:f_createAnimate(count, fps)
    local panimation = cc.Animation:create()
    panimation:setDelayPerUnit(1.0 / fps);
    for id = 1,count do
        local buff = string.format("stars_0%d.png", id)
        panimation:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(buff))
    end
    self:runAction(cc.RepeatForever:create(cc.Animate:create(panimation)))
end

return SpriteStar