require("EnemySprite")

AnnEnemyLayer = class("AnnEnemyLayer",function()
    return cc.Layer:create()
end)

math.randomseed(os.time())

function AnnEnemyLayer:create()
    local layer = AnnEnemyLayer.new()
    layer:init()
    return layer;
end

enemys = {}

function AnnEnemyLayer:init() 
    local pAnimation1 = cc.Animation:create();
    pAnimation1:setDelayPerUnit(0.1);
    for id = 1,8 do 
        local buff = string.format("a_00%d.png", id);
        pAnimation1:addSpriteFrame(
                cc.SpriteFrameCache:getInstance():getSpriteFrame(buff));
    end
    cc.AnimationCache:getInstance():addAnimation(pAnimation1, "Enemy1Blowup")

    local function update(dt)
        local newEnemy = self:getEnemy()
        self:addChild(newEnemy)
        table.insert(enemys,table.maxn(enemys) + 1,newEnemy)
        for key, var in pairs(enemys) do 
            local enemy = enemys[key]
            if enemy:getPositionY() < 0 then
                enemy:removeFromParent()
                table.remove(enemys,key)
            end
        end
    end
    
    local function refresh(dt)
        for key, var in pairs(enemys) do 
            local enemy = enemys[key]
            if enemy:getPositionY() < 0 then
                enemy:removeFromParent()
                table.remove(enemys,key)
            end
        end
    end

    local scheduler = cc.Director:getInstance():getScheduler()
    local schedulerID = scheduler:scheduleScriptFunc(update, 1, false)
--    local refreshID = self:scheduleUpdateWithPriorityLua(refresh,0)

--    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedulerID) 
--    self:scheduleUpdateWithPriorityLua(update, 0)

    return true;
end

function AnnEnemyLayer:getEnemy(speed)
    local pEnemySprite = EnemySprite:create()
    local num
    if pEnemySprite:getSprite():getTag() == 1 then
        num = math.random(7,12)
    elseif pEnemySprite:getSprite():getTag() == 2 then
        num = math.random(5,10)
    else
        num = math.random(1,2)
    end
    local actionMove = cc.MoveTo:create(num,cc.p(pEnemySprite:getPositionX(),0 - pEnemySprite:getContentSize().height/2));
    pEnemySprite:runAction(actionMove)
    return pEnemySprite
end

return AnnEnemyLayer
