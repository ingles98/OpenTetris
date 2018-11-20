local delta_time = love.timer.getTime()
----

Animation_line = Animation:new()
Animation_line:setTimeOut(0.7)
function Animation_line:draw()
	love.graphics.setColor(self.vars.color)
	love.graphics.rectangle("fill", self.vars.x, self.vars.y, (GRID_W-1) *TILE_SIZE, TILE_SIZE)
end

function Animation_line:onEnd()

end

function Animation_line:update()
	local alpha = self.vars.color[4] + 0.05
	self.vars.color[4] = alpha
end

----
DEBUG:log("_animations.lua loaded. Took "..math.floor( (love.timer.getTime() - delta_time)*1000 ).."ms.")
