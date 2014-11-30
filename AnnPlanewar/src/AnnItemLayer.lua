AnnItemLayer = class("AnnItemLayer",function()
    return cc.Layer:create()
end)

math.randomseed(os.time())

function AnnItemLayer:create()
    local layer = AnnItemLayer.new()
    layer:init()
    return layer
end

items = {}
score = 0
distance = 0
stars = 0

function AnnItemLayer:init() 
    
    local winSize = cc.Director:getInstance():getWinSize()

    local function refresh(dt)
        score = score + 1
        scoreLabel:setString(score)
        distance = distance + 1
        distanceLabel:setString(distance)
        starLabel:setString(stars)
        for itemKey, itemVar in pairs(items) do 
            local item = items[itemKey]
            if item:getPositionY() < 0 or item:getPositionX() < 0 or item:getPositionX() > winSize.width then
                item:removeFromParent()
                table.remove(items,itemKey)
            else
                local plane_width = planeLayer:getContentSize().width
                local plane_height = planeLayer:getContentSize().height
                local plane_rect_x = planeLayer:getPositionX() - plane_width / 2
                local plane_rect_y = planeLayer:getPositionY() - plane_height / 2
                local planeRect = cc.rect(plane_rect_x, plane_rect_y, plane_width, plane_height)

                local item_width = item:getContentSize().width
                local item_height = item:getContentSize().height
                local item_rect_x = item:getPositionX() - item_width / 2
                local item_rect_y = item:getPositionY() - item_height / 2
                local itemRect = cc.rect(item_rect_x, item_rect_y, item_width, item_height)
                if cc.rectIntersectsRect(planeRect,itemRect) then
                    score = score + 100
                    item:removeFromParent()
                    table.remove(items,itemKey)
                    stars = stars + 1
                    break
                end
            end
        end
    end

    local scheduler = cc.Director:getInstance():getScheduler()
    local refreshID = self:scheduleUpdateWithPriorityLua(refresh,1)
    
    local hpLabel = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("ui_011.png"))
    hpLabel:setAnchorPoint(0,0)
    hpLabel:setPosition(0,winSize.height - 40)
    self:addChild(hpLabel, 10)
    
    scoreLabel = cc.LabelAtlas:_create(score, "fonts/img_num_score.plist")
    scoreLabel:setScale(0.6)
    scoreLabel:setAnchorPoint(1,0)
    scoreLabel:setPosition(winSize.width - 40,winSize.height - 80)
    self:addChild(scoreLabel, 0)
    
    local starIconLabel = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("ui_010.png"))
    starIconLabel:setPosition(winSize.width - 160,winSize.height - 100)
    starIconLabel:setScale(0.5)
    self:addChild(starIconLabel, 10)
    
    starLabel = cc.LabelAtlas:_create(stars, "fonts/img_num_star.plist")
    starLabel:setAnchorPoint(0,0.5)
    starLabel:setPosition(winSize.width - 130,winSize.height - 115)
    self:addChild(starLabel, 0)
    
    local kLabel = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("ui_012.png"))
    kLabel:setAnchorPoint(1,0)
    kLabel:setPosition(winSize.width - 20,winSize.height - 180)
    self:addChild(kLabel, 10)
    local mLabel = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("ui_013.png"))
    mLabel:setAnchorPoint(1,0)
    mLabel:setPosition(winSize.width,winSize.height - 180)
    self:addChild(mLabel, 10)
    
    distanceLabel = cc.LabelAtlas:_create(distance, "fonts/img_num_dis.plist")
    distanceLabel:setAnchorPoint(1,0)
    distanceLabel:setPosition(winSize.width - 55,winSize.height - 185)
    self:addChild(distanceLabel, 0)
    
    return true
end

return AnnItemLayer
