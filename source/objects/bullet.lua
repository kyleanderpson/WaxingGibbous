import "CoreLibs/sprites"
--import "soundManager"

local pd = playdate
local gfx = pd.graphics

class('Bullet').extends(gfx.sprite)


function Bullet:init(x,y)
    local bulletImage = gfx.image.new("images/bullet")
    Bullet.super.init(self)
    self:setImage(bulletImage)
    self:setCollideRect(0,0,8,8)
    self:moveTo(x,y)
end

function Bullet:update()
    Bullet.super.update(self)

    if self.x == 200 and self.y == 120 then
        EarthHitSound:play(1)
        self:removeSprite()
        EarthHits += 1
    end
end

function BulletShootAllow()
  if pd.buttonJustPressed(pd.kButtonB) then
    local bulletStart = pd.geometry.point.new(Moonx,Moony) --BULLET SPAWN POINT IS MOON-CENTER
    BulletInstance = Bullet(Moonx,Moony) --CREATES BULLET INSTANCE AT MOON-CENTER
    BulletInstance:add()
    ShootSound:play(1)
    local bulletTrajectory = gfx.animator.new(1000,bulletStart,ScreenCenterPoint) --LINE SEGMENT ANIMATOR BETWEEN MOON-CENTER AND SCREEN-CENTER
    BulletInstance:setAnimator(bulletTrajectory)
  end
end