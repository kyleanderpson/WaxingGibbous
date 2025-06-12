--ENEMY OBJECT
--SPAWNS FROM EARTH CIRCUMFERENCE(RANDOMIZED POINT), TRAVELS TO OFF SCREEN(RANDOMIZED POINT)
--IF ENEMY TOUCHES MOON, IT IS GAME OVER
--ENEMY SPEED AND SPAWN RATE INCREASE AS PLAYER SCORE INCREASES

import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/animator"

local pd = playdate
local gfx = pd.graphics

class('Enemy').extends(gfx.sprite)

EnemySpawnRate = 60 --THIS IS AMOUNT OF FRAMES, AT 30FPS THE ENEMY INITIALLY SPAWNS ONCE EVERY TWO SECONDS
EnemyTimer = pd.frameTimer.new(EnemySpawnRate)
EnemyTimer.repeats = true
EnemySpeed = 10000 --TRAVEL SPEED

function Enemy:init()
    local enemyImage1 = gfx.image.new("images/enemy1")
    Enemy.super.init(self)
    self:setImage(enemyImage1) --FLAG
    self:setGroups(3)
    self:setCollideRect(2,2,10,10)
    local enemySpawnerLength = (EarthInitRadius + EarthGrowth)*(2*3.14159265) --CIRCUMFERENCE EQUALS TWO-PI-R
    print("enemySpawnerLength: "..enemySpawnerLength)
    local enemyTargetLength = 1507.964
    local spawnPoint = EnemySpawner:pointOnArc(math.random()*enemySpawnerLength) --THIS IS POINT ON THE EARTH'S CIRCUMFERENCE
    local targetPoint = EnemyTargetCircle:pointOnArc(math.random()*enemyTargetLength) --THIS IS A POINT ON A CIRCLE THAT SURROUNDS THE SCREEN
    self:moveTo(spawnPoint)
    local enemyAnimator = gfx.animator.new(EnemySpeed,spawnPoint, targetPoint)
    self:setAnimator(enemyAnimator) --ANIMATOR IS A LINE SEGMENT (FROM EARTH CIRCUMFERENCE TO A POINT OFF-SCREEN) THAT BULLET FOLLOWS AT RATE OF EnemySpeed
end

function Enemy:update()
    Enemy.super.update(self)
    local actualX, actualY, collisions, length = self:checkCollisions(self.x,self.y)
    if length > 0 then --WE LOOK AT LENGTH OF LIST OF SPRITES TOUCHING ENEMY
      local otherSprite = self:overlappingSprites()
      if otherSprite[1] == BulletInstance then --IF COLLISION WITH BULLET:
          otherSprite[1]:removeSprite()
          self:removeSprite()
          PlayerScore += 1
          ScoreSound:play(1)
          LevelUpCheck()
      elseif otherSprite[1] == MoonInstance then --IF COLLISION WITH MOON
        GameOver = true
        otherSprite[1]:remove()
        MoonExplodeSound:play(1)
        NiceOrbit()
        end
    end
end

function EnemyTimerResetCheck() --SPAWNS AN ENEMY WHEN EnemyTimer REACHES VALUE OF EnemySpawnRate
  if EnemyTimer.frame == EnemySpawnRate then
    EnemySpawn() --TIMER IS RESET WITHIN THIS FUNCTION
  end
end

function ResetEnemyRate() --USED TO MAKE THE ENEMY SPAWN RATE QUICKER
  EnemySpawnRate = (EnemySpawnRate) * (7/8)
  EnemySpawnRate = (EnemySpawnRate) // (1)
end

function EnemySpawn()
  EnemyInstance = Enemy() --CREATES INSTANCE OF ENEMY
  EnemyInstance:add()
  EnemyTimer:reset() --RESETS TIMER HANDLING ENEMY SPAWN
end