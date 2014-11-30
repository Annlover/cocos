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
        
        local myPlaneX,myPlaneY = planeLayer:getPosition()
        local shootItem = cc.Sprite:create("single_bullet.png")
        shootItem:setPosition(newEnemy:getPosition())
        local roateAction = cc.RotateBy:create(4,3600.0)
        local shootAction = cc.MoveTo:create(3,cc.p(myPlaneX,-myPlaneY))
        shootItem:runAction(cc.Spawn:create(shootAction,roateAction))
        self:addChild(shootItem)
        table.insert(enemyBullets,table.maxn(enemyBullets) + 1,shootItem)
    end
    
    local function refresh(dt)
        for enemyKey, var in pairs(enemys) do 
            local enemy = enemys[enemyKey]
            if enemy:getPositionY() < 0 then
                enemy:removeFromParent()
                table.remove(enemys,enemyKey)
            else
                local myPlane_width = planeLayer:getContentSize().width
                local myPlane_height = planeLayer:getContentSize().height
                local myPlane_rect_x = planeLayer:getPositionX() - myPlane_width / 2
                local myPlane_rect_y = planeLayer:getPositionY() - myPlane_height / 2
                local myPlaneRect = cc.rect(myPlane_rect_x, myPlane_rect_y, myPlane_width, myPlane_height)

                local enemy = enemys[enemyKey]
                local enemy_width = enemy:getContentSize().width
                local enemy_height = enemy:getContentSize().height
                local enemy_rect_x = enemy:getPositionX() - enemy_width / 2
                local enemy_rect_y = enemy:getPositionY() - enemy_height / 2
                local enemyRect = cc.rect(enemy_rect_x, enemy_rect_y, enemy_width, enemy_height)

                if cc.rectIntersectsRect(myPlaneRect,enemyRect) then
                    print("撞击")
                    enemy:removeFromParent()
                    table.remove(enemys,enemyKey)
                    local bomb = require("SpriteBomb"):create(3)
                    bomb:setPosition(0,0)
                    planeLayer:addChild(bomb)
                    break
                end
            end
        end
    end

    local scheduler = cc.Director:getInstance():getScheduler()
    local schedulerID = scheduler:scheduleScriptFunc(update, 1, false)
    local refreshID = self:scheduleUpdateWithPriorityLua(refresh,0)

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
