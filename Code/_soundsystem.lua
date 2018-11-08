SOUND_DROP = love.audio.newSource(PATH_RES_SOUND.."/TetrominoDrop.wav", "static")
SOUND_LINE = love.audio.newSource(PATH_RES_SOUND.."/TetrisDestroyLine.wav", "static")

SOUND_DROP:setVolume(0.65)
SOUND_LINE:setVolume(0.8)