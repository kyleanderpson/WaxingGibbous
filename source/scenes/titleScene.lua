

local pd = playdate
local gfx = pd.graphics

class('TitleScene').extends(gfx.sprite)

function TitleScene:init()
    local text = "WAXING GIBBOUS"
    local titleImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(titleImage)
        gfx.setFont(Topaz22Font)
        gfx.drawText(text,0,0)
    gfx.popContext()
    local titleSprite = gfx.sprite.new(titleImage)
    titleSprite:moveTo(200,40)
    titleSprite:add()
    InitializeScoreBoard()
    self:add()
    TitleSound:play(1)
end

function TitleScene:update()
    if pd.buttonJustPressed(pd.kButtonB) then
        SCENE_MANAGER:switchScene(GameScene)
    end
end