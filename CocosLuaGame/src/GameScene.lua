
local GameScene = class("GameScene",function()
    return cc.Scene:create()
end)

function GameScene.create()
    local scene = GameScene.new()
    scene:addChild(scene:createLayer())
    return scene
end


function GameScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
end

function GameScene:playBgMusic()
end

-- create layer
function GameScene:createLayer()
    local rootNode = cc.CSLoader:createNode("MainScene.csb")

    local menuPopup, menuTools, effectID
    
    local particle = rootNode:getChildByName("Particle_1")

    local function menuCallbackClose()
        cc.Director:getInstance():endToLua()
    end
    
    local function leftButtonCallback()
        particle:setPositionX(particle:getPositionX() - 1.0)
    end
    
    local function rightButtonCallback()
        particle:setPositionX(particle:getPositionX() + 1.0)
    end

    -- add handler for close item
    local menuToolsItem = rootNode:getChildByName("Button_1")
    menuToolsItem:addTouchEventListener(menuCallbackClose)
    
    local leftButton = rootNode:getChildByName("Button_Left")
    leftButton:addTouchEventListener(leftButtonCallback)
    
    local rightButton = rootNode:getChildByName("Button_Right")
    rightButton:addTouchEventListener(rightButtonCallback)

    return rootNode
end

return GameScene
