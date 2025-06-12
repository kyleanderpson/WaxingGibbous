import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

class('Initials').extends(gfx.sprite)

--initial entry yStart = 90
--initial entry xStart = 170 

InitialsCharacters = {--ARRAY OF INITIALS CHARACTERS
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

function InitialsEntryCheck() --HANDLES ENTRY OF SCORE INITIALS
    if pd.buttonJustPressed(pd.kButtonA) then
        InitialsAreEntered = true
        InitialsUnderlineSprite:remove() --INDICATES TO PLAYER THEIR INITIALS HAVE BEEN ENTERED
        print("Initials have been entered.")
        local initial1 = InitialsEntry[1] 
        local initial2 = InitialsEntry[2]
        local initial3 = InitialsEntry[3]
        EntryName = initial1..initial2..initial3 --INITIALS ARE CONCATENATED INTO A STRING
        EntryArray = {--INITIALS ARE SAVED AS THREE SEPARATE INDEXES
            [1] = initial1,
            [2] = initial2,
            [3] = initial3
        }
        EntryScore = PlayerScore
        print("EntryName: "..EntryName)
        print("EntryScore: "..EntryScore)
        print("\nAttempting RedoScoreArray()")
        RedoScoreArray() --FITS NEW SCORE INTO THE SCOREBOARD
        ScoreArrayBreakDown() --TURNS UPDATED SCOREBOARD INTO SAVE-ABLE FORMAT
        pd.datastore.write(SaveTable,"scoreSave") --SAVES UPDATED SCOREBOARD TO SYSTEM, AS ONE UN-NESTED ARRAY
    end
end

function Initials:init()
    --INITIALS COORDINATES VARIABLES
    InitialsSelectorSlot1 = 200
    InitialsSelectorSlot2 = 210
    InitialsSelectorSlot3 = 220
    InitialsSelectorY = 106

    SelectedInitial = 1 --WHERE THE UNDERLINE STARTS DURING ENTRY

    FontSwitch(Topaz11Font)
    EntryMessage() --TEXT ON SCREEN TO TELL PLAYER TO ENTER INITIALS

    --DEFAULT INITIALS ARE 'WAX'
    FirstInitial = 24 --'W'
    SecondInitial = 2 --'A'
    ThirdInitial = 25 --'X'
    InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
    InitialsDraw() --DRAWS INITIALS TEXT WHICH ARE UNDERLINED AND MANIPULATABLE
    InitialsSelector() --UNDERLINE SPRITE, WHICH SIGNIFIES SELECTED INTIAL TO BE CHANGED
    self:add()
end

function Initials:update()
    Initials.super.update(self)
    if InitialsAreEntered ~= true then
        print("checking value of HighScore8: "..tostring(HighScore8))
        InitialsEntryCheck()
        MoveInitialsSelector()
        InitialsChange()
    end
end

function EntryMessage() --DISPLAYS MESSAGE "ENTER YOUR INITIALS: "
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

function InitialsChange() --USED TO MANIPULATE INITIALS ENTRY
    if pd.buttonJustPressed(pd.kButtonDown) then --BRINGS INITIAL 'UP' TOWARDS 'A' OR BACK THROUGH CHARACTER LOOP
        if SelectedInitial == 1 then
            if FirstInitial < 27 then
                FirstInitial += 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            elseif FirstInitial == 27 then
                FirstInitial = 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            end
            Initial1Redraw()
        elseif SelectedInitial == 2 then
            if SecondInitial < 27 then
                SecondInitial += 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            elseif SecondInitial == 27 then
                SecondInitial = 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            end
            Initial2Redraw()
        elseif SelectedInitial == 3 then
            if ThirdInitial < 27 then
                ThirdInitial += 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            elseif ThirdInitial == 27 then
                ThirdInitial = 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            end
            Initial3Redraw()
        end
    end
    if pd.buttonJustPressed(pd.kButtonUp) then --BRINGS INITIAL 'DOWN' TOWARDS 'Z' OR BACK THROUGH CHARACTER LOOP
        if SelectedInitial == 1 then
            if FirstInitial > 1 then
                FirstInitial -= 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            elseif FirstInitial == 1 then
                FirstInitial = 27
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            end
            Initial1Redraw()
        elseif SelectedInitial == 2 then
            if SecondInitial > 1 then
                SecondInitial -= 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            elseif SecondInitial == 1 then
                SecondInitial = 27
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            end
            Initial2Redraw()
        elseif SelectedInitial == 3 then
            if ThirdInitial > 1 then
                ThirdInitial -= 1
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            elseif ThirdInitial == 1 then
                ThirdInitial = 27
                InitialsEntry = {InitialsCharacters[FirstInitial],InitialsCharacters[SecondInitial],InitialsCharacters[ThirdInitial]}
            end
            Initial3Redraw()
        end
    end
end

function InitializeInitials() --CREATES INITIALS OBJECT INSTANCE
    InitialsInstance = Initials()
    InitialsInstance:add()
end

function InitialsSelector() --UNDERLINE SPRITE TO SIGNIFY SELECTED INTIAL
    local underlineImage = gfx.image.new("images/initialsUnderline")
    InitialsUnderlineSprite = gfx.sprite.new(underlineImage)
    InitialsUnderlineSprite:moveTo(InitialsSelectorSlot1,InitialsSelectorY)
    InitialsUnderlineSprite:add()
end

function MoveInitialsSelector() --MOVES UNDERLINE SPRITE AND DECIDES WHICH INTIAL CAN BE CHANGED
    if pd.buttonJustPressed(pd.kButtonRight) then
        if InitialsUnderlineSprite.x == InitialsSelectorSlot1 then
            InitialsUnderlineSprite:moveTo(InitialsSelectorSlot2, InitialsSelectorY)
            SelectedInitial = 2
            print("SelectedInitial = "..SelectedInitial)
        elseif InitialsUnderlineSprite.x == InitialsSelectorSlot2 then
            InitialsUnderlineSprite:moveTo(InitialsSelectorSlot3, InitialsSelectorY)
            SelectedInitial = 3
            print("SelectedInitial = "..SelectedInitial)
        end
    end
    if pd.buttonJustPressed(pd.kButtonLeft) then
        if InitialsUnderlineSprite.x == InitialsSelectorSlot2 then
            InitialsUnderlineSprite:moveTo(InitialsSelectorSlot1, InitialsSelectorY)
            SelectedInitial = 1
            print("SelectedInitial = "..SelectedInitial)
        elseif InitialsUnderlineSprite.x == InitialsSelectorSlot3 then
            InitialsUnderlineSprite:moveTo(InitialsSelectorSlot2, InitialsSelectorY)
            SelectedInitial = 2
            print("SelectedInitial = "..SelectedInitial)
        end
    end
end

function InitialsDraw() --CALLS FUNCTIONS TO DRAW EACH INITIAL TO SCREEN
    Initial1Draw()
    Initial2Draw()
    Initial3Draw()
end

function Initial1Redraw() --REDRAWS INITIAL, CALLED WHEN INITIAL IS CHANGED
    Initial1Image:clear(gfx.kColorClear)
    if FirstInitial ~= 1 then
        gfx.pushContext(Initial1Image)
            gfx.setColor(gfx.kColorBlack)
            gfx.drawText(InitialsEntry[1],0,0)
        gfx.popContext()
    elseif FirstInitial == 1 then
        gfx.pushContext(Initial1Image)
            gfx.clear(gfx.kColorWhite)
        gfx.popContext()
    end
end

function Initial2Redraw() --REDRAWS INITIAL, CALLED WHEN INITIAL IS CHANGED
    Initial2Image:clear(gfx.kColorClear)
    if SecondInitial ~= 1 then
        gfx.pushContext(Initial2Image)
            gfx.setColor(gfx.kColorBlack)
            gfx.drawText(InitialsEntry[2],0,0)
        gfx.popContext()
    elseif SecondInitial == 1 then
        gfx.pushContext(Initial2Image)
            gfx.clear(gfx.kColorWhite)
        gfx.popContext()
    end
end

function Initial3Redraw() --REDRAWS INITIAL, CALLED WHEN INITIAL IS CHANGED
    Initial3Image:clear(gfx.kColorClear)
    if ThirdInitial ~= 1 then
        gfx.pushContext(Initial3Image)
            gfx.setColor(gfx.kColorBlack)
            gfx.drawText(InitialsEntry[3],0,0)
        gfx.popContext()
    elseif ThirdInitial == 1 then
        gfx.pushContext(Initial3Image)
            gfx.clear(gfx.kColorWhite)
        gfx.popContext()
    end
end

function Initial1Draw() --DRAWS FIRST INITIAL, CALLED IN InitialsDraw()
    Initial1Image = gfx.image.new(gfx.getTextSize(InitialsEntry[1]))
    gfx.pushContext(Initial1Image)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(InitialsEntry[1],0,0)
    gfx.popContext()
    Initial1Sprite = gfx.sprite.new(Initial1Image)
    Initial1Sprite:moveTo(200,100)
    Initial1Sprite:add()
end

function Initial2Draw() --DRAWS SECOND INITIAL, CALLED IN InitialsDraw()
    Initial2Image = gfx.image.new(gfx.getTextSize(InitialsEntry[2]))
    gfx.pushContext(Initial2Image)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(InitialsEntry[2],0,0)
    gfx.popContext()
    Initial2Sprite = gfx.sprite.new(Initial2Image)
    Initial2Sprite:moveTo(210,100)
    Initial2Sprite:add()
end

function Initial3Draw() --DRAWS THIRD INITIAL, CALLED IN InitialsDraw()
    Initial3Image = gfx.image.new(gfx.getTextSize(InitialsEntry[3]))
    gfx.pushContext(Initial3Image)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawText(InitialsEntry[3],0,0)
    gfx.popContext()
    Initial3Sprite = gfx.sprite.new(Initial3Image)
    Initial3Sprite:moveTo(220,100)
    Initial3Sprite:add()
end