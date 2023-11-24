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

--【lte】
	func_list["0xD861"]=func_D861
	func_list["0xD873"]=func_D873
-- PDL DCI/DSCH
	func_list["0xD5A5"]=func_D5A5
-- Tx power
	func_list["0xD7E0"]=func_D7E0
	func_list["0xD7E1"]=func_D7E0    --0xD7E1 same as 0xD7E0
	func_list["0xD7E2"]=func_D7E0	 --0xD7E2 same as 0xD7E0
	func_list["0xD7E3"]=func_D7E0	 --0xD7E3 same as 0xD7E0
-- throughput rate
	func_list["0xD7EE"]=func_D7EE
	func_list["0xE7EE"]=func_D7EE    --0xE7EE same as 0xD7EE
	func_list["0xD7EF"]=func_D7EE	 --0xD7EF same as 0xD7EE
	func_list["0xE7EF"]=func_D7EE	 --0xE7EF same as 0xD7EE
-- N32k
	func_list["0xDF9CDF9B"]=func_DF9CDF9B
-- RSSI/AGC
	func_list["0xDD6ADD22"]=func_DD6ADD22
	func_list["0xDD6BDD26"]=func_DD6ADD22   -- 0xDD26 same as 0xDD22
	func_list["0xED6AED22"]=func_DD6ADD22   -- 0xED22 same as 0xDD22
	func_list["0xED6BED26"]=func_DD6ADD22   -- 0xED26 same as 0xDD22
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


-- data processing functions(lte)
function func_D861(address, data, name)
	return data-110
end

function func_D873(address, data, name)
 local val=0
  if bit.band(data,0x0001) == 0x01 then
      val=0
  elseif  bit.band(data,0x0002) == 0x02 then
      val=1
  elseif  bit.band(data,0x0004) == 0x04 then
      val=2
  elseif  bit.band(data,0x0008) == 0x08 then
      val=3
  elseif  bit.band(data,0x0010) == 0x0010 then
      val=4
  elseif  bit.band(data,0x0020) == 0x0020 then
      val=5
  elseif  bit.band(data,0x0040) == 0x0040 then
      val=6
  elseif  bit.band(data,0x0080) == 0x0080 then
      val=7
  elseif  bit.band(data,0x0100) == 0x0100 then
      val=8
  elseif  bit.band(data,0x0200) == 0x0200 then
      val=9
  elseif  bit.band(data,0x0400) == 0x0400 then
      val=10
  elseif  bit.band(data,0x0800) == 0x0800 then
      val=11
  elseif  bit.band(data,0x1000) == 0x1000 then
      val=12
  elseif  bit.band(data,0x2000) == 0x2000 then
      val=13
  elseif  bit.band(data,0x4000) == 0x4000 then
      val=14
  elseif  bit.band(data,0x8000) == 0x8000 then
      val=15
  else
      val=0
  end

  return val
end

function func_D5A5(address, data, name)
	if (name == "Imcs0") then
		return bit.rshift(bit.band(data,0xFF00),8)
	elseif (name == "Imcs1") then
		return bit.band(data,0x00FF)
	else
		return data
	end
end

function func_D7E0(address, data, name)
	local val=0
	if (data > 0x7FFF) then
		val = 65536 - data
		val = val/16
		val = val*-1
	else
		val = data/16
	end
	return val
end

function func_D7EE(address, data, name)
	return math.ceil( (data*8) )
end

function func_DF9CDF9B(addressL, dataL, nameL, addressH, dataH, nameH)
	return bit.lshift(dataH,16) +dataL
end

function func_DD6ADD22(addressL, dataL, nameL, addressH, dataH, nameH)
	local val= 10*( math.log10( dataL/math.pow(2,14) ) )
	return val - dataH
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
