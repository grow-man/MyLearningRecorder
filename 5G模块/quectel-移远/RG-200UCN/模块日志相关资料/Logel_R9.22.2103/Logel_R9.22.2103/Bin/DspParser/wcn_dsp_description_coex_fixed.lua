--[[--------------------------------------------------------------------
lua script for description in dsp log

NOTE:  To add new address description:
Please add them in the end of this file, and follow the format below

--]]--------------------------------------------------------------------


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('In the function above, com timer cur value(low first)=0x%X', data)
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
COEX_STATUS =
{
[0x0]='BT_NULL_STATE',                      --0x0
[0x1]='BT_SLEEP_COEX_MODE',                 --0x1
[0x2]='BT_PAGE_INQUIRY_COEX_MODE',          --0x2
[0x3]='BT_ACL_COEX_MODE',                   --0x3
[0x4]='BT_SCO_COEX_MODE',                   --0x4
[0x5]='BT_BLE_COEX_MODE',                   --0x5
}

COEX_BT_TOPO =
{
    [0]='TOPO_PAGE',                        --0x0
    [1]='TOPO_INQUIRY',                     --0x1
    [2]='TOPO_PAGESCAN',                    --0x2
    [3]='TOPO_INQUIRYSCAN',                 --0x3
    [4]='TOPO_A2DP_EXIST',                  --0x4
    [5]='TOPO_ACL_LINK_NUM',                --0x5
    [6]='TOPO_ACL_SNIFF_LINK_NUM',          --0x6
    [7]='TOPO_SCO_LINK_NUM',                --0x7
    [8]='TOPO_SCO_INTERVAL',                --0x8
    [9]='TOPO_LE_LINK_NUM',                 --0x9
    [10]='TOPO_LE_INIT_RUNNING',            --0xa
    [11]='TOPO_LE_SCAN_RUNNING',            --0xb
    [12]='TOPO_LE_SCAN_PERCENT',            --0xc
    [13]='TOPO_LE_SCAN_PERIODIC',           --0xd
    [14]='TOPO_LE_ADV',                     --0xe
    [15]='TOPO_LE_ADV_HIGH_DUTY',           --0xf
    [16]='TOPO_LE_ADV_PERIODIC',            --0x10
    [17]='TOPO_MAX_NUM',
}

function func_desc_COEX_TP_D446_FIXED(address, data)
    return string.format('bt topo_id:%s, data:%d',COEX_BT_TOPO[bit.rshift(bit.band(data,0xff00),8)], bit.band(data,0xff))
end
-- end for one description



