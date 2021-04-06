require("lib.utils.color-adaptation")

local Class = require("lib.Class")
local Vector2 = require("lib.Vector2")

local Button = Class:derive("Button")

local function color(r, g, b, a)
	colorAdaptation(r, g, b, a)

  return colorAdaptation(r, g, b, a)
end

local function gray(level, alpha)
	if alpha then
		alpha = alpha / 255
	end

	code = level / 255

	return {code, code, code, alpha or 1}
end

local function mouse_in_bounds(self, mx, my)
    return mx >= self.pos.x - self.w / 2 and mx <= self.pos.x + self.w / 2 and my >= self.pos.y - self.h / 2 and my <= self.pos.y + self.h / 2
end

function Button:new(x, y, w, h, label)
	self.pos = Vector2(x or 0, y or 0)
	self.w = w
	self.h = h
	self.label = label
	
	--Button Colors
	self.normal = color(128, 32, 32, 192)
	self.highlight = color(192, 32, 32, 1)
	self.pressed = color(1, 32, 32, 1)
	self.disabled = gray(128, 128)

	--Text colors
	self.text_normal = color(1)
	self.text_disabled = gray(128, 1)


	self.text_color = self.text_normal
	self.color = self.normal
	self.prev_left_click = false
	self.interactible = true
end

function Button:text_colors(normal, disabled)
	assert(type(normal) == "table", "normal parameter must be a table!")
	assert(type(disabled) == "table", "disabled parameter must be a table!")

	self.text_normal = normal
	self.text_disabled = disabled
end

function Button:colors(normal, highlight, pressed, disabled)
	assert(type(normal) == "table", "normal parameter must be a table!")
	assert(type(highlight) == "table", "highlight parameter must be a table!")
	assert(type(pressed) == "table", "pressed parameter must be a table!")
	--assert(type(disabled) == "table", "disabled parameter must be a table!")

	self.normal = normal
	self.highlight = highlight
	self.pressed = pressed
	--self.disabled = disabled or self.disabled
end

function Button:left(x)
	self.pos.x = x + self.w / 2
end

function Button:top(y)
	self.pos.y = y + self.h / 2
end

function Button:enable(enabled)
	self.interactible = enabled
	if not enabled then 
		self.color = self.disabled
		self.text_color = self.text_disabled
	else
		self.text_color = self.text_normal
	end
end

function Button:update(dt)
	if not self.interactible then return end
	
	x, y = love.mouse.getPosition()
	local left_click = love.mouse.isDown(1)
	local in_bounds = mouse_in_bounds(self, x, y)

	if in_bounds and not left_click then
		self.color = self.highlight
		if self.prev_left_click then
				_G.events:invoke("onBtnClick", self)
		end
	elseif in_bounds and left_click then
		self.color = self.pressed
	else
		self.color = self.normal
	end

	self.prev_left_click = left_click
end

function Button:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(self.color)
	--print(self.color[r], self.color[g], self.color[b])
	love.graphics.rectangle("fill", self.pos.x - self.w / 2, self.pos.y - self.h / 2, self.w, self.h, 4, 4)
	
	local f = love.graphics.getFont()
	local _, lines = f:getWrap(self.label, self.w)
	local fh = f:getHeight()

	love.graphics.setColor(self.text_color)
	love.graphics.printf(self.label, self.pos.x  - self.w / 2, self.pos.y - (fh /2 * #lines), self.w, "center")
	love.graphics.setColor(r, g, b, a)
end

return Button