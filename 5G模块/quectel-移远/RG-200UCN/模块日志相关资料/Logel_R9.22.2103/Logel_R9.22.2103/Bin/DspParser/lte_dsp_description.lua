--[[--------------------------------------------------------------------
lua script to dynamic interpret dsp log and output description strings

NOTE:  To add new log interpreting functions:
step 1:  Add function reference in init_func_list
step 2:  Add function body

2008/9/9:  create, by xiaoguang.feng
--]]--------------------------------------------------------------------

-- for bit-wise operations
local bit = require"bit"

-- global function list table
func_list={}

-- initialize function list
function init_func_list()

end

-------------------------------------------------------------------------------------------------------------------------------------------------
-- main interface function, load by C functions -------------------------------------
-- NOTE: !!!!!!!!!!!!!!!!!!!!DON'T CHANGE THIS FUNCTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function dsp_desc( address, data )
	func_pt=func_list[address]

	if not func_pt then
		return ""
	else
		return func_list[address](address,data)
	end
end
