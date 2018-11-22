INPUT_MOVE_LEFT = false
INPUT_MOVE_RIGHT = false
INPUT_ROTATE = false
INPUT_SPEED_DOWN = false

TOUCH_THRESHOLD = 6

TOUCH_CURRENT = {
    id = nil,
    dx = 0,
    dy = 0
}

function love.touchmoved(id, x, y, dx, dy, pressure)
    TOUCH_CURRENT.dx = dx
    TOUCH_CURRENT.dy = dy
    if dy*0.7 > math.abs(dx) then
        if math.abs(dy) >= TOUCH_THRESHOLD then
            INPUT_SPEED_DOWN = true
        end
        return
    else
        if math.abs(dx) >= TOUCH_THRESHOLD then
            if dx > 0 and (CURRENT_TETROMINO.x +1 + #CURRENT_TETROMINO.grid < GRID_W  )  and GAMESYS:checkSide("right") then
                INPUT_MOVE_RIGHT = true
            elseif (dx < 0 and CURRENT_TETROMINO.x -1 >= 0) and GAMESYS:checkSide("left") then
                INPUT_MOVE_LEFT = true
            end
        end
    end

end

function love.touchpressed(id, x, y, dx, dy, pressure)
    --print("DY: "..dy.." ; DX: "..dx)
    --INPUT_ROTATE = true
    if not TOUCH_CURRENT.id then
        TOUCH_CURRENT.id = id
        TOUCH_CURRENT.dx = 0
        TOUCH_CURRENT.dy = 0
    end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    if TOUCH_CURRENT.id == id and math.abs(TOUCH_CURRENT.dx) <= 1 and math.abs(TOUCH_CURRENT.dy) <=1 then
        INPUT_ROTATE = true
        TOUCH_CURRENT.id = nil
        if not IS_ACTIVE then
            TOUCH_CLICK = true
        end
    elseif TOUCH_CURRENT.id == id then
        TOUCH_CURRENT.id = nil
    end
end

INPUT = {}
function INPUT:update()

    if (love.keyboard.isDown("left") and CURRENT_TETROMINO.x -1 >= 0) and GAMESYS:checkSide("left") then
        --CURRENT_TETROMINO.x = CURRENT_TETROMINO.x -1
        INPUT_MOVE_LEFT = true
    elseif (love.keyboard.isDown("right") and CURRENT_TETROMINO.x +1 + #CURRENT_TETROMINO.grid < GRID_W  )  and GAMESYS:checkSide("right") then
        --CURRENT_TETROMINO.x = CURRENT_TETROMINO.x +1
        INPUT_MOVE_RIGHT = true
    end

    if (love.keyboard.isDown("up")) then
        --GAMESYS:rotate()
        INPUT_ROTATE = true

    end

    if (love.keyboard.isDown("down")) then
        --UPDATE_DELAY = UPDATE_DELAY/8
        INPUT_SPEED_DOWN = true
    end
end
