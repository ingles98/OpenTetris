local delta_time = love.timer.getTime()
------
local ANIM_TBL = {}
local _anim = { --super class
    time_out = 0,
    delay = 0,
    processing = false,
	pause = false,
	vars = {}
}

function _anim:new(vars)
    local o = {}
    setmetatable(o, self)
    self.__index = self
	o.vars = vars
    return o
end

function _anim:setTimeOut(t)
	self.time_out = t
end
function _anim:setDelay(t)
    self.delay = t
end

function _anim:start()
    self.processing = true
    STIGMA_LIB.enqueue(GRAPHICSYS.anim_draw_queue, self)
	STIGMA_LIB.enqueue(GRAPHICSYS.anim_update_queue, self)
    self.time_out_buffer = love.timer.getTime() + self.time_out
	self:onStart()
end

function _anim:stop()
	self:onEnd()
    self.processing = false
    assert(STIGMA_LIB.dequeue(GRAPHICSYS.anim_draw_queue, self),"Couldnt find and/or terminate animation inside queue. (anim_draw_queue)")
    assert(STIGMA_LIB.dequeue(GRAPHICSYS.anim_update_queue, self),"Couldnt find and/or terminate animation inside queue. (anim_update_queue)")
    self:destroy()
end

function _anim:pause()
	if not self.processing then return false end
	if not self.pause and STIGMA_LIB.dequeue(GRAPHICSYS.anim_update_queue, self) then
		self.pause = true
		return true
	elseif self.pause and STIGMA_LIB.enqueue(GRAPHICSYS.anim_update_queue, self) then
		self.pause = false
		return true
	end
	return false
end


function _anim:onStart()

end

function _anim:onEnd()

end

function _anim:destroy()
    self = null
    return true
end

function _anim:fixedUpdate()
	if love.timer.getTime() > self.time_out_buffer then
        self:stop()
    end
	self:update()
end

function _anim:update()

end

function _anim:draw()

end

-----
GLOBAL_ANIMSYS = {}
GLOBAL_ANIMSYS.anim_tbl = ANIM_TBL
GLOBAL_ANIMSYS.anim_class = _anim
Animation = GLOBAL_ANIMSYS.anim_class
ANIM_PAUSE = false
-----

DEBUG:log("_animsystem.lua loaded. Took "..math.floor( (love.timer.getTime() - delta_time)*1000 ).."ms.")
