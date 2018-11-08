GRID = {}
GRID.tileX = 0
GRID.tileY = 0
GRID.grid = {}

function GRID:clear ()
	for i=0, GRID_W -1 do
        self.grid[i] = {}
        for j=0, GRID_H -1 do
            self.grid[i][j] = {
                density = 0,
                rgb = {0.4,0.4,0.4,1}
            }
        end
    end
end

function GRID:draw()
    for i,v in ipairs(self.grid) do
        for j,v in ipairs(self.grid[i]) do
            love.graphics.setColor(self.grid[i][j].rgb)
            love.graphics.rectangle( "fill", GAME_OFFSET_X + TILE_SIZE*i, GAME_OFFSET_Y + TILE_SIZE*j, TILE_SIZE, TILE_SIZE )
            love.graphics.setColor(0,0,0,1)
            love.graphics.rectangle( "line", GAME_OFFSET_X + TILE_SIZE*i, GAME_OFFSET_Y + TILE_SIZE*j, TILE_SIZE, TILE_SIZE )
        end
    end
end

return GRID