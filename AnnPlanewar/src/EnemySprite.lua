EnemySprite = class("EnemySprite",function()
    return cc.Sprite:create()
end)

local pEnemySprite,nLife

function EnemySprite:create()
    local enemy = EnemySprite:new()
    enemy:init()
    return enemy
end 

math.randomseed(os.time())

function EnemySprite:init(enType) 
    local ran = math.random(1,3)
    pEnemySprite = cc.Sprite:createWithSpriteFrame(
    cc.SpriteFrameCache:getInstance():getSpriteFrame(string.format("n%d.png",ran)))
    if ran == 1 then
        pEnemySprite:setTag(1)
    elseif ran == 2 then
        pEnemySprite:setTag(2)
    else
        pEnemySprite:setTag(3)
    end
    pEnemySprite:setAnchorPoint(0,0)
    local winSize = cc.Director:getInstance():getWinSize()
    local enemySize = pEnemySprite:getContentSize()
    local minX = enemySize.width / 2
    local maxX = winSize.width - enemySize.width / 2
    local rangeX = maxX - minX
    local actualX = math.random(minX,maxX)
    self:setPosition(actualX, winSize.height + enemySize.height / 2)
    self:setContentSize(enemySize)
    nLife = 5
    self:addChild(pEnemySprite)
end

function EnemySprite:getSprite() 
    return pEnemySprite;
end

function EnemySprite:getLife() 
    return nLife;
end

function EnemySprite:loseLife() 
    nLife = nLife - 1.0;
end

return EnemySprite