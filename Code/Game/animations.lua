Animation_line = Animation:new()
Animation_line:setTimeOut(0.9)
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
