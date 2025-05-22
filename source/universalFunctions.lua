local pd = playdate
local gfx = pd.graphics

function LoadSave()
-- we will be grabbing high score date here. Should be identical format to ScoreArray
    if playdate.file.exists("scoreSave.json") then
      print("save data exists")
      ScoreSave = playdate.datastore.read("scoreSave")
      print("created ScoreSave")
      ScoreArrayBuildUp()
    else
        LoadScoreBoardTemplate()
    end
end

function ResetScoreBoardToTemplate()
  LoadScoreBoardTemplate()
  ScoreArrayBreakDown()
  pd.datastore.write(SaveTable, "scoreSave")
end

function DevMode()
  if pd.buttonIsPressed(pd.kButtonA) then
    if pd.buttonIsPressed(pd.kButtonB) then
      --RIGHT D-PAD TO RESTART
      if pd.buttonJustPressed(pd.kButtonUp) then
        pd.restart()
      end
      --DOWN D-PAD TO GAME OVER
      if pd.buttonJustPressed(pd.kButtonDown) then
        SCENE_MANAGER:switchScene(GameOverScene)
      end
    end
  end
end

function MainImport()
  import "CoreLibs/object"
  import "CoreLibs/graphics"
  import "CoreLibs/sprites"
  import "CoreLibs/timer"
  import "CoreLibs/crank"
  import "CoreLibs/animator"
  import "CoreLibs/animation"
  import "CoreLibs/frameTimer"

  import "class/sceneManager"
  import "class/highScores"

  import "scenes/gameScene"
  import "scenes/titleScene"
  import "scenes/gameOverScene"

  import "objects/scoreBoard"
  import "objects/score"
  import "objects/bullet"
  import "objects/earth"
  import "objects/moon"
  import "objects/enemy"
  import "objects/initials"
end

function FontLoad()
  Topaz11Font = gfx.font.new("fonts/topaz_11")
Topaz22Font = gfx.font.new("fonts/topaz_22")
Topaz16Font = gfx.font.new("fonts/topaz_16")
Diamond12Font = gfx.font.new("fonts/diamond_12")
Diamond20Font = gfx.font.new("fonts/diamond_20")
gfx.setFont(Topaz22Font)
end

function VariableSet()
  PlayerScore = 0
  GameOver = false

  AContinue = false
  InitialsAreEntered = false

  OrbitRadius = 90
  OrbitCenterX = 200
  OrbitCenterY = 120
  OrbitAngle = 0
  EllipticMultiplier = 1.9
  MoonAnchorDiff = 22.5

  FontCheck = false

  EarthHits = 0
  EarthGrowth = 0

  EnemyTargetCircle = pd.geometry.arc.new(200,120,240,0,360) --LENGTH = 1507.964
  LevelCounter = 0

  ScreenCenterPoint = pd.geometry.point.new(200,120)
  Leveler = false
end

function SoundLoad()
  ShootSound = pd.sound.sampleplayer.new("sounds/SHOOT/GALAGA_fire")
  ScoreSound = pd.sound.sampleplayer.new("sounds/SCORE/JOUST_lava")
  GameStartSound = pd.sound.sampleplayer.new("sounds/GAMESTART/JOUST_start")
  GameOverSound = pd.sound.sampleplayer.new("sounds/GAMEOVER/DK_die")
  TitleSound = pd.sound.sampleplayer.new("sounds/GAMESTART/DIGDUG_start")
  PhaseSound = pd.sound.sampleplayer.new("sounds/GAMESTART/MSPACMAN_firstloop")
  EarthHitSound = pd.sound.sampleplayer.new("sounds/SHOOT/GnG_woo")
  MoonExplodeSound = pd.sound.sampleplayer.new("sounds/GAMEOVER/GALAGA_explosion")
end

function SaveGameData()
    -- Save game data into a table first
    local gameData = {
        currentScore = PlayerScore
    }
    -- Serialize game data table into the datastore
    pd.datastore.write(gameData)
end

function playdate.gameWillTerminate()
    SaveGameData()
end

-- Automatically save game data when the device goes
-- to low-power sleep mode because of a low battery
function playdate.gameWillSleep()
    SaveGameData()
end


--KEEPS CRANK ANGLE WITHIN 0-360 RANGE
function NormalizeAngle(a)
  if a >= 360 then a = a - 360 end
  if a < 0 then a = a + 360 end
  return a
end

--TURNS CRANK ANGLE INTO COORDINATES ON ELLIPSE
--RETURNS AN X AND Y
function DegreesToCoords(OrbitAngle)
  local crankRads = math.rad(OrbitAngle)
  local newMoonx = math.sin(crankRads) * EllipticMultiplier
  local newMoony = -1 * math.cos(crankRads)

  newMoonx = (OrbitRadius * newMoonx) + OrbitCenterX
  newMoony = (OrbitRadius * newMoony) + OrbitCenterY

  return newMoonx,newMoony
end

function CrankInput()
    if CrankChange ~= 0 then
      OrbitAngle += CrankChange
      OrbitAngle = NormalizeAngle(OrbitAngle)
      Moonx,Moony = DegreesToCoords(OrbitAngle) --SETS MOON COORDS RELATIVE TO CRANK ANGLE
    end
end

--CREATES BLACK RECTANGLE BACKGROUND
function InitializeBackground()
  local backgroundImage = gfx.image.new(400,240)
  gfx.pushContext(backgroundImage)
  gfx.setColor(gfx.kColorBlack)
  --gfx.setDitherPattern(0.9,gfx.image.kDitherTypeBayer2x2)
  gfx.fillRect(0,0,400,240)
  gfx.popContext()
  local backgroundSprite = gfx.sprite.new(backgroundImage)
  backgroundSprite:moveTo(200,120)
  backgroundSprite:add()
end

function ScoreTracker()
  if SCENE_MANAGER.newScene == GameScene then
    gfx.drawTextAligned("SCORE: "..PlayerScore,5,5,kTextAlignment.left)
  elseif SCENE_MANAGER.newScene == GameOverScene then
    gfx.drawTextAligned("SCORE: "..PlayerScore,5,5,kTextAlignment.left)
  end
end

function FontSwitch(newFont)
  if FontCheck == true then
    gfx.setFont(newFont)
    FontCheck = false
  end
end

function LevelUpCheck()
  if (PlayerScore % 8) == 0 then
    LevelCounter += 1
    PhaseSound:play(1)
    ResetEnemyRate()
  end
end

function LevelUp()
  
end

function NiceOrbit()
  local text = "NICE ORBIT!"
  FontSwitch(Topaz11Font)
  local textImage = gfx.image.new(gfx.getTextSize(text))
  gfx.pushContext(textImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawText(text,0,0)
  gfx.popContext()
  local textSprite = gfx.sprite.new(textImage)
  textSprite:moveTo(200,10)
  textSprite:add()

  local text = "PRESS 'A' TO CONTINUE"
  local textImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(textImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawText(text,0,0)
  gfx.popContext()
  local textSprite = gfx.sprite.new(textImage)
  textSprite:moveTo(200,24)
  textSprite:add()
  AContinue = true
  print("nice orbit triggered. AContinue value:")
  print(AContinue)
end

function AtoGameOver()
  if AContinue == true then
    if pd.buttonJustPressed(pd.kButtonA) then
      SCENE_MANAGER:switchScene(GameOverScene)
      AContinue = false
    end
  end
end