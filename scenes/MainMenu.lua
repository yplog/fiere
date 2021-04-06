local Scene = require("lib.Scene")
local Button = require("lib.ui.Button")

local MM = Scene:derive("MainMenu")

function MM:new(scene_manager)
    self.super(scene_manager)
    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()

    self.start_button = Button(sw / 4, sh - 100 , 140, 40, "Start")
    self.start_button:colors({172/255, 50/255, 50/255, 1}, {223/255, 65/255, 38/255, 1}, {200/255, 1/255, 200/255, 1})
    self.options_button = Button(sw / 4 + 200, sh - 100 , 140, 40, "Options")
    self.options_button:colors({172/255, 50/255, 50/255, 1}, {223/255, 65/255, 38/255, 1}, {200/255, 1/255, 200/255, 1})
    self.exit_button = Button(sw / 4 + 400, sh - 100, 140, 40, "Exit")
    self.exit_button:colors({172/255, 50/255, 50/255, 1}, {223/255, 65/255, 38/255, 1}, {200/255, 1/255, 200/255, 1})
    self.click = function(btn) self:on_click(btn) end
end

function MM:enter()
    _G.events:hook("onBtnClick", self.click)    
end

function MM:exit()
    _G.events:unhook("onBtnClick", self.click)
end

function MM:on_click(button)
    print("Button Clicked: " .. button.label)
    if button == self.start_button then
        print('play')
    elseif button == self.options_button then
        print('options')
    elseif button == self.exit_button then
        love.event.quit()
    end
end


function MM:update(dt)
    self.start_button:update(dt)
    self.options_button:update(dt)
    self.exit_button:update(dt)
end

function MM:draw()
    landing = love.graphics.newImage("assets/img/fiere.png")
    love.graphics.draw(landing)
    self.start_button:draw()
    self.options_button:draw()
    self.exit_button:draw()
    -- love.graphics.printf("Main Menu", 0, 25, love.graphics.getWidth(), "center")
end

return MM