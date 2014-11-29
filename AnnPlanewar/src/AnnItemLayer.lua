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

function AnnItemLayer:init() 
    
    local winSize = cc.Director:getInstance():getWinSize()

    local function refresh(dt)
        for itemKey, itemVar in pairs(items) do 
            local item = items[itemKey]
            if item:getPositionY() > winSize.height or item:getPositionX() < 0 or item:getPositionX() > winSize.width then
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
                    print("eat star")
                    item:removeFromParent()
                    table.remove(items,itemKey)
                    break
                end
            end
        end
    end

    local scheduler = cc.Director:getInstance():getScheduler()
    local refreshID = self:scheduleUpdateWithPriorityLua(refresh,1)
    
    return true
end

return AnnItemLayer
