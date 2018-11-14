DEBUG = {}
DEBUG.logs = {}
DEBUG.gpu = STIGMA_LIB.love.debugGPU
DEBUG.gpu:setFont(DEF_FONT, DEF_FONT_SIZE)
DEBUG.verbose = false

function DEBUG:draw()
	self.gpu:draw()
end

function DEBUG:log(txt, verbose)
	if verbose and not self.verbose then return end
	
	local v_txt = os.date("%X")
	if verbose then v_txt = v_txt .. " [VERBOSE]" end
	v_txt = v_txt .. " -> "
	txt = v_txt .. txt
	print(txt)
	STIGMA_LIB.enqueue(self.logs, txt)
	DEBUG_LOG_FILE:write(txt.."\r\n")
end
