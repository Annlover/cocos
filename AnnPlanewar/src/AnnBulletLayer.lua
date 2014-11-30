require("BulletSprite")

AnnBulletLayer = class("AnnBulletLayer",function()
    return cc.Layer:create()
end)

function AnnBulletLayer:create()
    local layer = AnnBulletLayer:new()
    layer:init()
    return layer
end

local num = 0
local winSize
myBullets = {}
enemyBullets = {}

local random
math.randomseed(os.time())

function AnnBulletLayer:init() 
    winSize = cc.Director:getInstance():getWinSize()
    local function update(dt)
        local newBullet = self:getBullet()
        self:addChild(newBullet)
        table.insert(myBullets,table.maxn(myBullets) + 1,newBullet)
    end
    
    local function refresh(dt)
        for bulletKey, bulletVar in pairs(myBullets) do 
            local bullet = myBullets[bulletKey]
            if bullet:getPositionY() > winSize.height then
                bullet:removeFromParent()
                table.remove(myBullets,bulletKey)
            else
                for enemyKey, enemyVar in pairs(enemys) do
                    local enemy = enemys[enemyKey]
                    local enemy_width = enemy:getContentSize().width
                    local enemy_height = enemy:getContentSize().height
                    local enemy_rect_x = enemy:getPositionX() - enemy_width / 2
                    local enemy_rect_y = enemy:getPositionY() - enemy_height / 2
                    local enemyRect = cc.rect(enemy_rect_x, enemy_rect_y, enemy_width, enemy_height)

                    local bullet_width = bullet:getContentSize().width
                    local bullet_height = bullet:getContentSize().height
                    local bullet_rect_x = bullet:getPositionX() - bullet_width / 2
                    local bullet_rect_y = bullet:getPositionY() - bullet_height / 2
                    local bulletRect = cc.rect(bullet_rect_x, bullet_rect_y, bullet_width, bullet_height)
                    if cc.rectIntersectsRect(enemyRect,bulletRect) then
                        enemy:loseLife()
                        score = score + 10
                        if enemy:getLife() == 0 then
                            local x,y = enemy:getPosition()
                            enemy:removeFromParent()
                            table.remove(enemys,enemyKey)
                            score = score + 500
                            local bomb = require("SpriteBomb"):create(2)
                            bomb:setPosition(x,y)
                            itemLayer:addChild(bomb)
                            random = math.random(1,4)
                            for num = 1, random do
                                local star = require("SpriteStar"):create()
                                star:setPosition(x,y)
                                itemLayer:addChild(star)
                                table.insert(items,table.maxn(items) + 1,star)
                            end
                        end
                        bullet:removeFromParent()
                        table.remove(myBullets,bulletKey)
                        break
                    end
                end 
            end
        end
        
        for bulletKey, bulletVar in pairs(enemyBullets) do 
            local bullet = enemyBullets[bulletKey]
            if bullet:getPositionY() < 0 or bullet:getPositionX() < 0 or bullet:getPositionX() > winSize.height then
                bullet:removeFromParent()
                table.remove(enemyBullets,bulletKey)
            else
                local myPlane_width = planeLayer:getContentSize().width
                local myPlane_height = planeLayer:getContentSize().height
                local myPlane_rect_x = planeLayer:getPositionX() - myPlane_width / 2
                local myPlane_rect_y = planeLayer:getPositionY() - myPlane_height / 2
                local myPlaneRect = cc.rect(myPlane_rect_x, myPlane_rect_y, myPlane_width, myPlane_height)

                local bullet_width = bullet:getContentSize().width
                local bullet_height = bullet:getContentSize().height
                local bullet_rect_x = bullet:getPositionX() - bullet_width / 2
                local bullet_rect_y = bullet:getPositionY() - bullet_height / 2
                local bulletRect = cc.rect(bullet_rect_x, bullet_rect_y, bullet_width, bullet_height)
                if cc.rectIntersectsRect(myPlaneRect,bulletRect) then
                    print("主战机被击中")
                    bullet:removeFromParent()
                    table.remove(enemyBullets,bulletKey)
                    local bomb = require("SpriteBomb"):create(4)
                    bomb:setPosition(0,0)
                    planeLayer:addChild(bomb)
                    break
                end
            end
        end
    end
    
    local scheduler = cc.Director:getInstance():getScheduler()
    local schedulerID = scheduler:scheduleScriptFunc(update, 0.1, false)
    local refreshID = self:scheduleUpdateWithPriorityLua(refresh,1)
    
    return true
end

function AnnBulletLayer:getBullet()
    local bullet = BulletSprite:create()
    local actionMove = cc.MoveTo:create(1.0, cc.p(bullet:getPositionX(), winSize.height + bullet:getTextureRect().height/2))
    bullet:runAction(actionMove)
    return bullet
end

return AnnBulletLayer
