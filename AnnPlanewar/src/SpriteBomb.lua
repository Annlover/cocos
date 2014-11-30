local SpriteBomb = class("SpriteBomb",function()
    return cc.Sprite:create()
end)

function SpriteBomb:create(type)
    local star = SpriteBomb.new()
    star:init(type)
    return star
end

local randomX,randomY,picKey
math.randomseed(os.time())

function SpriteBomb:init(type)
    local winSize = cc.Director:getInstance():getWinSize()
    self:setSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("a_001.png"))
    if type == 1 then
        picKey = "a_00%d.png"
    elseif type == 2 then
        picKey = "b_00%d.png"
    elseif type == 3 then
        picKey = "c_00%d.png"
    else
        picKey = "d_00%d.png"
    end
    self:f_createAnimate(8, 8)
    return true
end

function SpriteBomb:f_createAnimate(count, fps)
    local panimation = cc.Animation:create()
    panimation:setDelayPerUnit(1.0 / fps);
    for id = 1,count do
        local buff = string.format(picKey, id)
        panimation:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(buff))
    end
    local function destoryBomb()
        self:removeFromParent()
    end
    local callbackAction = cc.CallFunc:create(destoryBomb)
    self:runAction(cc.Sequence:create(cc.Animate:create(panimation), callbackAction))
end

return SpriteBomb