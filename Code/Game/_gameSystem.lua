local delta_time = love.timer.getTime()
---------------

local GAME_STATS = {score = 0, level = 1, highscore = 0}
GAME_STATS.LPS = 0.5 --Points Loss per second
GAME_STATS.PPD = 2 -- Points per drop
GAME_STATS.PPL = 200 -- Points per line

LAST_LPS = love.timer.getTime() -- GLOBAL DEFINE... MIGHT AS WELL MOVE IT LATER

GAME_STATS.goal = 600 -- Level 1 goal

function GAME_STATS:addScore(qnt)
    self.score = math.max(0, self.score + qnt)
end

function GAME_STATS:losePoints()
    self:addScore(- self.LPS)
end

function GAME_STATS:goalCheck()
    if self.score >= self.goal then
        GAME_OVER = true
        GAME_LEVEL_UP = true
    end
    if (love.keyboard.isDown("return") or TOUCH_CLICK)and GAME_OVER and GAME_LEVEL_UP then
        self.level = self.level +1
        GAME_OVER = false
        GAME_LEVEL_UP = false
        GRID:clear()
        self.goal = math.floor(600*self.level + 2.1^self.level)
        self.PPL = math.floor(self.PPL + 1.07^self.level)
        self.PPD = math.floor(self.PPD + 1.06^self.level)

        UPDATE_DELAY = (500 - (450*(self.level/7)) ) /1000
    elseif (love.keyboard.isDown("return") or TOUCH_CLICK) and GAME_OVER and not GAME_LEVEL_UP then
        self:restart()
    end
    TOUCH_CLICK = false
end

function GAME_STATS:restart()
    self.level = 1
    self.score = 0
    GAME_OVER = false
    GAME_LEVEL_UP = false
    GRID:clear()
    self.goal = math.floor(600*self.level + 2.1^self.level)
    self.PPL = math.floor(self.PPL + 1.07^self.level)
    self.PPD = math.floor(self.PPD + 1.06^self.level)
    UPDATE_DELAY = (500 - (450*(self.level/7)) ) /1000
end

-------
function GAME_STATS:checkSide(side)

    if side == "left" then
        sideVector = -1
    elseif side == "right" then
        sideVector = 1
    end

    for x = #CURRENT_TETROMINO.grid, 1, -1 do
        for y = #CURRENT_TETROMINO.grid[x], 1, -1 do
            if CURRENT_TETROMINO.grid[x][y] == 1 then
                local gridX, gridY
                gridX = CURRENT_TETROMINO.x + x
                gridY = CURRENT_TETROMINO.y + y
                if GRID.grid[gridX + sideVector][gridY] and GRID.grid[gridX + sideVector][gridY].density == 1 then
                    return false
                end
            end
        end
    end

    return true
end

function GAME_STATS:checkLine(index)
    local count = 0
    for i,v in ipairs(GRID.grid) do
        for j,v in ipairs(v) do
            if j == index and v.density == 1 then
                count = count +1
            end
        end
    end

    if count == GRID_W -1 then

        if Animation_line_obj then return end
        SOUND_DROP:stop()
        SOUND_LINE:stop()
        SOUND_LINE:play()
        Animation_line_obj = Animation_line:new({x = GAME_OFFSET_X + TILE_SIZE, y = GAME_OFFSET_Y + TILE_SIZE*(index) ,color = {1,0.15,0.1,0}})
        function Animation_line_obj:onEnd()
            for x = #GRID.grid, 1, -1 do
                for y = index, 1, -1 do
                    local i = x
                    local j = y
                    if y == index then
                        GRID.grid[i][j].rgb = {0.4,0.4,0.4,1}
                        GRID.grid[i][j].density = 0
                    elseif GRID.grid[x][y].density == 1 then
                        GRID.grid[i][j +1].density = 1
                        GRID.grid[i][j +1].rgb = GRID.grid[i][j].rgb

                        GRID.grid[i][j].rgb = {0.4,0.4,0.4,1}
                        GRID.grid[i][j].density = 0
                    end
                end
            end
            Animation_line_obj = null
            ANIM_PAUSE = false
        end
        Animation_line_obj:start()
        ANIM_PAUSE = true
        self:addScore(200)

    end
end

function GAME_STATS:rotate()
    local tb = CURRENT_TETROMINO.grid
    local rotatedTable = {}
    local col = false
    local trans_x = 0
    local trans_y = 0

    for i=1,#tb[1] do
        rotatedTable[i] = {}
        local cellNo = 0;
        for j=#tb,1,-1 do
            cellNo = cellNo + 1;
            rotatedTable[i][cellNo] = tb[j][i]
            col = tb[j][i] == 1 and (not GRID.grid[CURRENT_TETROMINO.x + i] or not GRID.grid[CURRENT_TETROMINO.x + i][CURRENT_TETROMINO.y + cellNo] or GRID.grid[CURRENT_TETROMINO.x + i][CURRENT_TETROMINO.y + cellNo].density == 1)
            if col then
                if      CURRENT_TETROMINO.x + i        > GRID_W -1     then trans_x = trans_x -1
                elseif  CURRENT_TETROMINO.y + cellNo   > GRID_H -1     then trans_y = trans_y -1
                else    return false                                end -- MUDAR ISTO PARA VERIFICAR SE PODEMOS MOVER ENTRE NÃO-LIMITES
            end
        end
    end
    CURRENT_TETROMINO.grid = rotatedTable
    CURRENT_TETROMINO.x = CURRENT_TETROMINO.x + trans_x
    CURRENT_TETROMINO.y = CURRENT_TETROMINO.y + trans_y
end

function GAME_STATS:draw_CurrentTetromino ()
    if (not IS_ACTIVE) then
        return
    end

    for i,v in ipairs(CURRENT_TETROMINO.grid) do
        for j,v in ipairs(v) do
            if (v == 1) then


                love.graphics.setColor(CURRENT_TETROMINO.rgb)
                love.graphics.rectangle( "fill", GAME_OFFSET_X + CURRENT_TETROMINO.x*TILE_SIZE + TILE_SIZE*i, GAME_OFFSET_Y + CURRENT_TETROMINO.y*TILE_SIZE + TILE_SIZE*j, TILE_SIZE, TILE_SIZE )
                love.graphics.setColor(0,0,0,1)
                love.graphics.rectangle( "line", GAME_OFFSET_X + CURRENT_TETROMINO.x*TILE_SIZE + TILE_SIZE*i, GAME_OFFSET_Y + CURRENT_TETROMINO.y*TILE_SIZE + TILE_SIZE*j, TILE_SIZE, TILE_SIZE )
            end
        end
    end
end

function GAME_STATS:update()
    if not IS_ACTIVE then return false end
    INPUT:update()

    if (love.timer.getTime() >= LAST_SIDEMOVE + KEY_DELAY ) then
        if INPUT_MOVE_LEFT then
            CURRENT_TETROMINO.x = CURRENT_TETROMINO.x -1
            LAST_SIDEMOVE = love.timer.getTime()
        elseif INPUT_MOVE_RIGHT  then
            CURRENT_TETROMINO.x = CURRENT_TETROMINO.x +1
            LAST_SIDEMOVE = love.timer.getTime()
        end
    end

    if INPUT_ROTATE and love.timer.getTime() >= LAST_ROTATE + KEY_DELAY +(100/1000) then
        GAMESYS:rotate()
        LAST_ROTATE = love.timer.getTime()
    end

    local UPDATE_DELAY = UPDATE_DELAY
    if INPUT_SPEED_DOWN then
        UPDATE_DELAY = UPDATE_DELAY/8
    end

    INPUT_MOVE_LEFT = false
    INPUT_MOVE_RIGHT = false
    INPUT_ROTATE = false
    INPUT_SPEED_DOWN = false

    if not (love.timer.getTime() >= LAST_UPDATE + UPDATE_DELAY) then return end

    LAST_UPDATE = love.timer.getTime()

    local willCollide = false
    for x = #CURRENT_TETROMINO.grid, 1, -1 do
        for y = #CURRENT_TETROMINO.grid[x], 1, -1 do
            if CURRENT_TETROMINO.grid[x][y] == 1 then
                local gridX, gridY
                gridX = CURRENT_TETROMINO.x + x
                gridY = CURRENT_TETROMINO.y + y
                if (gridY < 0) and not(GRID.grid[gridX][gridY +1]) then
                    willCollide = false
                    break
                end
                if (gridY +1 > GRID_H) or not GRID.grid[gridX][gridY +1] or (GRID.grid[gridX][gridY +1].density == 1) then willCollide = true end
            end
        end
    end

    if (willCollide == false) then
        CURRENT_TETROMINO.y = CURRENT_TETROMINO.y +1
    else
        IS_ACTIVE = false
        SOUND_DROP:stop()
        SOUND_DROP:play()
        GAMESYS:addScore(2)
        for i,v in ipairs (CURRENT_TETROMINO.grid) do
            for j,v in ipairs (v) do
                if v == 1 then
                    gridX = CURRENT_TETROMINO.x + i
                    gridY = CURRENT_TETROMINO.y + j
                    if gridY < 0 then
                        GAME_OVER = true
                    else
                        GRID.grid[gridX][gridY].density = 1
                        GRID.grid[gridX][gridY].rgb = CURRENT_TETROMINO.rgb
                    end
                end
            end
        end
	end

    for i = 0, GRID_H do
        GAMESYS:checkLine(i)
    end
end

---------
DEBUG:log("_gameSystem.lua loaded. Took "..math.floor( (love.timer.getTime() - delta_time)*1000 ).."ms.")
return GAME_STATS

--------------
