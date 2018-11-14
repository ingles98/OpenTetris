io.stdout:setvbuf('no')

DEBUG_LOG_FILENAME = os.time(os.date("!*t"))
local date = os.date("%Y-%B")
love.filesystem.createDirectory("Logs/"..date )
DEBUG_LOG_FILE = love.filesystem.newFile("Logs/"..date.."/"..DEBUG_LOG_FILENAME..".txt")
DEBUG_LOG_FILE:open("w")

local startup_start_time = love.timer.getTime()
require '__startup'
DEBUG:log("Startup loaded. Took "..math.floor( (love.timer.getTime() - startup_start_time)*1000 ).."ms." )
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
		DEBUG.gpu.active = not DEBUG.gpu.active
	end
end

function love.quit()
    DEBUG_LOG_FILE:close()
end
