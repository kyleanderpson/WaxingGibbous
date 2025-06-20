--GameOverScene DISPLAYS SCOREBOARD AND ALLOWS PLAYER TO INPUT HIGH SCORE INITIALS IF THEY RANK
local pd = playdate
local gfx = pd.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init()
    FontCheck = true
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    
    --GAME OVER TEXT
    FontSwitch(Topaz22Font)
    local text = "GAME OVER"
    local titleImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(titleImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(text,0,0)
    gfx.popContext()
    local titleSprite = gfx.sprite.new(titleImage)
    titleSprite:moveTo(200,20)
    titleSprite:add()

    --RESTART MESSAGE
    local text = "PRESS 'B' TO TRY AGAIN"
    gfx.setFont(Topaz11Font)
    local messageImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(messageImage)
        gfx.drawText(text,0,0)
    gfx.popContext()
    local messageSprite = gfx.sprite.new(messageImage)
    messageSprite:moveTo(200,40)
    messageSprite:add()

    InitializeScoreBoard() --CREATES INSTANCE OF SCOREBOARD OBJECT
    HighScoreCheck() --CHECKS TO SEE IF PLAYER RANKED ON THE BOARD
    ScoreRankMessage() --TELLS PLAYER THEIR RANK
    if RankOccurs == true then
        InitializeInitials() --IF RANKED, MANIPULATABLE INITIALS OBJECT IS CREATED
    end
    
    self:add()
    print(text)

    GameOverSound:play(1)
end

function GameOverScene:update()
    if pd.buttonJustPressed(pd.kButtonB) then --HITTING 'B' WILL KICK RESTART GAME, ALLOWS FOR SKIPPING INITIALS ENTRY
        pd.restart()
    end
end

