
local MainScene = class("MainScene",function()
    return cc.Layer:create()
end)

function MainScene:create()
--    local scene = cc.Scene:create()
    local scene = cc.Scene:createWithPhysics()
    scene:getPhysicsWorld():setGravity(-0.5)
    scene:getPhysicsWorld():setSpeed(4)
    local layer = MainScene:new()
    layer:init()
    scene:addChild(layer)
    return scene
end


function MainScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
end

function MainScene:playBgMusic()
end

require("AnnPlaneLayer")
require("AnnEnemyLayer")
require("AnnBulletLayer")
require("AnnItemLayer")

math.randomseed(os.time())

local m_pSkySprite,m_pSkySpriteRe,m_fSkyHeight,m_fSkyVelocity

function MainScene:init()
    planeLayer = AnnPlaneLayer:create()
    enemyLayer = AnnEnemyLayer:create()
    bulletLayer = AnnBulletLayer:create()
    itemLayer = AnnItemLayer:create()
    
    local winSize = cc.Director:getInstance():getWinSize()
    local id = math.random(1, 5)
    local bgName = string.format("img_bg_%d.jpg", id)
    m_pSkySprite = cc.Sprite:create(bgName)
    m_pSkySpriteRe  = cc.Sprite:create(bgName)
    m_pSkySprite:setPosition(cc.p(winSize.width / 2, winSize.height / 2))
    m_fSkyHeight = m_pSkySprite:getContentSize().height;
    m_fSkyVelocity = -80
    m_pSkySpriteRe:setPosition(cc.p(winSize.width / 2, -m_fSkyHeight / 2))
    self:addChild(m_pSkySprite, -10)
    self:addChild(m_pSkySpriteRe, -10)
    self:addChild(planeLayer, 1)
    self:addChild(enemyLayer)
    self:addChild(bulletLayer)
    self:addChild(itemLayer)
    
    function update(dt)
        self:movingBackground(m_pSkySprite, dt)
        self:movingBackground(m_pSkySpriteRe, dt)
    end
    
    self:scheduleUpdateWithPriorityLua(update, 0)
    
    return true;
end

function MainScene:movingBackground(bgNode, time)
    bgNode:setPositionY(bgNode:getPositionY() + m_fSkyVelocity * time) 
    if (bgNode:getPositionY() < -m_fSkyHeight/2) then  
        bgNode:setPositionY(bgNode:getPositionY() + m_fSkyHeight * 2 - 2)
    end  
end

return MainScene
