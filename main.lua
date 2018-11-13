require '__startup'

------------------------------------------------------------------------------------------------

function love.update(dt)
    if (not IS_ACTIVE) and not GAME_OVER then --we just finished a piece
        IS_ACTIVE = true
        if (not CURRENT_TETROMINO) then
            CURRENT_TETROMINO = randomTETROMINO()
        else
            CURRENT_TETROMINO = NEXT_TETROMINO
        end
        NEXT_TETROMINO = randomTETROMINO()
    end

	if not GAME_OVER and not ANIM_PAUSE then
		GAMESYS:update()
        if love.timer.getTime() >= LAST_LPS + 1 then
            LAST_LPS = love.timer.getTime()
            GAMESYS:losePoints()
        end
	end
    GAMESYS:goalCheck()
    GRAPHICSYS:update()
end

function love.draw()
    GRAPHICSYS:draw()
	DEBUG:draw()
end

function love.load()
    GRID:clear()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f3" then
		DEBUG_GPU = not DEBUG_GPU
	end
end
