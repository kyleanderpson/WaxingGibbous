--WAXING GIBBOUS
import "universalFunctions"
MainImport()

local pd = playdate
local gfx = pd.graphics

FontLoad()

VariableSet()

SoundLoad()

LoadScoreBoardTemplate()


--local gameData = pd.datastore.read() -- we will be grabbing high score date here
----------------------------------------------------------------------------------------------------
SCENE_MANAGER = SceneManager()
HIGH_SCORES = HighScores()

TitleScene()

gfx.setImageDrawMode(gfx.kDrawModeNXOR)
----------------------------------------------------------------------------------------------------
function pd.update()
    gfx.sprite.update()
    ScoreTracker()
    DevMode()
end
----------------------------------------------------------------------------------------------------

