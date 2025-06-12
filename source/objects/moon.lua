--MOON OBJECT IS THE PLAYER-CHARACTER
--ITS POSITION IS CONTROLLED BY THE CRANK POSITION
--PLAYER CAN SHOOT BULLETS FROM THE MOON TO TRY TO DEFEAT ENEMIES
--IF PLAYER SHOOTS THE EARTH, THE EARTH THEN GROWS
--IF PLAYER SHOOTS AN ENEMY, THE ENEMY AND THE BULLET ARE DESTROYED
--IF ENEMY TOUCHES MOON, THE MOON IS DESTROYED AND IT IS GAME OVER

import "CoreLibs/sprites"

local pd = playdate
local gfx = pd.graphics

class('Moon').extends(gfx.sprite)

function Moon:init()
    WaxImage = gfx.image.new("images/WAX")
    Moon.super.init(self)
    self:setImage(WaxImage)
    self:setCollideRect(4,4,(self.width - 8),(self.height - 8))
    self:moveTo(440,300) --POINT OFF SCREEN. AS SOON AS CRANK POSITION IS FOUND (WHICH IS IMMEDIATELY), MOON POSITION MATCHES CRANK
    self:add()
end

function Moon:update()
    Moon.super.update(self)
    MoonInstance:moveTo(Moonx,Moony) --Moonx and Moony ARE DECIDED BY CRANK POSITION
end

function MoonSpawn() --CREATES INSTANCE OF MOON OBJECT
  MoonInstance = Moon()
end