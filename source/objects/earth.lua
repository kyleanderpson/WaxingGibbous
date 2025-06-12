--EARTH OBJECT SITS IN THE MIDDLE OF THE SCREEN
--CENTER OF EARTH IS TARGET (END POINT) OF EVERY BULLET TRAJECTORY
--IF BULLET HITS THE CENTER OF EARTH, EARTH WILL GROW
--IF EARTH GROWS ENOUGH TO REACH OUT AND TOUCH THE MOON, IT IS GAME OVER

import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

EarthHits = 0
EarthGrowth = 8

class('Earth').extends(gfx.sprite)

function Earth:init(x,y)
    EarthInitRadius = 8
    EarthImage = gfx.image.new((EarthInitRadius*2),(EarthInitRadius*2)) --EARTH STARTS WTIH RADIUS OF 8
    ContinentImageMold = gfx.image.new("images/earthSprite160")
    Earth.super.init(self)
    gfx.pushContext(EarthImage)
        gfx.setColor(gfx.kColorWhite)
        gfx.drawCircleAtPoint(EarthInitRadius,EarthInitRadius,EarthInitRadius)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillCircleAtPoint(EarthInitRadius,EarthInitRadius,EarthInitRadius-2)
        ContinentImageMold:drawScaled(0,0, ((EarthGrowth)/80)) --DRAWING CONTINENTS ONTO EARTH CIRCLE
    gfx.popContext()
    self:setImage(EarthImage)
    self:setGroups(2)
    self:setCollideRect(0,0,(EarthInitRadius*2),(EarthInitRadius*2))
    self:moveTo(x,y) --CENTER SCREEN

    EnemySpawner = pd.geometry.arc.new(x,y,EarthInitRadius, 0,360) --CIRCLE ENEMY SPAWNER THAT MATCHES EARTH CIRCUMFERENCE
    --print("EnemySpawner Length: "..EnemySpawner:length())
end

function Earth:update()
    --print("EarthHits: "..EarthHits)
    Earth.super.update(self)
    if EarthHits == 1 then
        GrowEarth(EarthGrowth) --EARTH RADIUS GROWS BY 8 EVERY TIME IT IS HIT
        print("EarthGrowth value before addition:"..EarthGrowth)
        EarthGrowth += 8 --HERE IS WHERE WE SET THE SIZE OF EARTH GROWTH UPON HIT
        print("EarthGrowth value after addition (equals current Earth radius):"..EarthGrowth)
        EarthHits = 0
    end
    
    --IF THE EARTH COLLIDES WITH THE MOON:
    local actualX, actualY, collisions, length = self:checkCollisions(self.x,self.y) --CREATES LIST OF SPRITES TOUCHING EARTH (WE CARE ABOUT LENGTH)
    if length > 0 then --IF MORE THAN 0 SPRITES ARE TOUCHING EARTH
        local otherSprite = self:overlappingSprites()
        if otherSprite[1] == MoonInstance then --IF SPRITE TOUCHING EARTH IS THE MOON
            if self:alphaCollision(MoonInstance) == true then --CHECKING ACTUAL PIXELS TOUCHING RATHER THAN COLLIDE RECT
                otherSprite[1]:removeSprite() --REMOVES MOON
                self:removeSprite() --REMOVES SELF
                GameOver = true --GAME OVER STATE
                NiceOrbit()
                MoonExplodeSound:play(1)
            end
        end
    end
end

function InitializeEarth() --CREATION OF EARTH INSTANCE
  EarthInstance = Earth(200,120)
  EarthInstance:add()
end

function GrowEarth(EarthGrowth)
    EarthImage = gfx.image.new((EarthGrowth + EarthInitRadius)*2,(EarthGrowth + EarthInitRadius)*2) --BIGGER EARTH IMAGE
    gfx.pushContext(EarthImage)
        gfx.setColor(gfx.kColorWhite)
        gfx.drawCircleAtPoint(EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillCircleAtPoint(EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth,EarthInitRadius+EarthGrowth-2) 
        ContinentImageMold:drawScaled(0,0, ((EarthGrowth+8)/80))
    gfx.popContext()
    EarthInstance:setImage(EarthImage)
    EarthInstance:setCollideRect(0,0,(EarthInitRadius+EarthGrowth)*2,(EarthInitRadius+EarthGrowth)*2)
    EnemySpawner = pd.geometry.arc.new(200,120,(8+EarthGrowth),0,360) --EnemySpawner GROWS AS EARTH GROWS
end