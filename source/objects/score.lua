--SCORE OBJECT IS A SPRITE THAT DISPLAYS PlayerScore VALUE
--IT SITS IN THE TOP LEFT CORNER OF SCREEN DURING PLAY

import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

class('Score').extends(gfx.sprite)

function Score:init(x,y)
    FontSwitch(Topaz11Font)
    ScoreImage = gfx.imageWithText("SCORE: "..PlayerScore,390,16)
    Score.super.init(self)
    gfx.pushContext(ScoreImage)
        gfx.setImageDrawMode(gfx.kDrawModeNXOR)
    gfx.popContext()
    self:setImage(ScoreImage)
    self:moveTo(x,y)
end

function Score:update()
    Score.super.update(self)
end

function InitializeScore(x,y) --CREATES INSTANCE OF SCORE OBJECT
    ScoreInstance = Score(x,y)
    ScoreInstance:add()
end
