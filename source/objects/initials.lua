import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

class('Initials').extends(gfx.sprite)

--initial entry yStart = 90
-- initial entry xStart = 170 

--ARRAY OF INITIALS CHARACTERS
InitialsCharacters = {
    [1] = " ",
    [2] = "A",
    [3] = "B",
    [4] = "C",
    [5] = "D",
    [6] = "E",
    [7] = "F",
    [8] = "G",
    [9] = "H",
    [10] = "I",
    [11] = "J",
    [12] = "K",
    [13] = "L",
    [14] = "M",
    [15] = "N",
    [16] = "O",
    [17] = "P",
    [18] = "Q",
    [19] = "R",
    [20] = "S",
    [21] = "T",
    [22] = "U",
    [23] = "V",
    [24] = "W",
    [25] = "X",
    [26] = "Y",
    [27] = "Z"
}

function EntryMessage()
    --FontSwitch(Topaz11Font)
    local message = "ENTER YOUR INITIALS: "
    local messageImage = gfx.image.new(gfx.getTextSize(message))
    gfx.pushContext(messageImage)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(message,0,0)
    gfx.popContext()
    local messageSprite = gfx.sprite.new(messageImage)
    messageSprite:setCenter(1,0.5)
    messageSprite:moveTo(190,100)
    messageSprite:add()
end

function Initials:init()
    FontSwitch(Topaz11Font)
    --EntryMessage()
    InitialsEntry = {InitialsCharacters[24],InitialsCharacters[2],InitialsCharacters[25]}
    Initial1Image = gfx.image.new(gfx.getTextSize(InitialsEntry[1]))
    gfx.pushContext(Initial1Image)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(InitialsEntry[1],0,0)
    gfx.popContext()
    Initial1Sprite = gfx.sprite.new(Initial1Image)
    Initial1Sprite:moveTo(200,100)
    Initial1Sprite:add()

    Initial2Image = gfx.image.new(gfx.getTextSize(InitialsEntry[2]))
    gfx.pushContext(Initial2Image)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(InitialsEntry[2],0,0)
    gfx.popContext()
    Initial2Sprite = gfx.sprite.new(Initial2Image)
    Initial2Sprite:moveTo(210,100)
    Initial2Sprite:add()

    Initial3Image = gfx.image.new(gfx.getTextSize(InitialsEntry[3]))
    gfx.pushContext(Initial3Image)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(InitialsEntry[3],0,0)
    gfx.popContext()
    Initial3Sprite = gfx.sprite.new(Initial3Image)
    Initial3Sprite:moveTo(220,100)
    Initial3Sprite:add()

    self:add()
end

function Initials:update()
    Initials.super.update(self)
end

function InitializeInitials()
    InitialsInstance = Initials()
    InitialsInstance:add()
end