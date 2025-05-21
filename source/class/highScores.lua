local pd = playdate
local gfx = pd.graphics

class('HighScores').extends()

function HighScores:checkPlacement()

end

function HighScores:printHighScores()
    local highScore1 = {1,"WAX", 150}
    local highScore2 = {2,"KYL", 140}
    local highScore3 = {3,"GUM", 130}
    local highScore4 = {4,"WAX", 120}
    local highScore5 = {5,"DIT", 110}
    local highScore6 = {6,"TAY", 100}
    local highScore7 = {7,"JRD", 90}
    local highScore8 = {8,"DAN", 80}
    local scoreArray = {
        [1] = highScore1,
        [2] = highScore2,
        [3] = highScore3,
        [4] = highScore4,
        [5] = highScore5,
        [6] = highScore6,
        [7] = highScore7,
        [8] = highScore8
        }
    for i = 1, 8 do
        local scoreGrab = scoreArray[i]
        for j = 1,3 do
            local prnt = tostring(scoreGrab[j])
            print(prnt)
        end
    end
end