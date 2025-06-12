--WAXING GIBBOUS
import "universalFunctions"
MainImport()

local pd = playdate
local gfx = pd.graphics

FontLoad() --LOADS ALL FONT FILES

VariableSet() --INITIAL SET OF VARIABLES

SoundLoad() --LOADS ALL SOUND FILES

--[[ HERE IS HOW SCORE SAVE WORKS
--SaveTable has 40 indexes, of the 40 separate values stored in the scoreboard
--8 entries, with 5 indexes each
--it is taken from ScoreArray in the function ScoreArrayBreakDown()

--upon loading save, the data from SaveTable is saved in ScoreSave

--next we must make a function, ScoreArrayBuildUp, 
--which will store these 40 indexes back in the table-within-table format of ScoreArray, 
--and input it into ScoreArray table

--playdate.datastore.write(SaveTable,"scoreSave")
--ABOVE, WILL SAVE SaveTable into scoreSave.json
--when we pull it, we will need to build it back up into ScoreArray format

--LoadSave()
--print("first initial of 8th high score:")
--print(ScoreArray[8][2][1])

--ResetScoreBoardToTemplate()
]]
LoadSave() --CHECKS FOR SAVE DATA AND APPLIES IT (SCOREBOARD VALUES)

--ResetScoreBoardToTemplate()

----------------------------------------------------------------------------------------------------
SCENE_MANAGER = SceneManager() --OUR SCENE MANAGER CLASS IS INSTANTIALIZED


TitleScene() --LOADS OUR FIRST SCENE

gfx.setImageDrawMode(gfx.kDrawModeNXOR)
----------------------------------------------------------------------------------------------------
function pd.update()
    gfx.sprite.update()
    ScoreTracker() --THIS DRAWS OUR SCORE VALUE WHEN/WHERE WE NEED IT
    --DevMode() --SOME SHORTCUTS / HOTKEYS USEFUL FOR DEV
end
----------------------------------------------------------------------------------------------------

