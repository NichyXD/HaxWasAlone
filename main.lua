-- HAX WAS ALONE 0.1 ALPHA
-- Coded by NichyXD
-- 08/06/2016 -> 1st BUILD

--libraries
class = require 'libraries/middleclass'
require 'libraries/physics'
require 'libraries/event'
require 'libraries/gamefunctions'

--states
require 'states/title'
require 'states/game'
require 'states/intro'

_EMULATEHOMEBREW = (love.system.getOS() ~= "3ds")

function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  haxImage = love.graphics.newImage("graphics/haxp.png") -- LOAD BLUE 1ST PLAYER

  	controls = {
		["right"] = "cpadright",
		["left"] = "cpadleft",
		["up"] = "cpadup",
		["down"] = "cpaddown",
		["jump"] = "a",
		["pause"] = "start"
    }

  buildVersion = "0.1"
  bitFont = love.graphics.newFont("font/PIXEARG.ttf", 8)



  --loadSettings()

	gameFunctions.changeState("intro")
end

function love.draw()

  love.graphics.push()
	love.graphics.scale(scale, scale)
	 if _G[state .. "Draw"] then
		_G[state .. "Draw"]()
  end
  love.graphics.setFont(bitFont)
	love.graphics.setScreen('top')
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("FPS: " .. love.timer.getFPS(), love.graphics.getWidth() - bitFont:getWidth("FPS: " .. love.timer.getFPS()) - 3, gameFunctions.getHeight() - bitFont:getHeight("FPS: " .. love.timer.getFPS() - 1))

  love.graphics.setColor(255, 255, 255)
	love.graphics.print("FPS: " .. love.timer.getFPS(), love.graphics.getWidth() - bitFont:getWidth("FPS: " .. love.timer.getFPS()) - 2, gameFunctions.getHeight() - bitFont:getHeight("FPS: " .. love.timer.getFPS()))

	love.graphics.pop()

  --love.graphics.setColor(20,255,0,255)
  --love.graphics.print("Hello", 100, 100)
  --love.graphics.print(love.system.getOS(), 200, 200)
end

function love.keypressed(key)
	if _G[state .. "Keypressed"] then
		_G[state .. "Keypressed"](key)
	end

	if key == controls["debug"] then
		physdebug = not physdebug
	end
end

function love.keyreleased(key)
	if _G[state .. "Keyreleased"] then
		_G[state .. "Keyreleased"](key)
	end
end

require 'libraries/3ds'

--[[ GAME FUNCTIONS ]]--
gameFunctions = {}

function gameFunctions.changeState(toState, ...)
	state = toState

	local arg = {...}

	if _G[state .. "Init"] then
		_G[state .. "Init"](unpack(arg))
	end
end

function gameFunctions.getWidth(screen)
	if love.graphics.getScreen() == "bottom" then
		return 320
	end
	return 400
end

function gameFunctions.getHeight()
	return 240
end
