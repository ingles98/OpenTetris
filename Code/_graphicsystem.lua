local delta_time = love.timer.getTime()
-----

function love.draw()
	TLfres.beginRendering(1080, 1920)
    GRAPHICSYS:draw()
	DEBUG:draw()
	TLfres.endRendering()
end

----
GUI = {} -- GLOBAL
function GUI:draw()
	local offsetX = 1080 /10
	local offsetY = 4*1920 /5

	love.graphics.setFont(DEF_FONT_BIG)
	love.graphics.setColor(1,1,1,1)
	love.graphics.printf( "NEXT: ", offsetX, offsetY, 1080, "left")

	if (NEXT_TETROMINO) then
        for i,v in ipairs(NEXT_TETROMINO.grid) do
            for j,v in ipairs(v) do
                if (v == 1) then
                    local GAME_OFFSET_X = offsetX + TILE_SIZE*3
                    local GAME_OFFSET_Y = offsetY - TILE_SIZE*1.1
                    local TILE_SIZE = TILE_SIZE/2

                    love.graphics.setColor(NEXT_TETROMINO.rgb)
                    love.graphics.rectangle( "fill", GAME_OFFSET_X + TILE_SIZE*i, GAME_OFFSET_Y + TILE_SIZE*j, TILE_SIZE, TILE_SIZE )
                    love.graphics.setColor(0,0,0,1)
                    love.graphics.rectangle( "line", GAME_OFFSET_X + TILE_SIZE*i, GAME_OFFSET_Y + TILE_SIZE*j, TILE_SIZE, TILE_SIZE )
                end
            end
        end
    end

	offsetY = offsetY + 1920/16
	love.graphics.setColor(1,1,1,1)
	love.graphics.printf( "LEVEL: "..GAMESYS.level, offsetX, offsetY, 1080, "left")
	love.graphics.printf( "SCORE: "..math.floor(GAMESYS.score), offsetX, offsetY + DEF_FONT_BIG_SIZE +4, 1080, "left")
    love.graphics.printf( "GOAL: "..math.floor(GAMESYS.goal), offsetX, offsetY + 2*DEF_FONT_BIG_SIZE +4*2, 1080, "left")

	if GAME_OVER and not GAME_LEVEL_UP then
		---	RECTANGLE FOR THE TEXT BOX
		local rec_w = 1080 /3
		local rec_h = 1920 / 4
		love.graphics.setColor(1,1,1,0.6)
		love.graphics.rectangle( "fill", 1080/2 - rec_w/2, 1920/2 - rec_h/2, rec_w, rec_h , rec_w/10, rec_w/10 )

		--- GAME OVER TEXT
		love.graphics.setColor(0,0,0,1)
		love.graphics.setFont(DEF_FONT_BIG)
		love.graphics.printf( "GAME OVER", 1080/2 - rec_w/2 + rec_w/12, 1920/2 - rec_h/4, rec_w - 2*(rec_w/12), "center")

		--- GAME OVER "Press ENTER to restart." TEXT
		if not ANIM_PRESS_START_FADE then ANIM_PRESS_START_FADE = 0 end
		if not ANIM_PRESS_START then ANIM_PRESS_START = false end

		ANIM_PRESS_START_FADE = ANIM_PRESS_START_FADE + love.timer.getDelta( )*2
		if ANIM_PRESS_START_FADE >= 1 then
			ANIM_PRESS_START_FADE = love.timer.getDelta( )
			ANIM_PRESS_START = not ANIM_PRESS_START
		end

		local fadeTime
		if ANIM_PRESS_START then fadeTime = (1 - ANIM_PRESS_START_FADE) else fadeTime = ANIM_PRESS_START_FADE end

		love.graphics.setColor(0,0,0,fadeTime)
		love.graphics.setFont(DEF_FONT)
		love.graphics.printf("Press ENTER to restart.", 1080/2 - rec_w/2 + rec_w/12, 1920/2 + rec_h/5, rec_w - 2*(rec_w/12), "center")
    elseif GAME_OVER and GAME_LEVEL_UP then
        ---	RECTANGLE FOR THE TEXT BOX
		local rec_w = 1920 /3
		local rec_h = 1080 / 4
		love.graphics.setColor(1,1,1,0.6)
		love.graphics.rectangle( "fill", 1080/2 - rec_w/2, 1920/2 - rec_h/2, rec_w, rec_h , rec_w/10, rec_w/10 )

		--- LEVEL UP TEXT
		love.graphics.setColor(0,0,0,1)
		love.graphics.setFont(DEF_FONT_BIG)
		love.graphics.printf( "LEVEL UP!", 1080/2 - rec_w/2 + rec_w/12, 1920/2 - rec_h/4, rec_w - 2*(rec_w/12), "center")

		--- LEVEL UP "Press ENTER to proceed." TEXT
		if not ANIM_PRESS_START_FADE then ANIM_PRESS_START_FADE = 0 end
		if not ANIM_PRESS_START then ANIM_PRESS_START = false end

		ANIM_PRESS_START_FADE = ANIM_PRESS_START_FADE + love.timer.getDelta( )*2
		if ANIM_PRESS_START_FADE >= 1 then
			ANIM_PRESS_START_FADE = love.timer.getDelta( )
			ANIM_PRESS_START = not ANIM_PRESS_START
		end

		local fadeTime
		if ANIM_PRESS_START then fadeTime = (1 - ANIM_PRESS_START_FADE) else fadeTime = ANIM_PRESS_START_FADE end

		love.graphics.setColor(0,0,0,fadeTime)
		love.graphics.setFont(DEF_FONT)
		love.graphics.printf("Press ENTER to proceed.", 1080/2 - rec_w/2 + rec_w/12, 1920/2 + rec_h/5, rec_w - 2*(rec_w/12), "center")
	end
end

GRAPHICSYS = {}
GRAPHICSYS.anim_draw_queue = {}
GRAPHICSYS.anim_update_queue = {}

function GRAPHICSYS:draw()
    GRID:draw()
    GAMESYS:draw_CurrentTetromino()
	GUI:draw()
	for k,v in ipairs(self.anim_draw_queue) do
		v:draw()
	end
end

function GRAPHICSYS:update()
	for k,v in ipairs(self.anim_update_queue) do
		v:fixedUpdate()
	end
end

---------
DEBUG:log("_graphicsystem.lua loaded. Took "..math.floor( (love.timer.getTime() - delta_time)*1000 ).."ms.")
