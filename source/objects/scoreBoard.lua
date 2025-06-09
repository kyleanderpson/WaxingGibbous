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

function ReinitializeScoreBoard() --INCOMPLETE

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


function RankPlacement() --INCOMPLETE
--we will have RankOccurs (true or false)
--we will have BoardRank (1-8)  or (0)
--we will have ScoreArray, which we want to write into
--WE WANT TO WORK OUR WAY FROM THE BOTTOM UP, REWRITING
end

function ScoreRedraw() --INCOMPLETE
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

function RedoScoreArray()
    local pastScore1 = HighScore1
    local pastScore2 = HighScore2
    local pastScore3 = HighScore3
    local pastScore4 = HighScore4
    local pastScore5 = HighScore5
    local pastScore6 = HighScore6
    local pastScore7 = HighScore7
    --local pastScore8 = HighScore8
    local rank = BoardRank


    if rank == 8 then
        print("Attempting to shift scores")
        print("first initial of last score entry:")
        print(ScoreArray[8][2][1])
        HighScore8[2] = EntryArray
        HighScore8[3] = EntryScore
    elseif rank == 7 then
        HighScore8[2] = pastScore7[2]
        HighScore8[3] = pastScore7[3]

        HighScore7[2] = EntryArray
        HighScore7[3] = EntryScore
    elseif rank == 6 then
        HighScore8[2] = pastScore7[2]
        HighScore8[3] = pastScore7[3]

        HighScore7[2] = pastScore6[2]
        HighScore7[3] = pastScore6[3]

        HighScore6[2] = EntryArray
        HighScore6[3] = EntryScore
    elseif rank == 5 then
        HighScore8[2] = pastScore7[2]
        HighScore8[3] = pastScore7[3]

        HighScore7[2] = pastScore6[2]
        HighScore7[3] = pastScore6[3]

        HighScore6[2] = pastScore5[2]
        HighScore6[3] = pastScore5[3]

        HighScore5[2] = EntryArray
        HighScore5[3] = EntryScore
    elseif rank == 4 then
        HighScore8[2] = pastScore7[2]
        HighScore8[3] = pastScore7[3]

        HighScore7[2] = pastScore6[2]
        HighScore7[3] = pastScore6[3]

        HighScore6[2] = pastScore5[2]
        HighScore6[3] = pastScore5[3]

        HighScore5[2] = pastScore4[2]
        HighScore5[3] = pastScore4[3]

        HighScore4[2] = EntryArray
        HighScore4[3] = EntryScore
    elseif rank == 3 then
        HighScore8[2] = pastScore7[2]
        HighScore8[3] = pastScore7[3]

        HighScore7[2] = pastScore6[2]
        HighScore7[3] = pastScore6[3]

        HighScore6[2] = pastScore5[2]
        HighScore6[3] = pastScore5[3]

        HighScore5[2] = pastScore4[2]
        HighScore5[3] = pastScore4[3]

        HighScore4[2] = pastScore3[2]
        HighScore4[3] = pastScore3[3]

        HighScore3[2] = EntryArray
        HighScore3[3] = EntryScore
    elseif rank == 2 then
        HighScore8[2] = pastScore7[2]
        HighScore8[3] = pastScore7[3]

        HighScore7[2] = pastScore6[2]
        HighScore7[3] = pastScore6[3]

        HighScore6[2] = pastScore5[2]
        HighScore6[3] = pastScore5[3]

        HighScore5[2] = pastScore4[2]
        HighScore5[3] = pastScore4[3]

        HighScore4[2] = pastScore3[2]
        HighScore4[3] = pastScore3[3]

        HighScore3[2] = pastScore2[2]
        HighScore3[3] = pastScore2[3]

        HighScore2[2] = EntryArray
        HighScore2[3] = EntryScore
    elseif rank == 1 then
        HighScore8[2] = pastScore7[2]
        HighScore8[3] = pastScore7[3]

        HighScore7[2] = pastScore6[2]
        HighScore7[3] = pastScore6[3]

        HighScore6[2] = pastScore5[2]
        HighScore6[3] = pastScore5[3]

        HighScore5[2] = pastScore4[2]
        HighScore5[3] = pastScore4[3]

        HighScore4[2] = pastScore3[2]
        HighScore4[3] = pastScore3[3]

        HighScore3[2] = pastScore2[2]
        HighScore3[3] = pastScore2[3]

        HighScore2[2] = pastScore1[2]
        HighScore2[3] = pastScore1[3]

        HighScore1[2] = EntryArray
        HighScore1[3] = EntryScore
    end
end

function LoadScoreArrayFromTemplate()
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
    LoadScoreArrayFromTemplate()
end

function ScoreArrayBuildUp()
    Name1 = {ScoreSave[2],ScoreSave[3],ScoreSave[4]}
    Name2 = {ScoreSave[7],ScoreSave[8],ScoreSave[9]}
    Name3 = {ScoreSave[12],ScoreSave[13],ScoreSave[14]}
    Name4 = {ScoreSave[17],ScoreSave[18],ScoreSave[19]}
    Name5 = {ScoreSave[22],ScoreSave[23],ScoreSave[24]}
    Name6 = {ScoreSave[27],ScoreSave[28],ScoreSave[29]}
    Name7 = {ScoreSave[32],ScoreSave[33],ScoreSave[34]}
    Name8 = {ScoreSave[37],ScoreSave[38],ScoreSave[39]}
    HighScore1 = {ScoreSave[1],Name1, ScoreSave[5]}
    HighScore2 = {ScoreSave[6],Name2, ScoreSave[10]}
    HighScore3 = {ScoreSave[11],Name3, ScoreSave[15]}
    HighScore4 = {ScoreSave[16],Name4, ScoreSave[20]}
    HighScore5 = {ScoreSave[21],Name5, ScoreSave[25]}
    HighScore6 = {ScoreSave[26],Name6, ScoreSave[30]}
    HighScore7 = {ScoreSave[31],Name7, ScoreSave[35]}
    HighScore8 = {ScoreSave[36],Name8, ScoreSave[40]}
    LoadScoreArrayFromTemplate()
end

function ScoreArrayBreakDown()
    Save1_1 = ScoreArray[1][1]
    Save1_2 = ScoreArray[1][2][1]
    Save1_3 = ScoreArray[1][2][2]
    Save1_4 = ScoreArray[1][2][3]
    Save1_5 = ScoreArray[1][3]
    Save2_1 = ScoreArray[2][1]
    Save2_2 = ScoreArray[2][2][1]
    Save2_3 = ScoreArray[2][2][2]
    Save2_4 = ScoreArray[2][2][3]
    Save2_5 = ScoreArray[2][3]
    Save3_1 = ScoreArray[3][1]
    Save3_2 = ScoreArray[3][2][1]
    Save3_3 = ScoreArray[3][2][2]
    Save3_4 = ScoreArray[3][2][3]
    Save3_5 = ScoreArray[3][3]
    Save4_1 = ScoreArray[4][1]
    Save4_2 = ScoreArray[4][2][1]
    Save4_3 = ScoreArray[4][2][2]
    Save4_4 = ScoreArray[4][2][3]
    Save4_5 = ScoreArray[4][3]
    Save5_1 = ScoreArray[5][1]
    Save5_2 = ScoreArray[5][2][1]
    Save5_3 = ScoreArray[5][2][2]
    Save5_4 = ScoreArray[5][2][3]
    Save5_5 = ScoreArray[5][3]
    Save6_1 = ScoreArray[6][1]
    Save6_2 = ScoreArray[6][2][1]
    Save6_3 = ScoreArray[6][2][2]
    Save6_4 = ScoreArray[6][2][3]
    Save6_5 = ScoreArray[6][3]
    Save7_1 = ScoreArray[7][1]
    Save7_2 = ScoreArray[7][2][1]
    Save7_3 = ScoreArray[7][2][2]
    Save7_4 = ScoreArray[7][2][3]
    Save7_5 = ScoreArray[7][3]
    Save8_1 = ScoreArray[8][1]
    Save8_2 = ScoreArray[8][2][1]
    Save8_3 = ScoreArray[8][2][2]
    Save8_4 = ScoreArray[8][2][3]
    Save8_5 = ScoreArray[8][3]
    SaveTable = {
        [1] = Save1_1,
        [2] = Save1_2,
        [3] = Save1_3,
        [4] = Save1_4,
        [5] = Save1_5,
        [6] = Save2_1,
        [7] = Save2_2,
        [8] = Save2_3,
        [9] = Save2_4,
        [10] = Save2_5,
        [11] = Save3_1,
        [12] = Save3_2,
        [13] = Save3_3,
        [14] = Save3_4,
        [15] = Save3_5,
        [16] = Save4_1,
        [17] = Save4_2,
        [18] = Save4_3,
        [19] = Save4_4,
        [20] = Save4_5,
        [21] = Save5_1,
        [22] = Save5_2,
        [23] = Save5_3,
        [24] = Save5_4,
        [25] = Save5_5,
        [26] = Save6_1,
        [27] = Save6_2,
        [28] = Save6_3,
        [29] = Save6_4,
        [30] = Save6_5,
        [31] = Save7_1,
        [32] = Save7_2,
        [33] = Save7_3,
        [34] = Save7_4,
        [35] = Save7_5,
        [36] = Save8_1,
        [37] = Save8_2,
        [38] = Save8_3,
        [39] = Save8_4,
        [40] = Save8_5
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