local SM = require("lib.SceneManager")
local Event = require("lib.Events")

function love.load()
  -- game settings
  love.graphics.setDefaultFilter('nearest', 'nearest')
  local font = love.graphics.newFont("assets/font/dogica.ttf", 16)
  love.graphics.setFont(font)

  _G.events = Event(false)

  sm = SM("scenes", {"MainMenu"})
  sm:switch("MainMenu")
end

function love.update(dt)
  sm:update(dt)
end

function love.draw()
  sm:draw()
end