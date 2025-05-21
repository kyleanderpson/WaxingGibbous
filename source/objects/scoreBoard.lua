import "CoreLibs/sprites"
import "CoreLibs/graphics"

local pd = playdate
local gfx = pd.graphics

class('ScoreBoard').extends(gfx.sprite)



function ScoreBoard:init()
    --local topScore = ScoreArray[1][3] --HOW TO GRAB THE SCORE VALUE FROM ENTRY WITHIN ScoreArray
    ScoreBoard.super.init(self)
    --ScoreToTextIndex() --makes copy of ScoreArray called "ScoreTextArray" where all entries are strings
    gfx.setFont(Topaz11Font)
    gfx.setColor(gfx.kColorBlack)
    ScoreDraw()
    --ScoreBoardPrintCheck()
    --HighScoreCheck() --is now in gameOverScene:init()
    self:add()
end

function ScoreBoard:update()
    ScoreBoard.super.update(self)
end

function InitializeScoreBoard()
    ScoreBoardInstance = ScoreBoard()
    ScoreBoardInstance:add()
end

function HighScoreCheck()
    print("\nHighScoreCheck")
    RankOccurs = false
    BoardRank = 0
    local scoreCheck = PlayerScore
    for i = 1,8 do --in ScoreArray
        local checkAgainst = ScoreArray[i][3]
        print("check PlayerScore:"..scoreCheck.." vs checkAgainst:"..checkAgainst)
        if scoreCheck > checkAgainst then
            print("Score has placed on the board!")
            RankOccurs = true
            BoardRank = i
            print("The score rank is: "..BoardRank)
            break
        elseif scoreCheck == checkAgainst then
            if i == 8 then
                print("Score matches lowest score on board. Does not rank")
            else
                print("Score matches board entry. Ranks lower")
                RankOccurs = true
                BoardRank = i + 1
                print("The score rank is: "..BoardRank)
            end
            break
        elseif scoreCheck < checkAgainst then
            if i == 8 then
                print("Score does not rank on the board.")
            end
        end
    end
    print("RankOccurs= "..tostring(RankOccurs))
    print("BoardRank = "..BoardRank)
    print("\n")
end


function RankPlacement()
--we will have RankOccurs (true or false)
--we will have BoardRank (1-8)  or (0)
--we will have ScoreArray, which we want to write into
--WE WANT TO WORK OUR WAY FROM THE BOTTOM UP, REWRITING
end

function ScoreDraw()
    local collumn1x = 150 --index number
    local collumn2x = 170 --inital 1
    local collumn3x = 180 --inital 2
    local collumn4x = 190 --initial 3
    local collumn5x = 250 --score value
    local verticalSpacing = 0
    local yStart = 120
    for i = 1,8 do --in ScoreArray
        local scoreEntry = ScoreArray[i]
        local initials = scoreEntry[2]

        local index1Image = gfx.image.new(gfx.getTextSize(scoreEntry[1]))
        gfx.pushContext(index1Image)
            gfx.drawText(scoreEntry[1],0,0)
        gfx.popContext()

        local initial1Image = gfx.image.new(gfx.getTextSize(initials[1]))
        gfx.pushContext(initial1Image)
            gfx.drawText(initials[1],0,0)
        gfx.popContext()

        local initial2Image = gfx.image.new(gfx.getTextSize(initials[2]))
        gfx.pushContext(initial2Image)
            gfx.drawText(initials[2],0,0)
        gfx.popContext()

        local initial3Image = gfx.image.new(gfx.getTextSize(initials[3]))
        gfx.pushContext(initial3Image)
            gfx.drawText(initials[3],0,0)
        gfx.popContext()

        local scoreImage = gfx.image.new(gfx.getTextSize(scoreEntry[3]))
        gfx.pushContext(scoreImage)
            gfx.drawText(scoreEntry[3],0,0)
        gfx.popContext()

        local index1Sprite = gfx.sprite.new(index1Image)
        local initial1Sprite = gfx.sprite.new(initial1Image)
        local initial2Sprite = gfx.sprite.new(initial2Image)
        local initial3Sprite = gfx.sprite.new(initial3Image)
        local scoreSprite = gfx.sprite.new(scoreImage)

        index1Sprite:setCenter(0,0.5)
        --initial1Sprite:setCenter(0,0.5)
        --initial2Sprite:setCenter(0,0.5)
        --initial3Sprite:setCenter(0,0.5)
        scoreSprite:setCenter(1,0.5)

        index1Sprite:moveTo(collumn1x,yStart+verticalSpacing)
        initial1Sprite:moveTo(collumn2x,yStart+verticalSpacing)
        initial2Sprite:moveTo(collumn3x,yStart+verticalSpacing)
        initial3Sprite:moveTo(collumn4x,yStart+verticalSpacing)
        scoreSprite:moveTo(collumn5x,yStart+verticalSpacing)

        verticalSpacing += 15
        index1Sprite:add()
        initial1Sprite:add()
        initial2Sprite:add()
        initial3Sprite:add()
        scoreSprite:add()
    end
end

function LoadScoreBoardTemplate() --creates ScoreArray, global array with all scoreboard info
    Name1 = {"W","A","X"}
    Name2 = {"K","Y","L"}
    Name3 = {"G","U","M"}
    Name4 = {"C","R","N"}
    Name5 = {"D","I","T"}
    Name6 = {"T","A","Y"}
    Name7 = {"J","R","D"}
    Name8 = {"D","A","N"}
    HighScore1 = {"1",Name1, 136}
    HighScore2 = {"2",Name2, 80}
    HighScore3 = {"3",Name3, 60}
    HighScore4 = {"4",Name4, 40}
    HighScore5 = {"5",Name5, 30}
    HighScore6 = {"6",Name6, 5}
    HighScore7 = {"7",Name7, 3}
    HighScore8 = {"8",Name8, 1}
    ScoreArray = {
        [1] = HighScore1,
        [2] = HighScore2,
        [3] = HighScore3,
        [4] = HighScore4,
        [5] = HighScore5,
        [6] = HighScore6,
        [7] = HighScore7,
        [8] = HighScore8
        }
end

function ScoreToTextIndex()
    ScoreTextArray = ScoreArray --make a copy of ScoreArray that will be edited to strings
  for i = 1, 8 do --ScoreTextArray
    local scoreGrab = ScoreTextArray[i]
    local scoreValueText = tostring(scoreGrab[3])
    scoreGrab[3] = scoreValueText
  end
end

function ScoreBoardPrintCheck() --prints out every index within ScoreArray
    for i = 1, 8 do
        local scoreGrab = ScoreArray[i]
        for j = 1,3 do
            if j == 2 then
                local initials = scoreGrab[2]
                for k = 1, 3 do
                    local prnt = tostring(initials[k])
                    print(prnt)
                end
            else
                local prnt = tostring(scoreGrab[j])
                print(prnt)
            end
        end
    end
end

function ScoreRankMessage()
    if RankOccurs == true then
        local rankText = "YOU HAVE RANKED "..tostring(BoardRank)
        print(rankText)
        FontSwitch(Topaz11Font)
        local rankMessageImage = gfx.image.new(gfx.getTextSize(rankText))
        gfx.pushContext(rankMessageImage)
            gfx.setColor(gfx.kColorBlack)
            gfx.drawText(rankText,0,0)
        gfx.popContext()
        local rankMessageSprite = gfx.sprite.new(rankMessageImage)
        rankMessageSprite:setCenter(1,0.5)
        rankMessageSprite:moveTo(190,88)
        rankMessageSprite:add()
    end
end