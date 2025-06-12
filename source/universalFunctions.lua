local pd = playdate
local gfx = pd.graphics

--ALL OF OUR IMPORTANT GLOBAL FUNCTIONS ARE DECLARED HERE
--SOME SPECIFIC-TO-OBJECT FUNCTIONS (THOUGH STILL GLOBAL) 
--AND OTHERWISE MORE INTUITIVELY-LOCATED FUNCTIONS WILL BE FOUND WHERE WE (KYLE) EXPECT THEM TO BE
--(PROBABLY WITHIN THE OBJECT FILE)

function LoadSave() --WE WILL BE GRABBING HIGH SCORE DATA HERE.
    if playdate.file.exists("scoreSave.json") then --CHECK IF SAVE DATA EXISTS
      print("save data exists")
      ScoreSave = playdate.datastore.read("scoreSave") --REMEMBER, SAVE DATA IS ONLY ONE DEPTH ARRAY
      print("created ScoreSave")
      ScoreArrayBuildUp() --HERE WE TAKE EVERY INDEX OF SAVE DATA AND BUILD IT BACK INTO OUR ScoreArray FORMAT (NESTED ARRAYS)
    else
        LoadScoreBoardTemplate() --IF NO SAVE DATA EXISTS, WE USE OUR SCOREBOARD TEMPLATE
        print("no save data exists.\nusing scoreboard template")
    end
end

function ResetScoreBoardToTemplate() --WE CAN USE THIS TO RESET OUR SCOREBOARD
--LETS KEEP THIS FUNCTION IN OUR MAIN LUA FILE, COMMENTED OUT
--WHEN WE WANT TO WIPE SAVES, WE UN-COMMENT IT AND RUN BUILD-TASK
--ONLY RUN ONCE, THEN GO BACK AND COMMENT IT OUT.
--FOR NOW I AM USING THIS FUNCTION ONLY WHEN I WANT TO WIPE THE SCOREBOARD, AS DEVELOPER PRIVELEGE
--LATER, I MAY WANT TO ALLOW THIS AS AN OPTION (ON TITLE SCREEN) FOR THE PLAYER
  LoadScoreBoardTemplate()
  ScoreArrayBreakDown()
  pd.datastore.write(SaveTable, "scoreSave")
end

function DevMode() --HOTKEYS FOR DEVELOPMENT USE
--ACCESS HOTKEYS BY HOLDING 'A' AND 'B' BUTTONS FIRST. THEN D-PAD GIVES OPTIONS
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

function MainImport() --INCLUDES ALL IMPORTS FOR TOP OF MAIN LUA FILE
  import "CoreLibs/object"
  import "CoreLibs/graphics"
  import "CoreLibs/sprites"
  import "CoreLibs/timer"
  import "CoreLibs/crank"
  import "CoreLibs/animator"
  import "CoreLibs/animation"
  import "CoreLibs/frameTimer"

  import "class/sceneManager"

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

function FontLoad() --LOADS/DECLARES ALL FONTS AND SETS INITIAL FONT
  Topaz11Font = gfx.font.new("fonts/topaz_11")
  Topaz22Font = gfx.font.new("fonts/topaz_22")
  Topaz16Font = gfx.font.new("fonts/topaz_16")
  Diamond12Font = gfx.font.new("fonts/diamond_12")
  Diamond20Font = gfx.font.new("fonts/diamond_20")
  gfx.setFont(Topaz22Font)
end

function VariableSet() --SETS ALL INITIAL VALUES FOR GLOBAL VARIABLES
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

  EnemyTargetCircle = pd.geometry.arc.new(200,120,240,0,360) --LENGTH = 1507.964
  LevelCounter = 0

  ScreenCenterPoint = pd.geometry.point.new(200,120)
  Leveler = false
end

function SoundLoad() --LOADS/DECLARES ALL SOUNDS
--FOR NOW, WE ARE BLATANTLY PLAGIARIZING SOME OF MY FAVORITE ARCADE CABINETS
  ShootSound = pd.sound.sampleplayer.new("sounds/SHOOT/GALAGA_fire")
  ScoreSound = pd.sound.sampleplayer.new("sounds/SCORE/JOUST_lava")
  GameStartSound = pd.sound.sampleplayer.new("sounds/GAMESTART/JOUST_start")
  GameOverSound = pd.sound.sampleplayer.new("sounds/GAMEOVER/DK_die")
  TitleSound = pd.sound.sampleplayer.new("sounds/GAMESTART/DIGDUG_start")
  PhaseSound = pd.sound.sampleplayer.new("sounds/GAMESTART/MSPACMAN_firstloop")
  EarthHitSound = pd.sound.sampleplayer.new("sounds/SHOOT/GnG_woo")
  MoonExplodeSound = pd.sound.sampleplayer.new("sounds/GAMEOVER/GALAGA_explosion")
  LunarCycleSound = pd.sound.sampleplayer.new("sounds/LEVEL/DK_hammerhit")
end

function SaveGameScore() --THIS ONLY SAVES THE PlayerScore, WE IMPLEMENT IF GAME IS CLOSED OR SYSTEM SLEEPS
    -- SAVE SCORE INTO A TABLE FIRST
    local gameData = {
        currentScore = PlayerScore
    }
    --SERIALIZE SCORE INTO THE DATASTORE
    pd.datastore.write(gameData)
end

function playdate.gameWillTerminate() --AUTOMATICALLY SAVES SCORE IF GAME IS TERMINATED
--HONESTLY, I'M NOT SURE THIS IS THE RIGHT MOVE
    SaveGameScore()
end

function playdate.gameWillSleep() --AUTOMATICALLY SAVES SCORE IF SYSTEM SLEEPS
    SaveGameScore()
end

function NormalizeAngle(a) --KEEPS CRANK ANGLE WITHIN 0-360 RANGE
  if a >= 360 then a = a - 360 end
  if a < 0 then a = a + 360 end
  return a
end

function DegreesToCoords(OrbitAngle) --TURNS CRANK ANGLE INTO COORDINATES ON ELLIPSE (MOON ORBIT). RETURNS X AND Y
  local crankRads = math.rad(OrbitAngle)
  local newMoonx = math.sin(crankRads) * EllipticMultiplier
  local newMoony = -1 * math.cos(crankRads)

  newMoonx = (OrbitRadius * newMoonx) + OrbitCenterX
  newMoony = (OrbitRadius * newMoony) + OrbitCenterY

  return newMoonx,newMoony
end

function CrankInput() --CHECKS FOR CHANGE IN CRANK POSITION AND APPLIES IT TO MOON POSITION
    if CrankChange ~= 0 then
      OrbitAngle += CrankChange
      OrbitAngle = NormalizeAngle(OrbitAngle)
      Moonx,Moony = DegreesToCoords(OrbitAngle) --SETS MOON COORDS RELATIVE TO CRANK ANGLE
    end
end


function InitializeBackground() --CREATES BLACK RECTANGLE BACKGROUND
  local backgroundImage = gfx.image.new(400,240)
  gfx.pushContext(backgroundImage)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRect(0,0,400,240)
  gfx.popContext()
  local backgroundSprite = gfx.sprite.new(backgroundImage)
  backgroundSprite:moveTo(200,120)
  backgroundSprite:add()
end

function ScoreTracker() --DISPLAYS SCORE VALUE WHEN/WHERE WE NEED IT
  if SCENE_MANAGER.newScene == GameScene then
    gfx.drawTextAligned("SCORE: "..PlayerScore,5,5,kTextAlignment.left)
  elseif SCENE_MANAGER.newScene == GameOverScene then
    gfx.drawTextAligned("SCORE: "..PlayerScore,5,5,kTextAlignment.left)
  end
end

function FontSwitch(newFont) --SWITCHES FONT, OBVIOUSLY
  if FontCheck == true then
    gfx.setFont(newFont)
    FontCheck = false
  end
end

function LevelUpCheck() --HANDLES PROGRESSIVE DIFFICULTY
  print("performing LevelUpCheck")
    if (PlayerScore % 8) == 0 then --IF PlayerScore IS A MULTIPLE OF 8, WE INCREASE THE ENEMY SPAWN RATE
      LevelCounter += 1
      PhaseSound:play(1)
      ResetEnemyRate()
    end
  if PlayerScore % 30 == 0 then --IF PlayerScore  IS A MULTIPLE OF 30, WE INCREASE THE ENEMY TRAVEL-SPEED
    print("LUNAR CYCLE ACHIEVED!")
    LunarCycle() --THIS FUNCTION APPLIES TRAVEL-SPEED CHANGE
    print("called LunarCycle()")
  end
  if PlayerScore > 30 then
    if PlayerScore % 30 == 2 then
      CycleMessageSprite:remove() --HERE WE REMOVE THE LUNAR-CYCLE-MESSAGE ONCE PLAYER ACCUMULATES TWO POINTS INTO NEW CYCLE
    end
  end
end

function LunarCycle() --INCREASES ENEMY TRAVEL-SPEED AND DISPLAYS LUNAR-CYCLE-MESSAGE
  EnemySpeed = EnemySpeed * 3/4
  local text = "LUNAR CYCLE!"
  FontSwitch(Topaz11Font)
  local textImage = gfx.image.new(gfx.getTextSize(text))
  gfx.pushContext(textImage)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawText(text,0,0)
  gfx.popContext()
  CycleMessageSprite = gfx.sprite.new(textImage)
  CycleMessageSprite:moveTo(200,10)
  CycleMessageSprite:add()
  print("added CycleMessageSprite")
  LunarCycleSound:play(1)
end

function NiceOrbit() --HANDLES TEXT AFTER GAME OVER STATE IS ACHIEVED
--BASICALLY WE TELL THE PLAYER "NICE ORBIT!" AND TELL THEM TO PRESS 'A' TO CONTINUE (TO GameOverScene)
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

function AtoGameOver() --ALLOWS 'A' BUTTON PRESS TO SWITCH TO GameOverScene
  if AContinue == true then
    if pd.buttonJustPressed(pd.kButtonA) then
      SCENE_MANAGER:switchScene(GameOverScene)
      AContinue = false
    end
  end
end