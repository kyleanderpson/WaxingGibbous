import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

class('Logo').extends(gfx.sprite)

function Logo:init()
    local logoImage = gfx.image.new("images/WAXingGibbousLOGO")
    local logoSprite = gfx.sprite.new(logoImage)
    logoSprite:moveTo(200,120)
    logoSprite:add()
end

function Logo:update()

end