-- Setup
local loader = require("AdvTiledLoader/Loader")
loader.path = "maps/"
local map = loader.load("sewers.tmx")
local SewerExample = {}

-- Resets the example
function SewerExample.reset()
	global.tx = 0
	global.ty = 0
end

-- Called from love.draw()
function SewerExample.draw()

	-- Set sprite batches
	map.useSpriteBatch = global.useBatch

	-- Scale and translate the game screen for map drawing
	local ftx, fty = math.floor(global.tx), math.floor(global.ty)
	love.graphics.push()
	love.graphics.scale(global.scale)
	love.graphics.translate(ftx, fty)
	
	-- Limit the draw range 
	if global.limitDrawing then 
		map:autoDrawRange(ftx, fty, global.scale, -100) 
	else 
		map:autoDrawRange(ftx, fty, global.scale, 50) 
	end
	
	-- Draw the map and the outline of the drawing area. If benchmark is checked then it draws 20 times.
	map:draw()
	if global.benchmark then for i=1,19 do map:draw() end end
	love.graphics.rectangle("line", map:getDrawRange())
	
	-- Reset the scale and translation.
	love.graphics.pop()
end

return SewerExample