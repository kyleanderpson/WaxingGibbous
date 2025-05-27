

local pd = playdate
local gfx = pd.graphics

class('TitleScene').extends(gfx.sprite)

function TitleScene:init()

    --TITLE TEXT SPRITE
    local text = "WAXING GIBBOUS"
    local titleImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(titleImage)
        gfx.setFont(Topaz22Font)
        gfx.drawText(text,0,0)
    gfx.popContext()
    local titleSprite = gfx.sprite.new(titleImage)
    titleSprite:moveTo(200,40)
    titleSprite:add()

    --START MESSAGE SPRITE
    local text = "PRESS 'B' TO START"
    gfx.setFont(Topaz11Font)
    local messageImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(messageImage)
        gfx.drawText(text,0,0)
    gfx.popContext()
    local messageSprite = gfx.sprite.new(messageImage)
    messageSprite:moveTo(200,60)
    messageSprite:add()
    
    InitializeScoreBoard()
    self:add()
    TitleSound:play(1)
end

function TitleScene:update()
    if pd.buttonJustPressed(pd.kButtonB) then
        SCENE_MANAGER:switchScene(GameScene)
    end
end