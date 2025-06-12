--WE USE OUR CLASS 'SceneManger' TO SWITCH BETWEEN SCENES

local pd = playdate
local gfx = pd.graphics

class('SceneManager').extends()

function SceneManager:switchScene(scene)
    self.newScene = scene
    self:loadNewScene()
end

function SceneManager:loadNewScene()
    self:cleanupScene()
    self.newScene()
end

function SceneManager:cleanupScene()
    gfx.sprite.removeAll()
    self:removeAllTimers()
end

function SceneManager:removeAllTimers()
    local allTimers = pd.timer.allTimers()
    for _, timer in ipairs(allTimers) do
        timer:remove()
    end
end