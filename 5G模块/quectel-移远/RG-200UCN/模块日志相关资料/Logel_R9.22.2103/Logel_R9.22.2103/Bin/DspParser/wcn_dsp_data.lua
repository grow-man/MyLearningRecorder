--[[--------------------------------------------------------------------
lua script to dynamic process dsp data and output processed data

NOTE: To add new log processing functions:
step 1: Add function reference in init_func_list
step 2: Add function body

2008/9/14: create, by xiaoguang.feng
--]]--------------------------------------------------------------------

-- for bit-wise operations
local bit = require"bit"
local math = require"math"

-- global function list table
func_list={}

-- initialize function list
function init_func_list()
end


-- data processing functions


-- main interface function, load by C functions -------------------------------------
-- NOTE: !!!!!!!!!!!!!!!!!!!!DON'T CHANGE THIS FUNCTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function dsp_data(...)
    addressL,dataL,nameL,addressH,dataH,nameH = ...
	nameL    = nameL or ""
	addressH = addressH or 0
	dataH    = dataH or 0
	nameH    = nameH or ""

	strkey  = ""
	var_num = select('#', ...)

	if (var_num > 3) then
        address = bit.lshift(addressH,16) + addressL
	    strkey = string.format('0x%X',address)
	else
	    strkey = string.format('0x%X',addressL)
	end

	func_pt = func_list[strkey]

	if not func_pt then
		return dataL
	else
		if (var_num > 3) then
		    return func_list[strkey](addressL,dataL,nameL,addressH,dataH,nameH)
        else
		    return func_list[strkey](addressL,dataL,nameL)
	    end
	end
end