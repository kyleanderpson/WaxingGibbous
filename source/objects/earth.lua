import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

class('Earth').extends(gfx.sprite)

function Earth:init(x,y,EarthGrowth)
    local earthInitRadius = 8
    EarthImage = gfx.image.new((earthInitRadius*2),(earthInitRadius*2))
    Earth.super.init(self)
    gfx.pushContext(EarthImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawCircleAtPoint(earthInitRadius,earthInitRadius,earthInitRadius)
    gfx.fillCircleAtPoint(earthInitRadius,earthInitRadius,earthInitRadius-2)
    gfx.popContext()
    self:setImage(EarthImage)
    self:setGroups(2)
    --self:setCollideRect(2,2,(earthInitRadius*2 - 4),(earthInitRadius*2 - 4))
    self:moveTo(x,y) --center screen

    EnemySpawner = pd.geometry.arc.new(x,y,earthInitRadius, 0,360) --CIRCLE ENEMY SPAWNER THAT MATCHES EARTH CIRCUMFERENCE
    --print("EnemySpawner Length: "..EnemySpawner:length())
end

function Earth:update()
    Earth.super.update(self)
    if EarthHits == 1 then
        GrowEarth(EarthGrowth)
        EarthGrowth += 1
        EarthHits = 0
    end
end

--CREATION OF EARTH
function InitializeEarth()
  EarthInstance = Earth(200,120,EarthGrowth)
  EarthInstance:add()
end

function GrowEarth(EarthGrowth)
    EarthImage = gfx.image.new((EarthGrowth + 8)*2,(EarthGrowth + 8)*2)
    gfx.pushContext(EarthImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawCircleAtPoint(8+EarthGrowth,8+EarthGrowth,8+EarthGrowth)
    gfx.fillCircleAtPoint(8+EarthGrowth,8+EarthGrowth,8+EarthGrowth-2)
    gfx.popContext()
    EarthInstance:setImage(EarthImage)
    --EarthInstance:setCollideRect(2,2,(8+EarthGrowth)*2-4,(8+EarthGrowth)*2-4)
    EnemySpawner = pd.geometry.arc.new(200,120,(8+EarthGrowth),0,360) --EnemySpawner grows as Earth grows
end