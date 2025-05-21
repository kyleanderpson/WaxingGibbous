import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

class('Moon').extends(gfx.sprite)

function Moon:init()
    WaxImage = gfx.image.new("images/WAX")
    Moon.super.init(self)
    self:setImage(WaxImage)
    self:setCollideRect(4,4,(self.width - 8),(self.height - 8))
    self:moveTo(120,100)
    self:add()
end

function Moon:update()
    Moon.super.update(self)
    MoonInstance:moveTo(Moonx,Moony)
    --[[
    local actualX, actualY, collisions, length = self:checkCollisions(self.x,self.y)

    if length > 0 then
        local otherSprite = self:overlappingSprites()
        if otherSprite[1] == EnemyInstance then
            SCENE_MANAGER:switchScene(GameOverScene)
            --self:removeSprite()
        end
        --otherSprite[1]:removeSprite()
        --self:removeSprite()
        --PlayerScore += 1
    end
    ]]
end

function MoonSpawn()
  MoonInstance = Moon()
end