--GAME SCENE IS WHERE THE PLAY TAKES PLACE


local pd = playdate
local gfx = pd.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
    FontCheck = true
    
    --SETS INITIAL MOON-PLACEMENT ON ELLIPSE TO MATCH CRANK ANGLE
    local startPosition = pd.getCrankPosition()
    OrbitAngle = startPosition
    Moonx,Moony = DegreesToCoords(OrbitAngle)

    InitializeBackground() --INSTANTIATES BLACK RECTANGLE BACKGROUND
    InitializeEarth() --INSTANTIATES EARTH SPRITE AT SCREEN-CENTER
    MoonSpawn() --INSTANTIATES PLAYER-MOON

    GameStartSound:play(1)

    self:add()
end

function GameScene:update()
    CrankChange = pd.getCrankChange() --CHECKING FOR CRANK CHANGE EVERY FRAME
    if GameOver == false then --WHILE PLAY IS ACTIVE:
        pd.frameTimer.updateTimers()
        CrankInput()--HANDLES CRANK MOVEMENT AS INPUT
        BulletShootAllow() --IF 'B' BUTTON IS PRESSED, SHOOTS A BULLET FROM MOON
        EnemyTimerResetCheck() --RESETS ENEMY TIMER AFTER SET DURATION (EnemySpawnRate)
    else
        AtoGameOver() --IF GAME OVER, HIT 'A' TO CONTINUE TO GameOverScene
    end
end