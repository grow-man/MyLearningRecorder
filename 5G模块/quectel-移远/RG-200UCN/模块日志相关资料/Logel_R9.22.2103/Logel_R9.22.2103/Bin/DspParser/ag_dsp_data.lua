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
--【common】
	func_list["0xD5A0"]=func_D5A0
	func_list["0xD883"]=func_D883
	func_list["0xD811"]=func_D811
	func_list["0xD888"]=func_D888
	func_list["0xD894"]=func_D894
	func_list["0xD971"]=func_D971
	func_list["0xD972"]=func_D972
	func_list["0xD973"]=func_D973
	func_list["0xD974"]=func_D974
	func_list["0xD975"]=func_D975
	func_list["0xD976"]=func_D976
	func_list["0xD977"]=func_D977
	func_list["0xD978"]=func_D978
	func_list["0xD979"]=func_D979
	func_list["0xDF9CDF9B"]=func_DF9CDF9B

--【ag】
    func_list["0xD000"]=func_D000
    func_list["0xD000D0001"]=func_D000D0001
end


-- data processing functions(common)
function func_D5A0(address, data, name)
	local SNR_INT=bit.band(data,0x00FF)
	return SNR_INT
end

function func_D883(address, data, name)
	local SNR_INT=bit.rshift(bit.band(data,0xFF00),8)
	if (SNR_INT>0x7F) then
		return (SNR_INT-256)
	else
		return SNR_INT
	end
end

function func_D811(address, data, name)
	local FN1=bit.rshift(bit.band(data,0xFE00),9)

	return FN1
end

function func_D888(address, data, name)
	if (bit.band(data,0xFF)==1) then -- nagative
		return -bit.rshift(bit.band(data,0xFF00),8)
	else -- positive
		return bit.rshift(bit.band(data,0xFF00),8)
	end
end

function func_D894(address, data, name)
	return (data-110)
end

function func_D971(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D972(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D973(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D974(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D975(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D976(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D977(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D978(address, data, name)
	return bit.band(data,0xFFF)
end

function func_D979(address, data, name)
	return bit.band(data,0xFFF)
end

function func_DF9CDF9B(addressL, dataL, nameL, addressH, dataH, nameH)
	return bit.lshift(dataH,16) +dataL
end


-- data processing functions(ag)
function ag_single_addr_func_D000(address, data, name)	--Demo ag rat single address function
	return data
end

function ag_double_addr_func_D000D0001(addressL, dataL, nameL, addressH, dataH, nameH)   --Demo ag rat double address function
	return bit.lshift(dataH,16) +dataL
end


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
