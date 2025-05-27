import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

  EarthHits = 0
  EarthGrowth = 8

class('Earth').extends(gfx.sprite)

function Earth:init(x,y)
    EarthInitRadius = 8
    EarthImage = gfx.image.new((EarthInitRadius*2),(EarthInitRadius*2))
    Earth.super.init(self)
    gfx.pushContext(EarthImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawCircleAtPoint(EarthInitRadius,EarthInitRadius,EarthInitRadius)
    gfx.fillCircleAtPoint(EarthInitRadius,EarthInitRadius,EarthInitRadius-2)
    gfx.popContext()
    self:setImage(EarthImage)
    --self:setCollideRect(0,0,EarthInitRadius,EarthInitRadius)
    self:setGroups(2)
    self:setCollideRect(2,2,(EarthInitRadius*2 - 2),(EarthInitRadius*2 - 2))
    self:moveTo(x,y) --center screen

    EnemySpawner = pd.geometry.arc.new(x,y,EarthInitRadius, 0,360) --CIRCLE ENEMY SPAWNER THAT MATCHES EARTH CIRCUMFERENCE
    --print("EnemySpawner Length: "..EnemySpawner:length())
end

function Earth:update()
    --print("EarthHits: "..EarthHits)
    Earth.super.update(self)
    if EarthHits == 1 then
        GrowEarth(EarthGrowth)
        EarthGrowth += 8 --HERE IS WHERE WE SET THE SIZE OF EARTH GROWTH UPON HIT
        EarthHits = 0
        --EnemySpawner = pd.geometry.arc.new(200,120,EarthGrowth + EarthInitRadius, 0,360)
    end
    
    --IF THE EARTH COLLIDES WITH THE MOON:
    local actualX, actualY, collisions, length = self:checkCollisions(self.x,self.y)
    if length > 0 then
        local otherSprite = self:overlappingSprites()
        if otherSprite[1] == MoonInstance then
            if self:alphaCollision(MoonInstance) == true then
                otherSprite[1]:removeSprite() --REMOVES MOON
                self:removeSprite() --REMOVES SELF
                GameOver = true --GAME OVER STATE
                NiceOrbit()
                MoonExplodeSound:play(1)
            end
        end
    end
end

--CREATION OF EARTH
function InitializeEarth()
  EarthInstance = Earth(200,120)
  EarthInstance:add()
end

function GrowEarth(EarthGrowth)
    EarthImage = gfx.image.new((EarthGrowth + EarthInitRadius)*2,(EarthGrowth + EarthInitRadius)*2)
    gfx.pushContext(EarthImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawCircleAtPoint(EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth)
    gfx.fillCircleAtPoint(EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth-2)
    gfx.popContext()
    EarthInstance:setImage(EarthImage)
    EarthInstance:setCollideRect(2,2,(EarthInitRadius+EarthGrowth)*2-2,(EarthInitRadius+EarthGrowth)*2-2)
    EnemySpawner = pd.geometry.arc.new(200,120,(8+EarthGrowth),0,360) --EnemySpawner grows as Earth grows
end