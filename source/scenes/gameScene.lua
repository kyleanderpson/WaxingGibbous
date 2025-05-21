

local pd = playdate
local gfx = pd.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
    FontCheck = true
    
    --SETS INITIAL MOON-PLACEMENT ON ELLIPSE TO MATCH CRANK ANGLE
    Moonx,Moony = DegreesToCoords(OrbitAngle)

    --INSTANTIATES BLACK RECTANGLE BACKGROUND
    InitializeBackground()

    --INSTANTIATES EARTH SPRITE AT SCREEN-CENTER
    InitializeEarth()

    --INSTANTIATES PLAYER-MOON
    MoonSpawn()

    GameStartSound:play(1)

    --FontSwitch(Topaz11Font)

    self:add()
end

function GameScene:update()
    CrankChange = pd.getCrankChange()
    if GameOver == false then
        pd.frameTimer.updateTimers()
        CrankInput()--HANDLES CRANK MOVEMENT AS INPUT
        BulletShootAllow() --IF 'B' BUTTON IS PRESSED, SHOOTS A BULLET FROM MOON
        EnemyTimerResetCheck() --RESETS ENEMY TIMER AFTER SET DURATION (EnemySpawnRate)
    else
        
    end
end