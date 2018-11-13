GUI = {} -- GLOBAL
function GUI:draw()
	local offsetX = love.graphics.getWidth() /2 + love.graphics.getWidth()/14
	local offsetY = love.graphics.getHeight() /10

	love.graphics.setFont(DEF_FONT_BIG)
	love.graphics.setColor(1,1,1,1)
	love.graphics.printf( "NEXT: ", offsetX, offsetY, 200, "left")

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

	offsetY = offsetY + love.graphics.getHeight()/16
	love.graphics.setColor(1,1,1,1)
	love.graphics.printf( "LEVEL: "..GAMESYS.level, offsetX, offsetY, 200, "left")
	love.graphics.printf( "SCORE: "..math.floor(GAMESYS.score), offsetX, offsetY + DEF_FONT_BIG_SIZE +4, 900, "left")
    love.graphics.printf( "GOAL: "..math.floor(GAMESYS.goal), offsetX, offsetY + 2*DEF_FONT_BIG_SIZE +4*2, 900, "left")

	if GAME_OVER and not GAME_LEVEL_UP then
		---	RECTANGLE FOR THE TEXT BOX
		local rec_w = love.graphics.getWidth() /3
		local rec_h = love.graphics.getHeight() / 4
		love.graphics.setColor(1,1,1,0.6)
		love.graphics.rectangle( "fill", love.graphics.getWidth()/2 - rec_w/2, love.graphics.getHeight()/2 - rec_h/2, rec_w, rec_h , rec_w/10, rec_w/10 )

		--- GAME OVER TEXT
		love.graphics.setColor(0,0,0,1)
		love.graphics.setFont(DEF_FONT_BIG)
		love.graphics.printf( "GAME OVER", love.graphics.getWidth()/2 - rec_w/2 + rec_w/12, love.graphics.getHeight()/2 - rec_h/4, rec_w - 2*(rec_w/12), "center")

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
		love.graphics.printf("Press ENTER to restart.", love.graphics.getWidth()/2 - rec_w/2 + rec_w/12, love.graphics.getHeight()/2 + rec_h/5, rec_w - 2*(rec_w/12), "center")
    elseif GAME_OVER and GAME_LEVEL_UP then
        ---	RECTANGLE FOR THE TEXT BOX
		local rec_w = love.graphics.getWidth() /3
		local rec_h = love.graphics.getHeight() / 4
		love.graphics.setColor(1,1,1,0.6)
		love.graphics.rectangle( "fill", love.graphics.getWidth()/2 - rec_w/2, love.graphics.getHeight()/2 - rec_h/2, rec_w, rec_h , rec_w/10, rec_w/10 )

		--- LEVEL UP TEXT
		love.graphics.setColor(0,0,0,1)
		love.graphics.setFont(DEF_FONT_BIG)
		love.graphics.printf( "LEVEL UP!", love.graphics.getWidth()/2 - rec_w/2 + rec_w/12, love.graphics.getHeight()/2 - rec_h/4, rec_w - 2*(rec_w/12), "center")

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
		love.graphics.printf("Press ENTER to proceed.", love.graphics.getWidth()/2 - rec_w/2 + rec_w/12, love.graphics.getHeight()/2 + rec_h/5, rec_w - 2*(rec_w/12), "center")
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
