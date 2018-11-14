local delta_time = love.timer.getTime()
TETROMINO_LINE = {
    grid = {
        {1,1,1,1}
    },
    rgb = {255/255, 255/255, 89/255,1}
}

TETROMINO_QUAD = {
    grid = {
        {1,1},
        {1,1}
    },
    rgb = {124/255, 196/255, 60/255,1}
}

TETROMINO_T = {
    grid = {
        {1,1,1},
        {0,1,0}
    },
    rgb = {212/255, 66/255, 244/255,1}
}


TETROMINO_L_LEFT = {
    grid = {
        {1,1,1},
        {1,0,0}
    },
    rgb = {18/255, 128/255, 232/255,1}
}

TETROMINO_L_RIGHT = {
    grid = {
        {1,0,0},
        {1,1,1}
    },
    rgb = {232/255, 17/255, 17/255,1}
}

TETROMINO_S_LEFT = {
    grid = {
        {1,1,0},
        {0,1,1}
    },
    rgb = {232/255, 163/255, 17/255,1}
}

TETROMINO_S_RIGHT = {
    grid = {
        {0,1,1},
        {1,1,0}
    },
    rgb = {17/255, 232/255, 174/255,1}
}

function randomTETROMINO ()
    local tbl
    if GAMESYS.level == 1 then
        tbl = STIGMA_LIB.pick(TETROMINO_LINE,TETROMINO_QUAD) --,TETROMINO_T,TETROMINO_L_LEFT,TETROMINO_L_RIGHT,TETROMINO_S_LEFT,TETROMINO_S_RIGHT)
    elseif GAMESYS.level == 2 then
        tbl = STIGMA_LIB.pick(TETROMINO_LINE,TETROMINO_QUAD,TETROMINO_T,TETROMINO_L_LEFT,TETROMINO_L_RIGHT) --TETROMINO_S_LEFT,TETROMINO_S_RIGHT)
    else
        tbl = STIGMA_LIB.pick(TETROMINO_LINE,TETROMINO_QUAD,TETROMINO_T,TETROMINO_L_LEFT,TETROMINO_L_RIGHT,TETROMINO_S_LEFT,TETROMINO_S_RIGHT)
    end
    tbl.x = math.floor(GRID_W/2 - (#tbl.grid)/2)
    tbl.y = -3

    return tbl
end

DEBUG:log("_tetrominos.lua loaded. Took "..math.floor( (love.timer.getTime() - delta_time)*1000 ).."ms.")
