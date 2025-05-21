import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/animator"


local pd = playdate
local gfx = pd.graphics

class('Enemy').extends(gfx.sprite)

--CREATION OF IMAGE TABLE FOR ENEMY ANIMATION
--[[
ImageTable = gfx.imagetable.new(4)
local enemyImage1 = gfx.image.new("images/enemy1")
local enemyImage2 = gfx.image.new("images/enemy2")
local enemyImage3 = gfx.image.new("images/enemy3")
local enemyImage4 = gfx.image.new("images/enemy4")
EnemyImageTable:setImage(1,enemyImage1)
EnemyImageTable:setImage(2,enemyImage2)
EnemyImageTable:setImage(3,enemyImage3)
EnemyImageTable:setImage(4,enemyImage4)
EnemyAnimation = gfx.animation.loop.new(250,EnemyImageTable,true)
]]

--FIGURE OUT HOW TO MAKE SPRITE ANIMATIONS

EnemySpawnRate = 60
EnemyTimer = pd.frameTimer.new(EnemySpawnRate)
EnemyTimer.repeats = true

function Enemy:init()
    local enemyImage1 = gfx.image.new("images/enemy1")
    Enemy.super.init(self)
    self:setImage(enemyImage1) --FLAG
    self:setGroups(3)
    self:setCollideRect(2,2,10,10)
    local enemySpawnerLength = 50.26548
    local enemyTargetLength = 1507.964
    local spawnPoint = EnemySpawner:pointOnArc(math.random()*enemySpawnerLength)
    local targetPoint = EnemyTargetCircle:pointOnArc(math.random()*enemyTargetLength)
    self:moveTo(spawnPoint)
    local enemyAnimator = gfx.animator.new(10000,spawnPoint, targetPoint)
    self:setAnimator(enemyAnimator)
end

function Enemy:update()
    Enemy.super.update(self)
    local actualX, actualY, collisions, length = self:checkCollisions(self.x,self.y)

    if length > 0 then
        local otherSprite = self:overlappingSprites()
        if otherSprite[1] == BulletInstance then
            otherSprite[1]:removeSprite()
            self:removeSprite()
            PlayerScore += 1
            ScoreSound:play(1)
            LevelUpCheck()
        elseif otherSprite[1] == MoonInstance then
          GameOver = true
          otherSprite[1]:remove()
          MoonExplodeSound:play(1)
          NiceOrbit()
            --SCENE_MANAGER:switchScene(GameOverScene)
        end
    end
end


function EnemyTimerResetCheck()
  if EnemyTimer.frame == EnemySpawnRate then
    EnemySpawn()
  end
end

function ResetEnemyRate()
  EnemySpawnRate = (EnemySpawnRate) * (7/8)
  EnemySpawnRate = (EnemySpawnRate) // (1)
end


function EnemySpawn()
  EnemyInstance = Enemy()
  EnemyInstance:add()
  EnemyTimer:reset()
end

