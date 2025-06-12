--BULLET IS THE OBJECT THAT THE MOON SHOOTS

import "CoreLibs/sprites"

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

    --IF A BULLET REACHES THE CENTER OF THE EARTH (WHICH IS THE END-POINNT OF IT'S TRAJECTORY)
    --IT REMOVES ITSELF AND MAKES THE EARTH GROW
    --ESSENTIALLY THIS IS A 'MISS' AND IS NOT IDEAL FOR THE PLAYER. IT TEACHES THEM TO BE ACCURATE
    if self.x == 200 and self.y == 120 then
        EarthHitSound:play(1)
        self:removeSprite()
        EarthHits += 1
    end
end

function BulletShootAllow() --LETS US SHOOT A BULLET BY PRESSING 'B' WHEN CONTROLLING THE MOON
  if pd.buttonJustPressed(pd.kButtonB) then
    local bulletStart = pd.geometry.point.new(Moonx,Moony) --BULLET SPAWN POINT IS MOON-CENTER
    BulletInstance = Bullet(Moonx,Moony) --CREATES BULLET INSTANCE AT MOON-CENTER
    BulletInstance:add()
    ShootSound:play(1)
    local bulletTrajectory = gfx.animator.new(1000,bulletStart,ScreenCenterPoint) --LINE SEGMENT ANIMATOR BETWEEN MOON-CENTER AND EARTH-CENTER
    BulletInstance:setAnimator(bulletTrajectory)
  end
end