--[[------------------------------------------------------------------------------------------------
		lua script to dynamic process dsp parameter

NOTE: To add new data processing functions:
step 1: select dsp rat table,such as [common_lte_tg_ag]_parameter_info
step 2: Add parameter in [common_lte_tg_ag]_parameter_info function body

--]]------------------------------------------------------------------------------------------------


--[[------------------------------------------------------------------------------------------------
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++BEGIN:	lte function body+++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--]]------------------------------------------------------------------------------------------------
lte_parameter_info=
{
-- RSSI/AGC
	["RSSI0"]								= "0xDD22,AGC0,(-250~0)",
	["RSSI0SCell"]					= "0xED22,AGC0,(-250~0)",
	["RSSI1"]								= "0xDD26,AGC1,(-250~0)",
	["RSSI1SCell"]					= "0xED26,AGC1,(-250~0)",
	["AGC0"]								= "0xDD6A,(0~255)",
	["AGC0SCell"]						= "0xED6A,(0~255)",
	["AGC1"]								= "0xDD6B,(0~255)",
	["AGC1SCell"]						= "0xED6B,(0~255)",

-- PHICH
	["nPhichGroup"]					= "0xD546,(0~50)",
	["nPhichSeq"]						= "0xD547,(0~7)",
	["nDetPhich"]						= "0xD549,(0;1;2)",
	["HI"]									= "0xD54A,(-1;0;1)",
	["NPhichSF"]						= "0xD548,(2;4)",
	["NPHICHGroup"]					= "0xD545,(0~50)",

-- UL DCI
	["ulImcs0"]							= "0xD58A,(0~31)",
	["ulImcs0SCell"]				= "0xE58A,(0~31)",

-- PDL DCI/DSCH
	["ServingCellId"]				= "0xD001,(0~503)",
	["DlTmMode"]						= "0xD50B,(1~8)",
	["DlHARQId"]						= "0xD5AE,(0~15)",
	["CRC"]									= "0xD51F,(0;1)",
	["DecRntiVal"]					= "0xD512,(0~65535)",
	["DecRntiType"]					= "0xD50C,(0~8)",
	["TbSwapFlag"]					= "0xD580,(0;1)",
	["TbNum"]								= "0xD581,(1;2)",
	["LayerTotalNum"]				= "0xD582,(1;2;3;4)",
	["RedundancyVersion0"]	= "0xD584,(0;1;2;3)",
	["RedundancyVersion1"]	= "0xD585,(0;1;2;3)",
	["NewDataIndicator0"]		= "0xD586,(0;1)",
	["NewDataIndicator1"]		= "0xD58C,(0;1)",
	["Imcs0"]								= "0xD5A5,(0~31)",
	["Imcs1"]								= "0xD5A5,(0~31)",
	["DecIterationNumber"]	= "0xD583,(0~127)",

-- Tx power
	["Pusch Tx power"]			="0xD7E0,(-51~23)",
	["Pucch Tx power"]			="0xD7E1,(-51~24)",
	["Prach Tx power"]			="0xD7E2,(-51~25)",
	["SRS Tx power"]				="0xD7E3,(-51~26)",
--
	["FN"]									="0xD203,(0~1023)",
	["sfn"]									="0xD205,(0~9)",
	["N32k"]								="N32k_L,N32k_H,(0~4294967295)",
	["N32k_L"]							="0xDF9B,(0~65535)",
	["N32k_H"]							="0xDF9C,(0~65535)",

-- UL Throughput Rate
	["ulRate"]							= "0xD7EE,(0~65535)",
	["ulTputSCell1"]				= "0xE7EE,(0~65535)",

-- DL Throughput Rate
	["dlRate"]							= "0xD7EF,(0~65535)",
	["dlTputSCell1"]				= "0xE7EF,(0~65535)",

-- BLER
	["ulBLER"]							= "0xD4D3,(0~100)",
	["dlBLER"]							= "0xD563,(0~100)",
	
-- RI
	["riPcc"]						= "0xD9AD,(1~2)",
	["riScc"]						= "0xE9AD,(1~2)",

--  TODO: Add extra parameter here




-- EndTag
	["EndTag"]	= "0x0000,(0~100)"

}

--[[------------------------------------------------------------------------------------------------
____________________________________________________________________________________________________
________________________________END:	lte function body_____________________________________________
____________________________________________________________________________________________________
--]]------------------------------------------------------------------------------------------------


init_dsp_parameter_table=
{
    [0]='lte_parameter_info'
}

-- main interface function, load by C functions -------------------------------------
-- NOTE: !!!!!!!!!!!!!!!!!!!!DON'T CHANGE THIS FUNCTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function dsp_parameter(paraName)
	return lte_parameter_info[paraName]             --lte dsp
end




--test
--[[----
print( dsp_parameter(0,'DemoAg') )
print( dsp_parameter(1,'NPHICHGroup') )--NPHICHGroup  nPhichGroup

--]]----
