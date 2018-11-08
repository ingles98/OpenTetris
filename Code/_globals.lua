GRID_W = 10 +1
GRID_H = 15 +1
TILE_SIZE = 32

GAME_OFFSET_X = 6
GAME_OFFSET_Y = 6

IS_ACTIVE = false
GAME_OVER = false
GAME_LEVEL_UP = false -- Level up screen state

NEXT_TETROMINO = nil
CURRENT_TETROMINO = nil

LAST_UPDATE = love.timer.getTime( )
UPDATE_DELAY = 500/1000

LAST_SIDEMOVE = love.timer.getTime( )
KEY_DELAY = 100/1000
LAST_ROTATE = love.timer.getTime()

DEF_FONT = love.graphics.newFont(PATH_RES_FONT.."PressStart2P/PressStart2P.ttf", 15)
DEF_FONT_BIG_SIZE = 22
DEF_FONT_BIG = love.graphics.newFont(PATH_RES_FONT.."PressStart2P/PressStart2P.ttf", DEF_FONT_BIG_SIZE)
love.graphics.setFont(DEF_FONT)