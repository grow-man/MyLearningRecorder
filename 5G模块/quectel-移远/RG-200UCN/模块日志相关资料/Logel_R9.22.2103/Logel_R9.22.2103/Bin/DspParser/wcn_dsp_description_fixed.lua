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
TYPE_SUB=
{
[0x00]='ASSOC_REQ',       --0x00
[0x10]='ASSOC_RSP',       --0x10
[0x20]='REASSOC_REQ',       --0x20
[0x30]='REASSOC_RSP',       --0x30
[0x40]='PROBE_REQ',       --0x40
[0x50]='PROBE_RSP',       --0x50
[0x80]='BEACON',       --0x80
[0x90]='ATIM',       --0x90
[0xA0]='DISASOC',       --0xA0
[0xB0]='AUTH',       --0xB0
[0xC0]='DEAUTH',       --0xC0
[0xD0]='ACTION',       --0xD0
[0xA4]='PS_POLL',       --0xA4
[0xB4]='RTS',       --0xB4
[0xC4]='CTS',       --0xC4
[0xD4]='ACK',       --0xD4
[0xE4]='CFEND',       --0xE4
[0xF4]='CFEND_ACK',       --0xF4
[0x08]='DATA',       --0x08
[0x18]='DATA_ACK',       --0x18
[0x28]='DATA_POLL',       --0x28
[0x38]='DATA_POLL_ACK',       --0x38
[0x48]='NULL_FRAME',       --0x48
[0x58]='CFACK',       --0x58
[0x68]='CFPOLL',       --0x68
[0x78]='CFPOLL_ACK',       --0x78
[0x88]='QOS_DATA',       --0x88
[0x98]='QOS_DATA_ACK',       --0x98
[0xA8]='QOS_DATA_POLL',       --0xA8
[0xB8]='QOS_DATA_POLL_ACK',       --0xB8
[0xC8]='QOS_NULL_FRAME',       --0xC8
[0xE8]='QOS_CFPOLL',       --0xE8
[0xF8]='QOS_CFPOLL_ACK',       --0xF8
[0x84]='BLOCKACK_REQ',       --0x84
[0x94]='BLOCKACK',           --0x94
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if TYPE_SUB[bit.band(data,0xFF)] then
        return string.format('tx success=%d, tx (sub)type=%s @coex_process_tx_comp_sta()', bit.rshift(bit.band(data,0xFF00),8), TYPE_SUB[bit.band(data,0xFF)])
    else
        return string.format('tx success=%d, tx (sub)type: %d @coex_process_tx_comp_sta()', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description

function func_desc_UPT_Dxxx_FIXED(address, data)
    if TYPE_SUB[data] then
        return string.format('wifi rx complete isr handler,rx header type = %s @tx_complete_isr()', TYPE_SUB[data])
    else
        return string.format('wifi rx complete isr handler,rx header type: 0x%X @tx_complete_isr()', data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
MAC_FSM_STATE=
{
[0]='DISABLED',                --0x00
    'ENABLED',                 --0x01
    'WAIT_START',              --0x02
    'WAIT_SCAN',               --0x03
    'SCAN_COMP',               --0x04
    'WAIT_JOIN',               --0x05
    'JOIN_COMP',               --0x06
    'WAIT_AUTH_SEQ2',          --0x07
    'WAIT_AUTH_SEQ4',          --0x08
    'AUTH_COMP',               --0x09
    'WAIT_ASOC',               --0x0A
    'MAX_STA_MAC_FSM_STATE',   --0x0B
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if MAC_FSM_STATE[data] then
        return string.format('sta mac state = %s', MAC_FSM_STATE[data])
    else
        return string.format('sta mac state: 0x%X', data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
mac_status=
{
[0]='MAC_DISCONNECTED',          --0x00
    'MAC_CONNECTED',             --0x01
    'MAC_SCAN_CMP',              --0x02
[6]='MAC_CONNECT_FAILED',        --0x06
[8]='MAC_DUT_CONN_SOFTAP',       --0x08
[9]='MAC_DUT_DISCONN_SOFTAP',    --0x09
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if mac_status[data] then
        return string.format('mac status = %s', mac_status[data])
    else
        return string.format('mac status: 0x%X', data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
Marlin_State=
{
[0]='NULL',          --0x00
    'FM_ONLY',       --0x01
    'BT_ONLY',       --0x02
    'BT_FM',         --0x03
    'WIFI_ONLY',     --0x04
    'WIFI_FM',       --0x05
    'WIFI_BT',       --0x06
    'WIFI_BT_FM',    --0x07
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if Marlin_State[data] then
        return string.format('marlin_state = %s @marlin_register_setting()', Marlin_State[data])
    else
        return string.format('marlin_state: 0x%X @marlin_register_setting()', data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
ARM_CLK=
{
[0]='26M',       --0x00
    '64M',       --0x01
    '80M',       --0x02
    '139M',      --0x03
    '160M',      --0x04
    '278M',      --0x05
    '320M',      --0x06
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if ARM_CLK[data] then
        return string.format('mcu clk = %s @marlin_register_setting_clock()', ARM_CLK[data])
    else
        return string.format('mcu clk: 0x%X @marlin_register_setting_clock()', data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
PS_STATE=
{
[0]='ACTIVE',       --0x00
    'DOZE',         --0x01
    'AWAKE',        --0x02
    'STA_SLEEP',    --0x03
    'PS_STATE_NONE',--0x04
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if PS_STATE[data] then
        return string.format('machw can not enter sleep, status = %s @can_machw_enter_sleep()', PS_STATE[data])
    else
        return string.format('machw can not enter sleep, status: 0x%X @can_machw_enter_sleep()', data)
    end
end
-- end for one description



-- BELOW IS FROM BT PART



-- used in func_desc_UPT_DD02_FIXED
-- NOTE:  by default, lua table start with index=1
HCI_COMMAND_TYPE_LC_G=
{
[0]='HCI_INQUIRY',                                     --(0x0001 + LC_G)
    'HCI_INQUIRY_CANCEL',                              --(0x0002 + LC_G)
    'HCI_PERIODIC_INQUIRY_MODE',                       --(0x0003 + LC_G)
    'HCI_EXIT_PERIODIC_INQUIRY_MODE',                  --(0x0004 + LC_G)
    'HCI_CREATE_CONNECTION',                           --(0x0005 + LC_G)
    'HCI_DISCONNECT',                                  --(0x0006 + LC_G)
    'HCI_ADD_SCO_CONNECTION',                          --(0x0007 + LC_G)
    'HCI_CREATE_CONNECTION_CANCEL',                    --(0x0008 + LC_G)
    'HCI_ACCEPT_CONNECTION_REQUEST',                   --(0x0009 + LC_G)
    'HCI_REJECT_CONNECTION_REQUEST',                   --(0x000A + LC_G)
    'HCI_LINK_KEY_REQUEST_REPLY',                      --(0x000B + LC_G)
    'HCI_LINK_KEY_REQUEST_NEGATIVE_REPLY',             --(0x000C + LC_G)
    'HCI_PIN_CODE_REQUEST_REPLY',                      --(0x000D + LC_G)
    'HCI_PIN_CODE_REQUEST_NEGATIVE_REPLY',             --(0x000E + LC_G)
    'HCI_CHANGE_CONNECTION_PACKET_TYPE',               --(0x000F + LC_G)
    'UNKNOWN',                                         --
    'HCI_AUTHENTICATION_REQUESTED',                    --(0x0011 + LC_G)
    'UNKNOWN',                                         --
    'HCI_SET_CONNECTION_ENCRYPTION_ENABLE',            --(0x0013 + LC_G)
    'UNKNOWN',                                         --
    'HCI_CHANGE_CONNECTION_LINK_KEY',                  --(0x0015 + LC_G)
    'UNKNOWN',                                         --
    'HCI_MASTER_LINK_KEY',                             --(0x0017 + LC_G)
    'UNKNOWN',                                         --
    'HCI_REMOTE_NAME_REQUEST',                         --(0x0019 + LC_G)
    'HCI_REMOTE_NAME_REQUEST_CANCEL',                  --(0x001A + LC_G)
    'HCI_READ_REMOTE_FEATURES',                        --(0x001B + LC_G)
    'HCI_READ_REMOTE_EXTENDED_FEATURES',               --(0x001C + LC_G)
    'HCI_READ_REMOTE_VER_INFO',                        --(0x001D + LC_G)
    'UNKNOWN',                                         --
    'HCI_READ_CLOCK_OFFSET',                           --(0x001F + LC_G)
    'HCI_READ_LMP_HANDLE',                             --(0x0020 + LC_G)
    'HCI_EXCHANGE_FIXED_INFO',                         --(0x0021 + LC_G)
    'HCI_EXCHANGE_ALIAS_INFO',                         --(0x0022 + LC_G)
    'HCI_PRIVATE_PAIRING_REQUEST_REPLY',               --(0x0023 + LC_G)
    'HCI_PRIVATE_PAIRING_REQUEST_NEGATIVE_REPLY',      --(0x0024 + LC_G)
    'HCI_GENERATED_ALIAS',                             --(0x0025 + LC_G)
    'HCI_ALIAS_ADDRESS_REQUEST_REPLY',                 --(0x0026 + LC_G)
    'HCI_ALIAS_ADDRESS_REQUEST_NEGATIVE_REPLY',        --(0x0027 + LC_G)
    'HCI_SETUP_SYNCHRONOUS_CONNECTION',                --(0x0028 + LC_G)
    'HCI_ACCEPT_SYNCHRONOUS_CONNECTION_REQUEST',       --(0x0029 + LC_G)
    'HCI_REJECT_SYNCHRONOUS_CONNECTION_REQUEST',       --(0x002A + LC_G)
    'HCI_IO_CAPABILITY_REQUEST_REPLY',                 --(0x002B + LC_G)
    'HCI_USER_CONFIRMATION_REQUEST_REPLY',             --(0x002C + LC_G)
    'HCI_USER_CONFIRMATION_REQUEST_NEGATIVE_REPLY',    --(0x002D + LC_G)
    'HCI_USER_PASSKEY_REQUEST_REPLY',                  --(0x002E + LC_G)
    'HCI_USER_PASSKEY_REQUEST_NEGATIVE_REPLY',         --(0x002F + LC_G)
    'HCI_REMOTE_OOB_DATA_REQUEST_REPLY',               --(0x0030 + LC_G)
    'UNKNOWN',                                         --
    'UNKNOWN',                                         --
    'HCI_REMOTE_OOB_DATA_REQUEST_NEGATIVE_REPLY',      --(0x0033 + LC_G)
    'HCI_IO_CAPABILITY_REQUEST_NEGATIVE_REPLY',        --(0x0034 + LC_G)
    'HCI_CREATE_PHYSICAL_LINK',                        --(0x0035 + LC_G)
    'HCI_ACCEPT_PHYSICAL_LINK',                        --(0x0036 + LC_G)
    'HCI_DISCONNECT_PHYDICAL_LINK',                    --(0x0037 + LC_G)
    'HCI_CREATE_LOGICAL_LINK',                         --(0x0038 + LC_G)
    'HCI_ACCEPT_LOGICAL_LINK',                         --(0x0039 + LC_G)
    'HCI_DISCONNECT_LOGICAL_LINK',                     --(0x003A + LC_G)
    'HCI_LOGICAL_LINK_CANCEL',                         --(0x003B + LC_G)
    'HCI_FLOW_SPEC_MODIFY',                            --(0x003C + LC_G)
    'HCI_ENHANCED_SETUP_SYNCHRONOUS_CONNECTION',       --(0x003D + LC_G)
    'HCI_ENHANCED_ACCEPT_SYNCHRONOUS_CONNECTION_REQUEST',--(0x003E + LC_G)
    'HCI_TRUNCATED_PAGE',                              --(0x003F + LC_G)
    'HCI_TRUNCATED_PAGE_CANCEL',                       --(0x0040 + LC_G)
    'HCI_SET_CONNECTIONLESS_SLAVE_BROADCAST',          --(0x0041 + LC_G)
    'HCI_SET_CONNECTIONLESS_SLAVE_BROADCAST_RECEIVE',  --(0x0042 + LC_G)
    'HCI_START_SYNCHRONIZATION_TRAIN',                 --(0x0043 + LC_G)
    'HCI_RECEIVE_SYNCHRONIZATION_TRAIN',               --(0x0044 + LC_G)
    'HCI_REMOTE_OOB_EXTENDED_DATA_REQUEST_REPLY',      --(0x0045 + LC_G)
    'MAX_HC_LINK_CONTROL_OPCODE_UNTIL_CORE_V42',       --0x46
}


HCI_COMMAND_TYPE_LP_G=
{
[0]='HCI_HOLD_MODE',                                  --(0x0001 + LP_G)
    'UNKNOWN',                                        --
    'HCI_SNIFF_MODE',                                 --(0x0003 + LP_G)
    'HCI_EXIT_SNIFF_MODE',                            --(0x0004 + LP_G)
    'HCI_PARK_MODE',                                  --(0x0005 + LP_G)
    'HCI_EXIT_PARK_MODE',                             --(0x0006 + LP_G)
    'HCI_QOS_SETUP',                                  --(0x0007 + LP_G)
    'UNKNOWN',                                        --
    'HCI_ROLE_DISCOVERY',                             --(0x0009 + LP_G)
    'UNKNOWN',                                        --
    'HCI_SWITCH_ROLE',                                --(0x000B + LP_G)
    'HCI_READ_LINK_POLICY_SETTINGS',                  --(0x000C + LP_G)
    'HCI_WRITE_LINK_POLICY_SETTINGS',                 --(0x000D + LP_G)
    'HCI_READ_DEFAULT_LINK_POLICY_SETTINGS',          --(0x000E + LP_G)
    'HCI_WRITE_DEFAULT_LINK_POLICY_SETTINGS',         --(0x000F + LP_G)
    'HCI_FLOW_SPECIFICATION',                         --(0x0010 + LP_G)
    'HCI_SNIFF_SUBRATING',                            --(0x0011 + LP_G)
}


HCI_COMMAND_TYPE_HC_G=
{
[0]='HCI_SET_EVENT_MASK',                             -- (0x0001 + HC_G)
    'UNKNOWN',                                        --
    'HCI_RESET',                                      -- (0x0003 + HC_G)
    'UNKNOWN',                                        --
    'HCI_SET_EVENT_FILTER',                           -- (0x0005 + HC_G)
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'HCI_FLUSH',                                      -- (0x0008 + HC_G)
    'HCI_READ_PIN_TYPE',                              -- (0x0009 + HC_G)
    'HCI_WRITE_PIN_TYPE',                             -- (0x000A + HC_G)
    'HCI_CREATE_NEW_UNIT_KEY',                        -- (0x000B + HC_G)
    'UNKNOWN',                                        --
    'HCI_READ_STORED_LINK_KEY',                       -- (0x000D + HC_G)
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'HCI_WRITE_STORED_LINK_KEY',                      -- (0x0011 + HC_G)
    'HCI_DELETE_STORED_LINK_KEY',                     -- (0x0012 + HC_G)
    'HCI_CHANGE_LOCAL_NAME',                          -- (0x0013 + HC_G)
    'HCI_READ_LOCAL_NAME',                            -- (0x0014 + HC_G)
    'HCI_READ_CONNECT_ACCEPT_TO',                     -- (0x0015 + HC_G)
    'HCI_WRITE_CONNECT_ACCEPT_TO',                    -- (0x0016 + HC_G)
    'HCI_READ_PAGE_TIMEOUT',                          -- (0x0017 + HC_G)
    'HCI_WRITE_PAGE_TIMEOUT',                         -- (0x0018 + HC_G)
    'HCI_READ_SCAN_ENABLE',                           -- (0x0019 + HC_G)
    'HCI_WRITE_SCAN_ENABLE',                          -- (0x001A + HC_G)
    'HCI_READ_PAGE_SCAN_ACT',                         -- (0x001B + HC_G)
    'HCI_WRITE_PAGE_SCAN_ACT',                        -- (0x001C + HC_G)
    'HCI_READ_INQUIRY_SCAN_ACT',                      -- (0x001D + HC_G)
    'HCI_WRITE_INQUIRY_SCAN_ACT',                     -- (0x001E + HC_G)
    'HCI_READ_AUTHENTICATION_ENABLE',                 -- (0x001F + HC_G)
    'HCI_WRITE_AUTHENTICATION_ENABLE',                -- (0x0020 + HC_G)
    'HCI_READ_ENCRYPTION_MODE',                       -- (0x0021 + HC_G)
    'HCI_WRITE_ENCRYPTION_MODE',                      -- (0x0022 + HC_G)
    'HCI_READ_CLASS_OF_DEVICE',                       -- (0x0023 + HC_G)
    'HCI_WRITE_CLASS_OF_DEVICE',                      -- (0x0024 + HC_G)
    'HCI_READ_VOICE_SETTINGS',                        -- (0x0025 + HC_G)
    'HCI_WRITE_VOICE_SETTINGS',                       -- (0x0026 + HC_G)
    'HCI_READ_AUTOMATIC_FLUSH_TIMEOUT',               -- (0x0027 + HC_G)
    'HCI_WRITE_AUTOMATIC_FLUSH_TIMEOUT',              -- (0x0028 + HC_G)
    'HCI_READ_NUM_BROADCAST_RETRANSMISSIONS',         -- (0x0029 + HC_G)
    'HCI_WRITE_NUM_BROADCAST_RETRANSMISSIONS',        -- (0x002A + HC_G)
    'HCI_READ_HOLD_MODE_ACTIVITY',                    -- (0x002B + HC_G)
    'HCI_WRITE_HOLD_MODE_ACTIVITY',                   -- (0x002C + HC_G)
    'HCI_READ_TRANSMIT_POWER_LEVEL',                  -- (0x002D + HC_G)
    'HCI_READ_SYNCHRONOUS_FLOW_CONTROL_ENABLE',       -- (0x002E + HC_G)
    'HCI_WRITE_SYNCHRONOUS_FLOW_CONTROL_ENABLE',      -- (0x002F + HC_G)
    'UNKNOWN',                                        --
    'HCI_SET_HOST_CONTROLLER_TO_HOST_FLOW_CONTROL',   -- (0x0031 + HC_G)
    'UNKNOWN',                                        --
    'HCI_HOST_BUFFER_SIZE',                           -- (0x0033 + HC_G)
    'UNKNOWN',                                        --
    'HCI_HOST_NUMBER_OF_COMPLETED_PACKETS',           -- (0x0035 + HC_G)
    'HCI_READ_SUPERVISION_TIMEOUT',                   -- (0x0036 + HC_G)
    'HCI_WRITE_SUPERVISION_TIMEOUT',                  -- (0x0037 + HC_G)
    'HCI_READ_NUMBER_OF_SUPPORTED_IAC',               -- (0x0038 + HC_G)
    'HCI_READ_CURRENT_IAC_LAP',                       -- (0x0039 + HC_G)
    'HCI_WRITE_CURRENT_IAC_LAP',                      -- (0x003A + HC_G)
    'HCI_READ_PAGE_SCAN_PERIOD_MODE',                 -- (0x003B + HC_G)
    'HCI_WRITE_PAGE_SCAN_PERIOD_MODE',                -- (0x003C + HC_G)
    'HCI_READ_PAGE_SCAN_MODE',                        -- (0x003D + HC_G)
    'HCI_WRITE_PAGE_SCAN_MODE',                       -- (0x003E + HC_G)
    'HCI_SET_AFH_HOST_CHANNEL_CLASSIFICATION',        -- (0x003F + HC_G)
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'HCI_READ_INQUIRY_SCAN_TYPE',                     -- (0x0042 + HC_G)
    'HCI_WRITE_INQUIRY_SCAN_TYPE',                    -- (0x0043 + HC_G)
    'HCI_READ_INQUIRY_MODE',                          -- (0x0044 + HC_G)
    'HCI_WRITE_INQUIRY_MODE',                         -- (0x0045 + HC_G)
    'HCI_READ_PAGE_SCAN_TYPE',                        -- (0x0046 + HC_G)
    'HCI_WRITE_PAGE_SCAN_TYPE',                       -- (0x0047 + HC_G)
    'HCI_READ_AFH_CHANNEL_ASSESSMENT_MODE',           -- (0x0048 + HC_G)
    'HCI_WRITE_AFH_CHANNEL_ASSESSMENT_MODE',          -- (0x0049 + HC_G)
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'HCI_RESET_FIXED_ADDRESS_ATTEMPTS_COUNTER',       -- (0x0050 + HC_G)  deeve: ?
    'HCI_READ_EXTENDED_INQUIRY_RESPONSE_COMMAND',     -- (0x0051 + HC_G)
    'HCI_WRITE_EXTENDED_INQUIRY_RESPONSE_COMMAND',    -- (0x0052 + HC_G)
    'HCI_REFRESH_ENCRYPTION_KEY',                     -- (0x0053 + HC_G)
    'UNKNOWN',                                        --
    'HCI_READ_SIMPLE_PAIRING_MODE',                   -- (0x0055 + HC_G)
    'HCI_WRITE_SIMPLE_PAIRING_MODE',                  -- (0x0056 + HC_G)
    'HCI_READ_LOCAL_OOB_DATA',                        -- (0x0057 + HC_G)
    'HCI_READ_INQUIRY_RESPONSE_TRANSMIT_POWER_LEVEL', -- (0x0058 + HC_G)
    'HCI_WRITE_INQUIRY_TRANSMIT_POWER_LEVEL',         -- (0x0059 + HC_G)
    'HCI_READ_DEFAULT_ERRONEOUS_DATA_REPORTING',      -- (0x005A + HC_G)
    'HCI_WRITE_DEFAULT_ERRONEOUS_DATA_REPORTING',     -- (0x005B + HC_G)
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'HCI_ENHANCED_FLUSH',                             -- (0x005F + HC_G)
    'HCI_SEND_KEYPRESS_NOTIFICATION',                 -- (0x0060 + HC_G)
    'HCI_READ_LOGICAL_LINK_ACCEPT_TIMEOUT',           -- (0x0061 + HC_G)
    'HCI_WRITE_LOGICAL_LINK_ACCEPT_TIMEOUT',          -- (0x0062 + HC_G)
    'HCI_SET_EVENT_MASK_PAGE_2',                      -- (0x0063 + HC_G)
    'HCI_READ_LOCATION_DATA',                         -- (0x0064 + HC_G)
    'HCI_WRITE_LOCATION_DATA',                        -- (0x0065 + HC_G)
    'HCI_READ_FLOW_CONTROL_MODE',                     -- (0x0066 + HC_G)
    'HCI_WRITE_FLOW_CONTROL_MODE',                    -- (0x0067 + HC_G)
    'HCI_READ_ENHANCED_TRANSMIT_POWER_LEVEL',         -- (0X0068 + HC_G)
    'HCI_READ_BEST_EFFORT_FLUSH_TIMEOUT',             -- (0X0069 + HC_G)
    'HCI_WRITE_BEST_EFFORT_FLUSH_TIMEOUT',            -- (0X006A + HC_G)
    'HCI_SHORT_RANGE_MODE',                           -- (0X006B + HC_G)
    'HCI_READ_LE_HOST_SUPPORT',                       -- (0X006C + HC_G)
    'HCI_WRITE_LE_HOST_SUPPORT',                      -- (0X006D + HC_G)
    'HCI_SET_MWS_CHANNEL_PARAMETERS',                 -- (0X006E + HC_G)
    'HCI_SET_EXTERNAL_FRAME_CONFIGURATION',           -- (0X006F + HC_G)
    'HCI_SET_MWS_SIGNALING',                          -- (0X0070 + HC_G)
    'HCI_SET_MWS_TRANSPORT_LAYER',                    -- (0X0071 + HC_G)
    'HCI_SET_MWS_SCAN_FREQUENCY_TABLE',               -- (0X0072 + HC_G)
    'HCI_SET_MWS_PATTERN_CONFIGURATION',              -- (0X0073 + HC_G)
    'HCI_SET_RESERVED_LT_ADDR',                       -- (0X0074 + HC_G)
    'HCI_DELETE_RESERVED_LT_ADDR',                    -- (0X0075 + HC_G)
    'HCI_SET_CONNECTIONLESS_SLAVE_BROADCAST_DATA',    -- (0X0076 + HC_G)
    'HCI_READ_SYNCHRONIZATION_TRAIN_PARAMETERS',      -- (0X0077 + HC_G)
    'HCI_WRITE_SYNCHRONIZATION_TRAIN_PARAMETERS',     -- (0X0078 + HC_G)
    'HCI_READ_SECURE_CONNECTIONS_HOST_SUPPORT',       -- (0X0079 + HC_G)
    'HCI_WRITE_SECURE_CONNECTIONS_HOST_SUPPORT',      -- (0X007A + HC_G)
    'HCI_READ_AUTHENTICATED_PAYLOAD_TIMEOUT',         -- (0X007B + HC_G)
    'HCI_WRITE_AUTHENTICATED_PAYLOAD_TIMEOUT',        -- (0X007C + HC_G)
    'HCI_READ_LOCAL_OOB_EXTENDED_DATA',               -- (0X007D + HC_G)
    'HCI_READ_EXTENDED_PAGE_TIMEOUT',                 -- (0X007E + HC_G)
    'HCI_WRITE_EXTENDED_PAGE_TIMEOUT',                -- (0X007F + HC_G)
    'HCI_READ_EXTENDED_INQUIRY_LENGT',                -- (0X0080 + HC_G)
    'HCI_WRITE_EXTENDED_INQUIRY_LENGT',               -- (0X0081 + HC_G)
    'MAX_HC_BB_COMMAND_OPCODE_UNTIL_CORE_V42',        -- 0x82
}


HCI_COMMAND_TYPE_HI_G=
{
[0]='HCI_READ_LOCAL_VER_INFO',                        -- (0x0001 + HI_G)
    'HCI_READ_LOCAL_COMMANDS',                        -- (0x0002 + HI_G)
    'HCI_READ_LOCAL_FEATURES',                        -- (0x0003 + HI_G)
    'HCI_READ_LOCAL_EXTENDED_FEATURES',               -- (0x0004 + HI_G)
    'HCI_READ_BUFFER_SIZE',                           -- (0x0005 + HI_G)
    'UNKNOWN',                                        --
    'HCI_READ_COUNTRY_CODE',                          -- (0x0007 + HI_G)  deeve: ?
    'UNKNOWN',                                        --
    'HCI_READ_BD_ADDR',                               -- (0x0009 + HI_G)
    'HCI_READ_DATA_BLOCK_SIZE',                       -- (0x000A + HI_G)
    'HCI_READ_LOCAL_SUPPORTED_CODECS',                -- (0x000B + HI_G)
    'MAX_HC_INFO_COMMAND_OPCODE_UNTIL_CORE_V42',      -- 0x0C
}

HCI_COMMAND_TYPE_HS_G=
{
[0]='HCI_READ_FAILED_CONTACT_COUNTER',                -- (0x0001 + HS_G)
    'HCI_RESET_FAILED_CONTACT_COUNTER',               -- (0x0002 + HS_G)
    'HCI_GET_LINK_QUALITY',                           -- (0x0003 + HS_G)
    'UNKNOWN',                                        --
    'HCI_READ_RSSI',                                  -- (0x0005 + HS_G)
    'HCI_READ_AFH_CHANNEL_MAP',                       -- (0x0006 + HS_G)
    'HCI_READ_CLOCK',                                 -- (0x0007 + HS_G)
    'HCI_READ_ENCRYPTION_KEY_SIZE',                   -- (0x0008 + HS_G)
    'HCI_READ_LOCAL_AMP_INFO',                        -- (0x0009 + HS_G)
    'HCI_READ_LOCAL_AMP_ASSOC',                       -- (0x000A + HS_G)
    'HCI_WRITE_LOCAL_AMP_ASSOC',                      -- (0x000B + HS_G)
    'HCI_GET_MWS_TRANSPORT_LAYER_CONFIGURATION',      -- (0x000C + HS_G)
    'HCI_SET_TRIGGERED_CLOCK_CAPTURE',                -- (0x000D + HS_G)
    'MAX_HC_STATUS_COMMAND_OPCODE_UNTIL_COREv42',     -- 0x0E
}


HCI_COMMAND_TYPE_HT_G=
{
[0]='HCI_READ_LOOPBACK_MODE',                         -- (0x0001 + HT_G)
    'HCI_WRITE_LOOPBACK_MODE',                        -- (0x0002 + HT_G)
    'HCI_ENABLE_DEVICE_UNDER_TEST_MODE',              -- (0x0003 + HT_G)
    'HCI_WRITE_SIMPLE_PAIRING_DEBUG_MODE',            -- (0x0004 + HT_G)
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'HCI_ENABLE_AMP_RECEIVER_REPORTS',                -- (0x0007 + HT_G)
    'HCI_AMP_TEST_END',                               -- (0x0008 + HT_G)
    'HCI_AMP_TEST',                                   -- (0x0009 + HT_G)
    'HCI_WRITE_SECURE_CONNECTION_TEST_MODE',          -- (0x000A + HT_G)
    'MAX_HC_TEST_COMMAND_OPCODE_UNTIL_COREv42',       -- 0x0B
}


HCI_COMMAND_TYPE_TCI_G=
{
[0]='UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'TCI_ACTIVATE_REMOTE_DUT',                        -- 0x0002 + ST_G
    'TCI_TEST_CONTROL',                               -- 0x0003 + ST_G
    'TCI_INCREASE_REMOTE_POWER',                      -- 0x0004 + ST_G
    'TCI_WRITE_LOCAL_HOP_FREQUENCIES',                -- 0x0005 + ST_G
    'TCI_READ_LOCAL_HARDWARE_VERSION',                -- 0x0006 + ST_G
    'TCI_DECREASE_REMOTE_POWER',                      -- 0x0007 + ST_G
    'TCI_INCREASE_LOCAL_VOLUME',                      -- 0x0008 + ST_G
    'TCI_DECREASE_LOCAL_VOLUME',                      -- 0x0009 + ST_G
    'TCI_WRITE_LOCAL_NATIVE_CLOCK',                   -- 0x000A + ST_G
    'TCI_READ_LOCAL_NATIVE_CLOCK',                    -- 0x000B + ST_G
    'TCI_READ_LOCAL_HOST_CONTROLLER_RELATIVE_MIPS',   -- 0x000C + ST_G
    'TCI_TYPE_APPROVAL_TEST_CONTROL',                 -- 0x000D + ST_G
    'TCI_SET_LOCAL_FAILED_ATTEMPTS_COUNTER',          -- 0x000E + ST_G
    'TCI_CLEAR_LOCAL_FAILED_ATTEMPTS_COUNTER',        -- 0x000F + ST_G
    'TCI_READ_LOCAL_DEFAULT_PACKET_TYPE',             -- 0x0010 + ST_G
    'TCI_WRITE_LOCAL_DEFAULT_PACKET_TYPE',            -- 0x0011 + ST_G
    'TCI_WRITE_LOCAL_SYNCWORD',                       -- 0x0012 + ST_G
    'TCI_WRITE_LOCAL_HOPPING_MODE',                   -- 0x0013 + ST_G
    'TCI_READ_LOCAL_HOPPING_MODE',                    -- 0x0014 + ST_G
    'TCI_WRITE_LOCAL_WHITENING_ENABLE',               -- 0x0015 + ST_G
    'TCI_READ_LOCAL_WHITENING_ENABLE',                -- 0x0016 + ST_G
    'TCI_WRITE_LOCAL_RADIO_POWER',                    -- 0x0017 + ST_G
    'TCI_READ_LOCAL_RADIO_POWER',                     -- 0x0018 + ST_G
    'TCI_SET_LOCAL_NEXT_AVAILABLE_AM_ADDR',           -- 0x0019 + ST_G
    'TCI_SET_LOCAL_BD_ADDR',                          -- 0x001A + ST_G
    'TCI_WRITE_LOCAL_LINK_KEY_TYPE',                  -- 0x001B + ST_G
    'TCI_READ_LOCAL_LINK_KEY_TYPE',                   -- 0x001C + ST_G
    'TCI_READ_LOCAL_EXTENDED_FEATURES',               -- 0x001D + ST_G
    'TCI_WRITE_LOCAL_FEATURES',                       -- 0x001E + ST_G
    'TCI_WRITE_LOCAL_EXTENDED_FEATURES',              -- 0x001F + ST_G
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'TCI_READ_LOCAL_TIMING_INFORMATION',              -- 0x002A + ST_G
    'TCI_WRITE_LOCAL_TIMING_INFORMATION',             -- 0x002B + ST_G
    'TCI_READ_REMOTE_TIMING_INFORMATION',             -- 0x002C + ST_G
    'TCI_WRITE_LOCAL_HARDWARE_REGISTER',              -- 0x002D + ST_G
    'TCI_RESET_LOCAL_BASEBAND_MONITORS',              -- 0x002E + ST_G
    'TCI_UPDATE_MANUFACTURING_INFORMATION',           -- 0x002F + ST_G
    'TCI_WRITE_LOCAL_RADIO_REGISTER',                 -- 0x0030 + ST_G
    'TCI_READ_LOCAL_RADIO_REGISTER',                  -- 0x0031 + ST_G
    'TCI_CHANGE_RADIO_MODULATION',                    -- 0x0032 + ST_G
    'TCI_READ_RADIO_MODULATION',                      -- 0x0033 + ST_G
    'TCI_SET_HCIT_UART_BAUD_RATE',                    -- 0x0034 + ST_G
    'TCI_LOCAL_AREA_DOWNLOAD',                        -- 0x0035 + ST_G
    'TCI_WRITE_HOST_SPECIFIC_PARAMETERS',             -- 0x0036 + ST_G
    'TCI_READ_LOCAL_HARDWARE_AREA',                   -- 0x0037 + ST_G
    'TCI_SET_SYSTEM_HARDWARE_CONFIGURATION',          -- 0x0038 + ST_G
    'TCI_SEND_ENCRYPTION_KEY_SIZE_MASK_REQ',          -- 0x0039 + ST_G
    'TCI_RESET_LOCAL_PUMP_MONITORS',                  -- 0x003A + ST_G
    'TCI_READ_LOCAL_PUMP_MONITORS',                   -- 0x003B + ST_G
    'TCI_WRITE_LOCAL_ENCRYPTION_KEY_LENGTH',          -- 0x003C + ST_G
    'TCI_READ_LOCAL_ENCRYPTION_KEY_LENGTH',           -- 0x003D + ST_G
    'TCI_READ_LOCAL_HOP_FREQUENCIES',                 -- 0x003E + ST_G
    'TCI_READ_LOCAL_BASEBAND_MONITORS',               -- 0x003F + ST_G
    'TCI_SET_DISABLE_LOW_POWER_MODE',                 -- 0x0040 + ST_G
    'TCI_SET_ENABLE_LOW_POWER_MODE',                  -- 0x0041 + ST_G
    'TCI_READ_R2P_MIN_SEARCH_WINDOW',                 -- 0x0042 + ST_G
    'TCI_WRITE_R2P_MIN_SEARCH_WINDOW',                -- 0x0043 + ST_G
    'TCI_SET_DISABLE_SCO_VIA_HCI',                    -- 0x0044 + ST_G // Control via SCO_Repeater menu on HC_Data_tester
    'TCI_SET_ENABLE_SCO_VIA_HCI',                     -- 0x0045 + ST_G // Control via SCO_Repeater menu on HC_Data_tester
    'TCI_WRITE_ESCO_RETRANSMISSION_MODE',             -- 0x0046 + ST_G
    'TCI_READ_ESCO_RETRANSMISSION_MODE',              -- 0x0047 + ST_G
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'TCI_VCI_CLK_OVERRIDE',                           -- 0x004E + ST_G
    'TCI_SET_BROADCAST_SCAN_WINDOW',                  -- 0x004F + ST_G
    'TCI_WRITE_PARK_PARAMETERS',                      -- 0x0050 + ST_G
    'TCI_READ_UNUSED_STACK_SPACE',                    -- 0x0051 + ST_G
    'TCI_WRITE_LOCAL_RADIO_REGISTER32',               -- 0x0052 + ST_G
    'TCI_READ_LOCAL_RADIO_REGISTER32',                -- 0x0053 + ST_G
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'UNKNOWN',                                        --
    'TCI_WRITE_AFH_CONTROL',                          -- 0x0060 + ST_G
    'TCI_READ_RAW_RSSI',                              -- 0x0061 + ST_G
    'TCI_READ_BER',                                   -- 0x0062 + ST_G
    'TCI_READ_PER',                                   -- 0x0063 + ST_G
    'TCI_READ_RAW_RSSI_PER_BER',                      -- 0x0064 + ST_G
    'TCI_FORCE_SYSTEM_HALT',                          -- 0x0065 + ST_G
    'TCI_WRITE_SECURITY_TIMEOUTS',                    -- 0x0066 + ST_G
    'TCI_WRITE_FEATURES',                             -- 0x0067 + ST_G
    'UNKNOWN',                                        --
    'TCI_SET_EMERGENCY_POLL_INTERVAL',                --  0x0069 + ST_G
}


HCI_COMMAND_TYPE_LE=
{
[0]='UNKNOWN',                                        --
    'HCI_LE_SET_EVENT_MASK',                          --(0x0001 + LE_G)
    'HCI_LE_READ_BUFFER_SIZE',                        --(0x0002 + LE_G)
    'HCI_LE_READ_LOCAL_SUPPORTED_FEATURES',           --(0x0003 + LE_G)
    'UNKNOWN',                                        --(0x0004 + LE_G)
    'HCI_LE_SET_RANDOM_ADDRESS',                      --(0x0005 + LE_G)
    'HCI_LE_SET_ADVERTISING_PARAMETERS',              --(0x0006 + LE_G)
    'HCI_LE_READ_ADVERTISING_CHANNEL_TX_POWER',       --(0x0007 + LE_G)
    'HCI_LE_SET_ADVERTISING_DATA',                    --(0x0008 + LE_G)
    'HCI_LE_SET_SCAN_RESPONSE_DATA',                  --(0x0009 + LE_G)
    'HCI_LE_SET_ADVERTISE_ENABLE',                    --(0x000A + LE_G)
    'HCI_LE_SET_SCAN_PARAMETERS',                     --(0x000B + LE_G)
    'HCI_LE_SET_SCAN_ENABLE',                         --(0x000C + LE_G)
    'HCI_LE_CREATE_CONNECTION',                       --(0x000D + LE_G)
    'HCI_LE_CREATE_CONNECTION_CANCEL',                --(0x000E + LE_G)
    'HCI_LE_READ_WHITE_LIST_SIZE',                    --(0x000F + LE_G)
    'HCI_LE_CLEAR_WHITE_LIST',                        --(0x0010 + LE_G)
    'HCI_LE_ADD_DEVICE_TO_WHITE_LIST',                --(0x0011 + LE_G)
    'HCI_LE_REMOVE_DEVICE_FROM_WHITE_LIST',           --(0x0012 + LE_G)
    'HCI_LE_CONNECTION_UPDATE',                       --(0x0013 + LE_G)
    'HCI_LE_SET_HOST_CHANNEL_CLASSIFICATION',         --(0x0014 + LE_G)
    'HCI_LE_READ_CHANNEL_MAP',                        --(0x0015 + LE_G)
    'HCI_LE_READ_REMOTE_USED_FEATURES',               --(0x0016 + LE_G)
    'HCI_LE_ENCRYPT',                                 --(0x0017 + LE_G)
    'HCI_LE_RAND',                                    --(0x0018 + LE_G)
    'HCI_LE_START_ENCRYPTION',                        --(0x0019 + LE_G)
    'HCI_LE_LONG_TERM_KEY_REQUEST_REPLY',             --(0x001A + LE_G)
    'HCI_LE_LONG_TERM_KEY_REQUEST_NEGATIVE_REPLY',    --(0x001B + LE_G)
    'HCI_LE_READ_SUPPORTED_STATES',                   --(0x001C + LE_G)
    'HCI_LE_RECEIVER_TEST',                           --(0x001D + LE_G)
    'HCI_LE_TRANSMITTER_TEST',                        --(0x001E + LE_G)
    'HCI_LE_TEST_END',                                --(0x001F + LE_G)
    'HCI_LE_REMOTE_CONNECTION_PARAMETER_REQ_REPLY',   --(0x0020 + LE_G)
    'HCI_LE_REMOTE_CONNECTION_PARAMETER_REQ_NEGATIVE_REPLY',--(0x0021 + LE_G)
    'HCI_LE_SET_DATA_LENGTH',                         --(0x0022 + LE_G)
    'HCI_LE_READ_SUGGESTED_DEFAULT_DATA_LENGTH',      --(0x0023 + LE_G)
    'HCI_LE_WRITE_SUGGESTED_DEFAULT_DATA_LENGTH',     --(0x0024 + LE_G)
    'HCI_LE_READ_LOCAL_P-256_PUBLIC_KEY',             --(0x0025 + LE_G)
    'HCI_LE_GENERATE_DHKEY',                          --(0x0026 + LE_G)
    'HCI_LE_ADD_DEVICE_TO_RESOLVING_LIST',            --(0x0027 + LE_G)
    'HCI_LE_REMOVE_DEVICE_FROM_RESOLVING_LIST',       --(0x0028 + LE_G)
    'HCI_LE_CLEAR_RESOLVING_LIST',                    --(0x0029 + LE_G)
    'HCI_LE_READ_RESOLVING_LIST_SIZE',                --(0x002A + LE_G)
    'HCI_LE_READ_PEER_RESOLVABLE_ADDRESS',            --(0x002B + LE_G)
    'HCI_LE_READ_LOCAL_RESOLVABLE_ADDRESS',           --(0x002C + LE_G)
    'HCI_LE_SET_ADDRESS_RESOLUTION_ENABLE',           --(0x002D + LE_G)
    'HCI_LE_SET_RESOLVABLE_PRIVATE_ADDRESS_TIMEOUT',  --(0x002E + LE_G)
    'HCI_LE_READ_MAXIMUM_DATA_LENGTH',                --(0x002F + LE_G)
    'HCI_LE_READ_PHY',                                --(0x0030 + LE_G)
    'HCI_LE_SET_DEFAULT_PHY',                         --(0x0031 + LE_G)
    'HCI_LE_SET_PHY',                                 --(0x0032 + LE_G)
    'HCI_LE_ENHANCED_RECEIVER_TEST',                  --(0x0033 + LE_G)
    'HCI_LE_ENHANCED_TRANSMITTER_TEST',               --(0x0034 + LE_G)
    'HCI_LE_SET_ADVERTISING_SET_RANDOM_ADDRESS',      --(0x0035 + LE_G)
    'HCI_LE_SET_EXTENDED_ADVERTISING_PARAMETERS',     --(0x0036 + LE_G)
    'HCI_LE_SET_EXTENDED_ADVERTISING_DATA',           --(0x0037 + LE_G)
    'HCI_LE_SET_EXTENDED_SCAN_RESPONSE_DATA',         --(0x0038 + LE_G)
    'HCI_LE_SET_EXTENDED_ADVERTISING_ENABLE',         --(0x0039 + LE_G)
    'HCI_LE_READ_MAXIMUM_ADVERTISING_DATA_LENGTH',    --(0x003A + LE_G)
    'HCI_LE_READ_NUMBER_OF_SUPPORTED_ADVERTISING_SETS',--(0x003B + LE_G)
    'HCI_LE_REMOVE_ADVERTISING_SET',                  --(0x003C + LE_G)
    'HCI_LE_CLEAR_ADVERTISING_SETS',                  --(0x003D + LE_G)
    'HCI_LE_SET_PERIODIC_ADVERTISING_PARAMETERS',     --(0x003E + LE_G)
    'HCI_LE_SET_PERIODIC_ADVERTISING_DATA',           --(0x003F + LE_G)
    'HCI_LE_SET_PERIODIC_ADVERTISING_ENABLE',         --(0x0040 + LE_G)
    'HCI_LE_SET_EXTENDED_SCAN_PARAMETERS',            --(0x0041 + LE_G)
    'HCI_LE_SET_EXTENDED_SCAN_ENABLE',                --(0x0042 + LE_G)
    'HCI_LE_EXTENDED_CREATE_CONNECTION',              --(0x0043 + LE_G)
    'HCI_LE_PERIODIC_ADVERTISING_CREATE_SYNC',        --(0x0044 + LE_G)
    'HCI_LE_PERIODIC_ADVERTISING_CREATE_SYNC_CANCEL', --(0x0045 + LE_G)
    'HCI_LE_PERIODIC_ADVERTISING_TERMINATE',          --(0x0046 + LE_G)
    'HCI_LE_ADD_DEVICE_TO_PERIODIC_ADVERTISER_LIST',  --(0x0047 + LE_G)
    'HCI_LE_REMOVE_DEVICE_FROM_PERIODIC_ADVERTISER_LIST',   --(0x0048 + LE_G)
    'HCI_LE_CLEAR_PERIODIC_ADVERTISER_LIST',         --(0x0049 + LE_G)
    'HCI_LE_READ_PERIODIC_ADVERTISER_LIST_SIZE',     --(0x004A + LE_G)
    'HCI_LE_READ_TRANSMIT_POWER',                --(0x004B + LE_G)
    'HCI_LE_READ_RF_PATH_COMPENSATION',                --(0x004C + LE_G)
    'HCI_LE_WRITE_RF_PATH_COMPENSATION',                --(0x004D + LE_G)	
}


function func_desc_UPT_DD02_FIXED(address, data)
    if bit.rshift(bit.band(data,0xfC00),10) == 0x01  then
        return string.format('HC_CMD:%s ',HCI_COMMAND_TYPE_LC_G[bit.band(data,0x3ff)-1])
    elseif bit.rshift(bit.band(data,0xfC00),10) == 0x02  then
        return string.format('HC_CMD:%s ',HCI_COMMAND_TYPE_LP_G[bit.band(data,0x3ff)-1])
    elseif bit.rshift(bit.band(data,0xfC00),10) == 0x03  then
        return string.format('HC_CMD:%s ',HCI_COMMAND_TYPE_HC_G[bit.band(data,0x3ff)-1])
    elseif bit.rshift(bit.band(data,0xfC00),10) == 0x04  then
        return string.format('HC_CMD:%s ',HCI_COMMAND_TYPE_HI_G[bit.band(data,0x3ff)-1])
    elseif bit.rshift(bit.band(data,0xfC00),10) == 0x05  then
        return string.format('HC_CMD:%s ',HCI_COMMAND_TYPE_HS_G[bit.band(data,0x3ff)-1])
    elseif bit.rshift(bit.band(data,0xfC00),10) == 0x06  then
        return string.format('HC_CMD:%s ',HCI_COMMAND_TYPE_HT_G[bit.band(data,0x3ff)-1])
    elseif bit.rshift(bit.band(data,0xfC00),10) == 0x3f  then
        return string.format('HCI_TCI:%s ',HCI_COMMAND_TYPE_TCI_G[bit.band(data,0x3ff)])
    elseif bit.rshift(bit.band(data,0xfC00),10) == 0x08  then
        return string.format('HC_BLE:%s ',HCI_COMMAND_TYPE_LE[bit.band(data,0x3ff)])
    else
        return string.format('HC_CMD=0x%X ',data)
    end
end
-- end for one description


-- used in func_desc_UPT_DD03_FIXED
-- NOTE:  by default, lua table start with index=1
HCI_EVENT_TYPE=
{
    'HCI_INQUIRY_COMPLETE_EVENT',
    'HCI_INQUIRY_RESULT_EVENT',
    'HCI_CONNECTION_COMPLETE_EVENT',
    'HCI_CONNECTION_REQUEST_EVENT',
    'HCI_DISCONNECTION_COMPLETE_EVENT',
    'HCI_AUTHENTICATION_COMPLETE_EVENT',
    'HCI_READ_REMOTE_NAME_REQUEST_COMPLETE_EVENT',
    'HCI_ENCRYPTION_CHANGE_EVENT',
    'HCI_CHANGE_CONNECTION_LINK_KEY_COMPLETE_EVENT',
    'HCI_MASTER_LINK_KEY_COMPLETE_EVENT',
    'HCI_READ_REMOTE_SUPPORTED_FEATURES_COMPLETE_EVENT',
    'HCI_READ_REMOTE_VERSION_INFORMATION_COMPLETE_EVENT',
    'HCI_QoS_SETUP_COMPLETE_EVENT',
    'HCI_COMMAND_COMPLETE_EVENT',
    'HCI_COMMAND_STATUS_EVENT',
    'HCI_HARDWARE_ERROR_EVENT',
    'HCI_FLUSH_OCCURED_EVENT',
    'HCI_ROLE_CHANGE_EVENT',
    'HCI_NUMBER_OF_COMPLETED_PACKETS_EVENT',
    'HCI_MODE_CHANGE_EVENT',
    'HCI_RETURN_LINK_KEYS_EVENT',
    'HCI_PIN_CODE_REQUEST_EVENT',
    'HCI_LINK_KEY_REQUEST_EVENT',
    'HCI_LINK_KEY_NOTIFICATION_EVENT',
    'HCI_LOOPBACK_COMMAND_EVENT',
    'HCI_DATA_BUFFER_OVERFLOW_EVENT',
    'HCI_MAX_SLOTS_CHANGE_EVENT',
    'HCI_READ_CLOCK_OFFSET_EVENT',
    'HCI_CONNECTION_PACKET_TYPE_CHANGED_EVENT',
    'HCI_QOS_VIOLATION_EVENT',
    'HCI_PAGE_SCAN_MODE_CHANGE_EVENT',
    'HCI_PAGE_SCAN_REPETITION_MODE_CHANGE_EVENT',
    'HCI_FLOW_SPECIFICATION_COMPLETE_EVENT',
    'HCI_INQUIRY_RESULT_EVENT_WITH_RSSI',
    'HCI_READ_REMOTE_EXTENDED_FEATURES_COMPLETE_EVENT',
    'HCI_FIXED_ADDRESS_EVENT',
    'HCI_ALIAS_ADDRESS_EVENT',
    '0X26',
    'HCI_ACTIVE_ADDRESS_EVENT',
    '0X28',
    '0X29',
    '0X2A',
    '0X2B',
    'HCI_SYNCHRONOUS_CONNECTION_COMPLETE_EVENT',
    'HCI_SYNCHRONOUS_CONNECTION_CHANGED_EVENT',
    'HCI_SNIFF_SUBRATING_EVENT',
    'HCI_EXTENDED_INQUIRY_RESULT_EVENT',
    'HCI_ENCRYPTION_KEY_REFRESH_COMPLETE_EVENT',
    'HCI_IO_CAPABILITY_REQUEST_EVENT',
    'HCI_IO_CAPABILITY_RESPONSE_EVENT',
    'HCI_USER_CONFIRMATION_REQUEST_EVENT',
    'HCI_USER_PASSKEY_REQUEST_EVENT',
    'HCI_REMOTE_OOB_DATA_REQUEST_EVENT',
    'HCI_SIMPLE_PAIRING_COMPLETE_EVENT',
    '0X37',
    'HCI_LINK_SUPERVISION_TIMEOUT_CHANGED_EVENT',
    'HCI_ENHANCED_FLUSH_COMPLETE_EVENT',
    '0X3A',
    'HCI_USER_PASSKEY_NOTIFICATION_EVENT',
    'HCI_KEYPRESS_NOTIFICATION_EVENT',
    'HCI_REMOTE_HOST_SUPPORTED_FEATURES_NOTIFICATION_EVENT',
---- 'HCI_ALIAS_NOT_RECOGNIZED_EVENT',                         -- 0x3e  LE event
    'HCI_BLE_EVENT',                                          -- 0x3e  LE event
    'HCI_FIXED_ADDRESS_ATTEMPT_EVENT',
    'HCI_PHYSICAL_LINK_COMPLETE_EVENT',                       -- 0x40
    'HCI_CHANNEL_SELECTED_EVENT',                             -- 0x41
    'HCI_DISCONNECTION_PHYSICAL_LINK_COMPLETE_EVENT',         -- 0x42
    'HCI_PHYSICAL_LINK_LOSS_EARLY_WARNING_EVENT',             -- 0x43
    'HCI_PHYSICAL_LINK_RECOVERY_EVENT',                       -- 0x44
    'HCI_LOGICAL_LINK_COMPLETE_EVENT',                        -- 0x45
    'HCI_DISCONNECTION_LOGICAL_LINK_COMPLETE_EVENT',          -- 0x46
    'HCI_FLOW_SPEC_MODIFY_COMPLETE_EVENT',                    -- 0x47
    'HCI_NUMBER_OF_COMPLETE_DATA_BLOCKS',                     -- 0x48
    'HCI_AMP_START_TEST_EVENT',                               -- 0x49
    'HCI_AMP_TEST_END_EVENT',                                 -- 0x4A
    'HCI_AMP_RECEIVER_REPORT_EVENT',                          -- 0x4B
    'HCI_SHORT_RANGE_MODE_CHANGE_COMPLETE_EVENT',             -- 0x4C
    'HCI_AMP_STATUS_CHANGE_EVENT',                            -- 0x4D
    'HCI_TRIGGERED_CLOCK_CAPTURE_EVENT',                      -- 0x4E
    'HCI_SYNCHRONIZATION_TRAIN_COMPLETE_EVENT',               -- 0x4F
    'HCI_SYNCHRONIZATION_TRAIN_RECEIVED_EVENT',               -- 0x50
    'HCI_CONNECTIONLESS_SLAVE_BROADCAST_RECEIVE_EVENT',       -- 0x51
    'HCI_CONNECTIONLESS_SLAVE_BROADCAST_TIMEOUT_EVENT',       -- 0x52
    'HCI_TRUNCATED_PAGE_COMPLETE_EVENT',                      -- 0x53
    'HCI_SLAVE_PAGE_RESPONSE_TIMEOUT',                        -- 0x54
    'HCI_CONNECTIONLESS_SLAVE_BROADCAST_CHN_MAP_CHANGE_EVENT',-- 0x55
    'HCI_INQUIRY_RESPONSE_NOTIFICATION_EVENT',                -- 0x56
    'HCI_AUTHENTICATED_PAYLOAD_TIMEOUT_EXPIRED_EVENT',        -- 0x57
}


function func_desc_UPT_DD03_FIXED(address, data)
    if HCI_EVENT_TYPE[data] then
        return string.format('HC_Event:%s',HCI_EVENT_TYPE[data])
    else
        return string.format('HC_Event: event_code=0x%X',data)
    end
end

-- end for one description

-- used in func_desc_UPT_DD04_FIXED
-- NOTE:  by default, lua table start with index=1
ERROR_CODES_TYPE=
{
[0]='NO_ERROR',
    'ILLEGAL_COMMAND',
    'NO_CONNECTION',
    'HARDWARE_FAILURE',
    'PAGE_TIMEOUT',
    'AUTHENTICATION_FAILURE',
    'PIN_MISSING',
    'MEMORY_FULL',
    'CONNECTION_TIMEOUT',
    'MAX_NUM_CONNECTIONS',
    'MAX_NUM_SCO',
    'ACL_ALREADY_EXISTS',
    'COMMAND_DISALLOWED',
    'HOST_REJECT_LIMITED_RESOURCES',
    'HOST_REJECT_SECURITY',
    'HOST_REJECT_PERSONAL_DEVICE',
    'CONNECTION_ACCEPT_TIMEOUT',
    'UNSUPPORTED_FEATURE',
    'INVALID_HCI_PARAMETERS',
    'REMOTE_USER_TERMINATED_CONNECTION',
    'REMOTE_RESOURCES_TERMINATED_CONNECTION',
    'REMOTE_POWER_TERMINATED_CONNECTION',
    'LOCAL_TERMINATED_CONNECTION',
    'REPEATED_ATTEMPTS',
    'PAIRING_NOT_ALLOWED',
    'UNKNOWN_LMP_PDU',
    'UNSUPPORTED_REMOTE_FEATURE',
    'SCO_OFFSET_REJECTED',
    'SCO_INTERVAL_REJECTED',
    'SCO_AIR_MODE_REJECTED',
    'INVALID_LMP_PARAMETERS',
    'UNSPECIFIED_ERROR',
    'UNSUPPORTED_PARAMETER_VALUE',
    'ROLE_CHANGE_NOT_ALLOWED',
    'LMP_RESPONSE_TIMEOUT',
    'LMP_ERROR_TRANSACTION_COLLISION',
    'LMP_PDU_NOT_ALLOWED',
    'ENCRYPTION_MODE_NOT_ACCEPTABLE',
    'UNIT_KEY_USED',
    'QOS_NOT_SUPPORTED',
    'INSTANT_PASSED',
    'PAIRING_WITH_UNIT_KEY_NOT_SUPPORTED',
    'EC_DIFFERENT_TRANSACTION_COLLISION',
    'EC_INSUFFICIENT_RESOURCES_FOR_SCATTER_MODE_REQUEST',
    'EC_QOS_UNACCEPTABLE_PARAMETER',
    'EC_QOS_REJECTED',
    'EC_CHANNEL_CLASSIFICATION_NOT_SUPPORTED',
    'EC_INSUFFICIENT_SECURITY',
    'EC_PARAMETER_OUT_OF_MANDATORY_RANGE',
    'EC_SCATTER_MODE_NO_LONGER_REQUIRED',
    'EC_ROLE_SWITCH_PENDING',
    'EC_SCATTER_MODE_PARAMETER_CHANGE_PENDING',
    'EC_RESERVED_SLOT_VIOLATION',
    'EC_ROLE_SWITCH_FAILED',
    'EC_EXTENDED_INQUIRY_RESPONSE_TOO_LARGE',
    'EC_SSP_NOT_SUPPORTED_BY_HOST',
    'EC_HOST_BUSY_PAIRING',
    'PRTH_TEST_PASSED_DEVIATED',
    'PRTH_TEST_FAILED',
    'PRTH_TEST_IS_INCOMPLETE',
    'PRTH_TEST_DUPLICATE',
    'PRTH_TEST_REQUIRES_HARDWARE',
    'PRTH_TEST_IS_OBSOLETE',
    'PRTH_TEST_IS_AMBIGUOUS',
    'PRTH_TEST_NOT_SUPPORTED',
    'PRTH_TEST_NOT_DEFINED',
    'PRTH_TEST_LMP_FEATURE_IS_SUPPORTED',
    'PRTH_TEST_LMP_FEATURE_IS_NOT_SUPPORTED',
    'PRTH_TEST_SYS_FEATURE_IS_SUPPORTED',
    'PRTH_TEST_SYS_FEATURE_IS_NOT_SUPPORTED',
    'PRTH_TEST_SKIPPED',
    'PRTH_TEST_IP_DEVELOPMENT_FAILURE',
}

function func_desc_UPT_DD04_FIXED(address, data)
	if ERROR_CODES_TYPE[data] then
		return string.format('HC_Event: status error=%s',ERROR_CODES_TYPE[data])
	else
		return string.format('HC_Event: status=0x%X',data)
	end
end

-- end for one description


-- used in func_desc_UPT_DD05_FIXED
-- NOTE:  by default, lua table start with index=1

HARDWARE_ERROR_CODE=
{
[0]='PRH_BS_HW_ERROR_NONE',	                    -- 0x00
    'PRH_BS_HW_ERROR_HCIT_UART_OVERRUN',	    -- 0x01
    'PRH_BS_HW_ERROR_HCIT_RX_PDU_MALFORMED',	-- 0x02
    'PRH_BS_HW_ERROR_INVALID_DEVICE_LINK',	    -- 0x03
    'PRH_BS_HW_ERROR_MSS_FAILURE',	            -- 0x04
    'PRH_BS_HW_ERROR_DEBUG_CLKN_READ',	        -- 0x05
    'PRH_BS_HW_ERROR_STACK_CORRUPTION',	        -- 0x06
    'PRH_BS_HW_ERROR_HCIT_UART_FRAMING',	    -- 0x07
    'PRH_BS_HW_ERROR_INVALID_LMP_LINK',	        -- 0x08
    'PRH_BS_HW_ERROR_INVALID_PICONET_INDEX',	 -- 0x09
    'PRH_BS_HW_ERROR_INCORRECT_RADIO_VERSION',	 -- 0x0A
    'PRH_BS_HW_ERROR_SCHEDULER_CONFIGURATION',	 -- 0x10
    'PRH_BS_HW_ERROR_INCORRECT_TABASCO_VERSION', -- 0x11
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x12
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x13
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x14
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x15
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x16	
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x17
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x18
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x19
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x1A
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x1B	
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x1C	
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x1D	
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x1E
    'PRH_BS_HW_ERROR_NOT_DEFINE',                -- 0x1F	
    'PRH_BS_HW_ERROR_INCORRECT_CTRLSTATE',   	 -- 0x20
    'PRH_BS_HW_ERROR_OUT_OF_LMP_TIMERS',	     -- 0x21
    'PRH_BS_HW_ERROR_INCORRECT_SUPER_STATE',	 -- 0x22
    'PRH_BS_HW_ERROR_CORRUPTION_OF_LMP_TIMERS',	 -- 0x23
    'PRH_BS_HW_ERROR_CORRUPTION_OF_QUEUES',	     -- 0x24
    'PRH_BS_HW_ERROR_OUT_OF_LMP_QUEUE_BUFFERS',	 -- 0x25
    'PRH_BS_HW_ERROR_LMP_QUEUE_CORRUPTED',	     -- 0x26
    'PRH_BS_HW_ERROR_OUT_OF_LE_LLC_QUEUE_BUFFERS', -- 0x27
    'PRH_BS_HW_ERROR_LE_LLC_QUEUE_CORRUPTED',	 -- 0x28
}



function func_desc_UPT_DD05_FIXED(address, data)
	if HARDWARE_ERROR_CODE[data] then
		return string.format('HC_Event: hardware_code=%s',HARDWARE_ERROR_CODE[data])
	else
		return string.format('HC_Event: hardware_code=0x%X',data)
	end
end

-- end for one description


-- used in func_desc_UPT_DD06_FIXED
-- NOTE:  by default, lua table start with index=1

BLE_EVT_SUB=
{
    'LE_SUBEVENT_CONNECTION_COMPLETE',                   -- 0x01
    'LE_SUBEVENT_ADVERTISING_REPORT',	                 -- 0x02
    'LE_SUBEVENT_CONNECTION_UPDATE_COMPLETE',            -- 0x03
    'LE_SUBEVENT_READ_REMOTE_USED_FEATURES_COMPLETE',	 -- 0x04
    'LE_SUBEVENT_LONG_TERM_KEY_REQUEST', 	             -- 0x05
    'LE_SUBEVENT_REMOTE_CONNECTION_PARAMETER_REQUEST',   -- 0x06
	'LE_SUBEVENT_DATA_LENGTH_CHANGE',  					 -- 0x07
	'LE_SUBEVENT_READ_LOCAL_P256_PUBLIC_KEY_COMPLETE',	 -- 0x08
	'LE_SUBEVENT_GENERATE_DHKEY_COMPLET',	             -- 0x09
	'LE_SUBEVENT_ENHANCED_CONNECTION_COMPLET',	         -- 0x0A
	'LE_SUBEVENT_DIRECTED_ADVERTISING_REPORT',	         -- 0x0B
	'LE_SUBEVENT_PHY_UPDATE_COMPLETE',	                 -- 0x0C
	'LE_SUBEVENT_EXTENDED_ADVERTISING_REPORT',	         -- 0x0D
	'LE_SUBEVENT_PERIODIC_ADVERTISING_SYNC_ESTABLISHED', -- 0x0E
	'LE_SUBEVENT_PERIODIC_ADVERTISING_REPORT',	         -- 0x0F
	'LE_SUBEVENT_PERIODIC_ADVERTISING_SYNC_LOST',	     -- 0x10
	'LE_SUBEVENT_SCAN_TIMEOUT',	                         -- 0x11
	'LE_SUBEVENT_ADVERTISING_SET_TERMINATED',	         -- 0x12
	'LE_SUBEVENT_SCAN_REQUEST_RECEIVED',	             -- 0x13
	'LE_SUBEVENT_CHANNEL_SELECTION_ALGORITHM',	         -- 0x14		
}

function func_desc_UPT_DD06_FIXED(address, data)
	if BLE_EVT_SUB[data-1] then
		return string.format('LE_Subevent_code==%s',BLE_EVT_SUB[data-1])
	else
		return string.format('LE_Subevent_code=0x%X',data)
	end
end

-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_ulc_procedure=
{
[0]='PAGE_PROCEDURE',                --
    'PAGESCAN_PROCEDURE',            --
    'INQUIRY_PROCEDURE',             --
    'INQUIRYSCAN_PROCEDURE',         --
    'MSS_PROCEDURE',                 -- /* Master-Slave Switch */
    'MSS_PROCEDURE_SLAVE_CONTEXT',   -- /* Master-Slave Switch */
    'MSS_PROCEDURE_MASTER_CONTEXT',  -- /* Master-Slave Switch */
    'SP_PROCEDURE',                  -- /* Interpiconet Switch */
    'SP_PROCEDURE_SLAVE_CONTEXT',    -- /* Interpiconet Switch */
    'SP_PROCEDURE_MASTER_CONTEXT',   -- /* Interpiconet Switch */
    'SLEEP_PROCEDURE',               --   /* Low Power Mode */
    'R2P_PROCEDURE',                 -- /* Return From Hold */
    'PARKSLAVE_PARK_PROCEDURE',      --
    'PARKMASTER_PARK_PROCEDURE',     --
    'LC_MAX_NUM_PROCEDURES',         --
    'NO_PROCEDURE',                  --
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_ulc_procedure[data] then
        return string.format('procedure:%s',t_ulc_procedure[data])
    else
        return string.format('procedure=0x%X',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
DEVICE_STATE=
{
[0]='No_State',                         -- = 0x00000,     /* Initial State */
    'Standby',                          -- = 0x00001,     /* Standby State */
    'Connection',                       -- = 0x00002,     /* Connection State */
    'Page',                             -- = 0x00004,     /* Page State */
    'MasterPageResponse',               -- = 0x00008,     /* Master Page Response State */
    'Page_Scan',                        -- = 0x00010,     /* Page Scan State */
    'SlavePageResponse',                -- = 0x00020,     /* Slave Page Response State */
    'Inquiry',                          -- = 0x00040,     /* Inquiry State */
    'InquiryResponse',                  -- = 0x00080,     /* Inquiry Response State */
    'Inquiry_Scan',                     -- = 0x00100,     /* Inquiry Scan State */
    'Master_Slave_Switch',              -- = 0x00200,     /* Master Slave Switch State */
    'Switch_Piconet',                   -- = 0x00400,     /* InterPiconet Switch */
    'Low_Power_Mode',                   -- = 0x00800,     /* Master Slave Switch State */
    'Return_To_Piconet',                -- = 0x01000,     /* Return to Piconet State */
    'Connection_2ndHalf_Slot_Tx',       -- = 0x02000,
    'Connection_Park_Access_Window_Rx', -- = 0x04000,
    'MasterExtendedInquiryResponse',    -- = 0x08000
}
-- mawei: repeat point, remove
--function func_desc_UPT_Dxxx_FIXED(address, data)
--  local RxBurstNo = 0
--  if data == 0 then
--    RxBurstNo=0
--  elseif data ==1 then
--    RxBurstNo = 1
--  elseif bit.rshift(data,0x0001)==1 then
--    RxBurstNo = 2
--  elseif  bit.rshift(data,0x0002)==1 then
--     RxBurstNo =3
--  elseif  bit.rshift(data,0x0003)==1 then
--     RxBurstNo =4
--  elseif  bit.rshift(data,0x0004)==1 then
--     RxBurstNo =5
--  elseif  bit.rshift(data,0x005)==1 then
--     RxBurstNo =6
--  elseif  bit.rshift(data,0x0006)==1 then
--     RxBurstNo =7
--  elseif  bit.rshift(data,0x0007)==1 then
--     RxBurstNo =8
--  elseif  bit.rshift(data,0x0008)==1 then
--     RxBurstNo =9
--  elseif  bit.rshift(data,9)==1 then
--     RxBurstNo =10
--  elseif  bit.rshift(data,10)==1 then
--     RxBurstNo =11
--  elseif  bit.rshift(data,11)==1 then
--     RxBurstNo =12
--  elseif  bit.rshift(data,12)==1 then
--     RxBurstNo =13
--  elseif  bit.rshift(data,13)==1 then
--     RxBurstNo =14
--  elseif  bit.rshift(data,14)==1 then
--     RxBurstNo =15
--  elseif  bit.rshift(data,15)==1 then
--     RxBurstNo =16
--  else
--    RxBurstNo =0
--  end
--  return string.format('DEVICE_STATE:%s @XXX(f)',DEVICE_STATE[RxBurstNo])
--end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
inquiry_ctrl_state=
{
[0]='OS_START',                    -- /* start control-state */
    'OS_END',                      -- /* end control-state */
    'OS_NOT_ACTIVE',               -- /* procedure currently not active */
    'OS_INQUIRY_TX_RX',            -- /* inquiry tx/rx control-state */
    'OS_EXTENDED_INQUIRY_RESPONSE', -- /* extended inquiry response */
    'OS_SUSPEND',
    'OS_RESUME',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if inquiry_ctrl_state[data] then
        return string.format('inquiry state:%s @USLCinq_Inquiry(f)',inquiry_ctrl_state[data])
    else
        return string.format('inquiry state=0x%X @USLCinq_Inquiry(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
inqScan_ctrl_state=
{
[0]='OS_START',               --/* start control-state */
    'OS_END',                 --/* end control-state */
    'OS_NOT_ACTIVE',          --/* procedure currently not active*/
    'OS_INQUIRY_SCAN',        --/* inquiry-scan control-state */
    'OS_INQUIRY_RAND_WAIT',   --/* inquiry random wait control-state */
    'OS_INQUIRY_RESPONSE',    --/* inquiry scan continue control-state */
    'OS_INQUIRY_SCAN_RESUME', -- /* Resume Inquiry Scanning after transmitting */      /* FHS packet       */
    'OS_INQUIRY_W4_RESPONSE_COMPLETE',-- /* Need to burn a frame to ensure the  * FHS/EIR packets are sent */
    'OS_INQUIRY_SCAN_2ND_TRAIN',
    'OS_INQUIRY_GENERATE_EIR_PACKET',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if inqScan_ctrl_state[data] then
        return string.format('inquiryscan state:%s @USLCinqScan_Inquiry_Scan(f)',inqScan_ctrl_state[data])
    else
        return string.format('inquiryscan state=0x%X @USLCinqScan_Inquiry_Scan(f)',data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
_USLCmss_Ctrl_State=
{
[0]='OS_INACTIVE',                                --
    'OS_START',                                   --
    'OS_SLAVE_A_TDD_SWITCH_TX',                   --
    'OS_SLAVE_A_TDD_SWITCH_RX',                   --
    'OS_MASTER_A_PICONET_SWITCH_TX',              --
    'OS_MASTER_A_PICONET_SWITCH_RX',              --
    'OS_SLAVE_A_MSS_FAILURE_RECOVER_TDD',         --
    'OS_SLAVE_A_MSS_FAILURE_RECOVER_SLOT_OFFSET', --
    'OS_SLAVE_A_MSS_FAILURE_RECOVER_CLK',         --
    'OS_MASTER_A_CONNECTED_TO_SLAVE',             --
    'OS_MASTER_B_TDD_SWITCH_RX',                  --
    'OS_SLAVE_B_PICONET_SWITCH_INTRASLOT_ADJUST', --
    'OS_SLAVE_B_PICONET_SWITCH_RX',               --
    'OS_MASTER_B_END',                            --
    'OS_SLAVE_B_CONNECTED_TO_MASTER',             --
    'OS_RECOVER_ORIGINAL_PICONET',                --
    'OS_SENTINEL',                                --
} ;

function func_desc_UPT_Dxxx_FIXED(address, data)
    if _USLCmss_Ctrl_State[data] then
        return string.format('MSS state:%s @USLCmss_State_Dispatcher(f)',_USLCmss_Ctrl_State[data])
    else
        return string.format('MSS state=0x%X @USLCmss_State_Dispatcher(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
USLCpage_ctrl_state=
{
[0]='OS_START',               --/* start control-state */
    'OS_END',                 --/* end control-state */
    'OS_NOT_ACTIVE',          --/* procedure currently not active*/
    'OS_PAGING_TX',           --/* paging transmission control-state */
    'OS_PAGING_RX',           --/* paging reception control-state */
    'OS_MASTER_PAGE_RESP_TX', --/* master page response transmit control-state */
    'OS_MASTER_PAGE_RESP_RX', --/* master page response reception control-state */
    'OS_MASTER_PAGE_RESP_LOOK_AHEAD_RX',--,
    'OS_POLL_RESP_TX',        --/* poll response transmission control-state */
    'OS_POLL_RESP_RX',        --/* poll response reception control-state */
    'OS_POLL_RESP_LOOK_AHEAD_RX',--,
    'OS_CONNECTED_TO_SLAVE',     --   /* connected-to-slave control-state */
    'OS_PAGING_LOOK_AHEAD_RX',   --
    'OS_SUSPEND',
    'OS_RESUME',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if USLCpage_ctrl_state[data] then
        return string.format('page state:%s @USLCpage_Page(f)',USLCpage_ctrl_state[data])
    else
        return string.format('page state=0x%X @USLCpage_Page(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
pageScan_ctrl_state=
{
[0]='OS_START',               --/* start control-state */
    'OS_END',                 --/* end control-state */
    'OS_NOT_ACTIVE',          --/* procedure not active */
    'OS_RESUME_PAGE_SCANNING',--/* resume scanning (after advancing past OS_PAGE_SCAN state */
    'OS_PAGE_SCAN',           --/* page scan control-state */
    'OS_SLAVE_PAGE_RESP',     --/* slave page response control-state */
    'OS_POLL_RESP_RX',        --/* Slave waiting for POLL pkt from Master */
    'OS_CONNECTED_TO_MASTER', -- /* connected to master control-state */
    'OS_END_AT_NEXT_TX_START',--
    'OS_PAGESCAN_2ND_TRAIN',  --
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if pageScan_ctrl_state[data] then
        return string.format('pageScan state:%s @USLCpageScan_Page_Scan(f)',pageScan_ctrl_state[data])
    else
        return string.format('pageScan state=0x%X @USLCpageScan_Page_Scan(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
_USLCparkMaster_ctrl_state=
{
[0]='OS_PARK_START_MASTER',
    'OS_UNPARK_START_MASTER',
    'OS_PARK_MASTER_ACCESS_WINDOW_START',
    'OS_PARK_END_MASTER',
    'OS_UNPARK_TX_MASTER',
    'OS_UNPARK_RX_MASTER',
    'OS_W4_UNPARK_INSTRUCTION_MASTER',
    'OS_END_UNPARK_SUCCESSFUL_MASTER',
    'OS_END_UNPARK_UNSUCCESSFUL_MASTER',
    'OS_PARK_MASTER_ACCESS_WINDOW_TX',
    'OS_PARK_MASTER_ACCESS_WINDOW_RX',
    'OS_PARK_MASTER_END_ACCESS_WINDOW',
    'OS_PARK_LOOK_AHEAD_MASTER_ACCESS_WINDOW_RX',
    'OS_NOT_ACTIVE_PARK_MASTER',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if _USLCparkMaster_ctrl_state[data] then
        return string.format('parkMaster_info->ctrl_state:%s @USLCparkMaster_Park(f)',_USLCparkMaster_ctrl_state[data])
    else
        return string.format('parkMaster_info->ctrl_state=0x%X @USLCparkMaster_Park(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_USLCparkSlave_ctrl_state=
{
[0]='OS_PARK_START_SLAVE',
    'OS_UNPARK_START_SLAVE',
    'OS_PARK_SLAVE_ACCESS_WINDOW_START',
    'OS_UNPARK_RX_SLAVE',
    'OS_W4_UNPARK_INSTRUCTION_SLAVE',
    'OS_END_UNPARK_SUCCESSFUL_SLAVE',
    'OS_END_UNPARK_UNSUCCESSFUL_SLAVE',
    'OS_PARK_SLAVE_ACCESS_WINDOW_RX',
    'OS_PARK_SLAVE_ACCESS_WINDOW_W4_UNPARK_MSG',
    'OS_PARK_SLAVE_W4_ACCESS_WINDOW_END',
    'OS_PARK_SLAVE_ACCESS_WINDOW_END',
    'OS_PARK_END_SLAVE',
    'OS_NOT_ACTIVE_PARK_SLAVE',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_USLCparkSlave_ctrl_state[data] then
        return string.format('parkSlave_info->ctrl_state:%s @USLCparkSlave_Park(f)',t_USLCparkSlave_ctrl_state[data])
    else
        return string.format('parkSlave_info->ctrl_state=0x%X @USLCparkSlave_Park(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
sleep_Ctrl_State=
{
[0]='OS_INACTIVE',                        --    0x0000,
    'OS_START',                           --    0x0001,
    'OS_W4_RADIO_TO_SLEEP',               --    0x0002,
    'OS_W4_BASEBAND_TO_SLEEP',            --    0x0004,
    'OS_SLEEPING',                        --    0x0008,
    'OS_WAKEN_RADIO',                     --    0x0010,
    'OS_WAKEN_BASEBAND',                  --    0x0020,
    'OS_REALIGN_FRAME_INTERRUPTS',        --    0x0040,
    'OS_REALIGN_FRAME_INTERRUPTS_2',      --    0x0080,
    'OS_END',                             --    0x0100,
    'OS_SENTINEL/* NOT A VALID STATE */', --    0xFE00
}

function func_desc_UPT_Dxxx_FIXED(address, data)
  local RxBurstNo = 0
  if data == 0 then
    RxBurstNo=0
  elseif data ==1 then
    RxBurstNo = 1
  elseif bit.rshift(data,0x0001)==1 then
    RxBurstNo = 2
  elseif  bit.rshift(data,0x0002)==1 then
     RxBurstNo =3
  elseif  bit.rshift(data,0x0003)==1 then
     RxBurstNo =4
  elseif  bit.rshift(data,0x0004)==1 then
     RxBurstNo =5
  elseif  bit.rshift(data,0x005)==1 then
     RxBurstNo =6
  elseif  bit.rshift(data,0x0006)==1 then
     RxBurstNo =7
  elseif  bit.rshift(data,0x0007)==1 then
     RxBurstNo =8
  elseif  bit.rshift(data,0x0008)==1 then
     RxBurstNo =9
  else
    RxBurstNo =10
  end
  return string.format('p_sleep_info->ctrl_state:%s @USLCsleep_State_Dispatcher(f)',sleep_Ctrl_State[RxBurstNo])
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_USLCsp_Ctrl_State=
{
[0]='OS_INACTIVE_SP',
    'OS_START_SP',
    'OS_SWITCH_PICONET_RECOVER_TDD',
    'OS_SWITCH_PICONET_RECOVER_SLOT_OFFSET',
    'OS_SWITCH_PICONET_RECOVER_CLK',
    'OS_END_SP',
    'OS_SENTINEL_SP',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_USLCsp_Ctrl_State[data] then
        return string.format('p_sp_info->ctrl_state:%s @USLCsp_State_Dispatcher(f)',t_USLCsp_Ctrl_State[data])
    else
        return string.format('p_sp_info->ctrl_state=0x%X @USLCsp_State_Dispatcher(f)',data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_USLCr2p_Ctrl_State=
{
[0]='OS_INACTIVE_R2P',
    'OS_START_R2P',
    'OS_RECONNECTING',
    'OS_SENTINEL_R2P'
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_USLCr2p_Ctrl_State[data] then
        return string.format('p_r2p_info->ctrl_state:%s @USLCr2p_State_OS_START_(f)',t_USLCr2p_Ctrl_State[data])
    else
        return string.format('p_r2p_info->ctrl_state=0x%X @USLCr2p_State_OS_START_(f)',data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_USLCsp_Ctrl_State[data] then
        return string.format('p_sp_info->ctrl_state:%s @USLCsp_State_Dispatcher_patch(f)',t_USLCsp_Ctrl_State[data])
    else
        return string.format('p_sp_info->ctrl_state=0x%X @USLCsp_State_Dispatcher_patch(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_RadioMode=
{
[0]='RADIO_MODE_STANDBY',
    'RADIO_MODE_FULL_RX',
    'RADIO_MODE_MASTER_DOUBLE_WIN',
    'RADIO_MODE_TX_RX',
    'RADIO_MODE_SLAVE_PAGE_RESP',
    'RADIO_MODE_LE_TIFS_TX_RX',
    'RADIO_MODE_LE_INITIAL_TX',
    'RADIO_MODE_LE_FULL_RX',
    'RADIO_MODE_LE_INITIAL_RX',
    'RADIO_MODE_LE_TESTMODE_TX',
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_RadioMode[data] then
        return string.format('Current RF mode:%s @HWradio_TxComplete(f)',t_RadioMode[data])
    else
        return string.format('Current RF mode=0x%X @HWradio_TxComplete(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
irq_mode=
{
    'PRH_ONE_SHOT_INQUIRY',
    'PRH_PERIODIC_INQUIRY',
}
t_inquiry_states=
{
   'INQUIRY_IDLE',
   'W4_INQUIRY_RESULT',
   'W4_INQUIRY_CANCEL_COMPLETE'
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if irq_mode[bit.rshift(bit.band(data,0xFF00),8)] then
        if t_inquiry_states[bit.band(data,0xFF)] then
            return string.format('Inquiry_Mode:%s, LM_Inq.state:%s @LMinq_Inquiry_Start(f)', irq_mode[bit.rshift(bit.band(data,0xFF00),8)] , t_inquiry_states[bit.band(data,0xFF)])
        else
            return string.format('Inquiry_Mode:%s, LM_Inq.state=%d @LMinq_Inquiry_Start(f)', irq_mode[bit.rshift(bit.band(data,0xFF00),8)] , bit.band(data,0xFF))
        end
    else
        if t_inquiry_states[bit.band(data,0xFF)] then
            return string.format('Inquiry_Mode=%d, LM_Inq.state:%s @LMinq_Inquiry_Start(f)', bit.rshift(bit.band(data,0xFF00),8) , t_inquiry_states[bit.band(data,0xFF)])
        else
            return string.format('Inquiry_Mode=%d, LM_Inq.state=%d @LMinq_Inquiry_Start(f)', bit.rshift(bit.band(data,0xFF00),8) , bit.band(data,0xFF))
        end
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
hw_err_code=
{
[0x00]='PRH_BS_HW_ERROR_NONE',                          -- 0x00
       'PRH_BS_HW_ERROR_HCIT_UART_OVERRUN',             -- 0x01
       'PRH_BS_HW_ERROR_HCIT_RX_PDU_MALFORMED',         -- 0x02
       'PRH_BS_HW_ERROR_INVALID_DEVICE_LINK',           -- 0x03
       'PRH_BS_HW_ERROR_MSS_FAILURE',                   -- 0x04
       'PRH_BS_HW_ERROR_DEBUG_CLKN_READ',               -- 0x05
       'PRH_BS_HW_ERROR_STACK_CORRUPTION',              -- 0x06
       'PRH_BS_HW_ERROR_HCIT_UART_FRAMING',             -- 0x07
       'PRH_BS_HW_ERROR_INVALID_LMP_LINK',              -- 0x08
       'PRH_BS_HW_ERROR_INVALID_PICONET_INDEX',         -- 0x09
       'PRH_BS_HW_ERROR_INCORRECT_RADIO_VERSION',       -- 0x0A
[0x10]='PRH_BS_HW_ERROR_SCHEDULER_CONFIGURATION',       -- 0x10
[0x11]='PRH_BS_HW_ERROR_INCORRECT_TABASCO_VERSION',     -- 0x11
[0x20]='PRH_BS_HW_ERROR_INCORRECT_CTRLSTATE',           -- 0x20
[0x21]='PRH_BS_HW_ERROR_OUT_OF_LMP_TIMERS',             -- 0x21
[0x22]='PRH_BS_HW_ERROR_INCORRECT_SUPER_STATE',         -- 0x22
[0x23]='PRH_BS_HW_ERROR_CORRUPTION_OF_LMP_TIMERS',      -- 0x23
[0x24]='PRH_BS_HW_ERROR_CORRUPTION_OF_QUEUES',          -- 0x24
[0x25]='PRH_BS_HW_ERROR_OUT_OF_LMP_QUEUE_BUFFERS',      -- 0x25
[0x26]='PRH_BS_HW_ERROR_LMP_QUEUE_CORRUPTED',           -- 0x26
[0x27]='PRH_BS_HW_ERROR_OUT_OF_LE_LLC_QUEUE_BUFFERS',   -- 0x27
[0x28]='PRH_BS_HW_ERROR_LE_LLC_QUEUE_CORRUPTED'         -- 0x28
}

function func_desc_UPT_DD05_FIXED(address, data)
    if hw_err_code[data] then
        return string.format('hardware_code:%s @HCeg_Hardware_Error_Event(f)',hw_err_code[data])
    else
        return string.format('HC_Event: hardware_code=0x%X @HCeg_Hardware_Error_Event(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if HCI_STATUS_TYPE[data] then
        return string.format('status:%s @_Dispatch_Link_Control_Command(f)',HCI_STATUS_TYPE[data])
    else
        return string.format('status=0x%X @_Dispatch_Link_Control_Command(f)',data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    local RxBurstNo = 0
    if data == 0 then
      RxBurstNo=0
    elseif data ==1 then
      RxBurstNo = 1
    elseif bit.rshift(data,0x0001)==1 then
      RxBurstNo = 2
    elseif  bit.rshift(data,0x0002)==1 then
       RxBurstNo =3
    elseif  bit.rshift(data,0x0003)==1 then
       RxBurstNo =4
    elseif  bit.rshift(data,0x0004)==1 then
       RxBurstNo =5
    elseif  bit.rshift(data,0x005)==1 then
       RxBurstNo =6
    elseif  bit.rshift(data,0x0006)==1 then
       RxBurstNo =7
    elseif  bit.rshift(data,0x0007)==1 then
       RxBurstNo =8
    elseif  bit.rshift(data,0x0008)==1 then
       RxBurstNo =9
    else
      RxBurstNo =10
    end
    return string.format('p_sleep_info->ctrl_state:%s @USLCsleep_State_Dispatcher(f)',sleep_Ctrl_State[RxBurstNo])
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_ulc_procedure[data] then
        return string.format('inquiry state:%s @XXX(f)',inquiry_ctrl_state[data])
    else
        return string.format('inquiry state=0x%X @XXX(f)',data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_RadioMode[bit.rshift(bit.band(data,0xFF00),8)] then
        if t_RadioMode[bit.band(data,0xFF)] then
            return string.format('RF mode switch from %s to %s @HWradio_Service(f)', t_RadioMode[bit.rshift(bit.band(data,0xFF00),8)] , t_RadioMode[bit.band(data,0xFF)])
        else
            return string.format('RF mode switch from %s to %d @HWradio_Service(f)', t_RadioMode[bit.rshift(bit.band(data,0xFF00),8)] , bit.band(data,0xFF))
        end
    else
        if t_RadioMode[bit.band(data,0xFF)] then
            return string.format('RF mode switch from %d to %s @XXX(f)', bit.rshift(bit.band(data,0xFF00),8) , t_RadioMode[bit.band(data,0xFF)])
        else
            return string.format('RF mode switch from %d to %d @XXX(f)', bit.rshift(bit.band(data,0xFF00),8) , bit.band(data,0xFF))
        end
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
  local RxBurstNo = 0
  if data == 0 then
    RxBurstNo=0
  elseif data ==1 then
    RxBurstNo = 1
  elseif bit.rshift(data,0x0001)==1 then
    RxBurstNo = 2
  elseif  bit.rshift(data,0x0002)==1 then
     RxBurstNo =3
  elseif  bit.rshift(data,0x0003)==1 then
     RxBurstNo =4
  elseif  bit.rshift(data,0x0004)==1 then
     RxBurstNo =5
  elseif  bit.rshift(data,0x005)==1 then
     RxBurstNo =6
  elseif  bit.rshift(data,0x0006)==1 then
     RxBurstNo =7
  elseif  bit.rshift(data,0x0007)==1 then
     RxBurstNo =8
  elseif  bit.rshift(data,0x0008)==1 then
     RxBurstNo =9
  elseif  bit.rshift(data,9)==1 then
     RxBurstNo =10
  elseif  bit.rshift(data,10)==1 then
     RxBurstNo =11
  elseif  bit.rshift(data,11)==1 then
     RxBurstNo =12
  elseif  bit.rshift(data,12)==1 then
     RxBurstNo =13
  elseif  bit.rshift(data,13)==1 then
     RxBurstNo =14
  elseif  bit.rshift(data,14)==1 then
     RxBurstNo =15
  elseif  bit.rshift(data,15)==1 then
     RxBurstNo =16
  else
    RxBurstNo =0
  end
  return string.format('state:%s @LSLChop_Build_Frequency_Table(f)',DEVICE_STATE[RxBurstNo])
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_ulc_procedure[data] then
        return string.format('_chan_ctrl.procedure_active:%s @Patch_Check_Procedure_Active(f)',t_ulc_procedure[data])
    else
        return string.format('_chan_ctrl.procedure_active=0x%X @Patch_Check_Procedure_Active(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
LMP_COMMAND=
{
[0]='NO_OPERATION',                       -- 0
    'LMP_NAME_REQ',                       -- 1
    'LMP_NAME_RES',                       -- 2
    'LMP_ACCEPTED',                       -- 3
    'LMP_NOT_ACCEPTED',                   -- 4
    'LMP_CLKOFFSET_REQ',                  -- 5
    'LMP_CLKOFFSET_RES',                  -- 6
    'LMP_DETACH',                         -- 7
    'LMP_IN_RAND',                        -- 8
    'LMP_COMB_KEY',                       -- 9
    'LMP_UNIT_KEY',                       --10
    'LMP_AU_RAND',                        --11
    'LMP_SRES',                           --12
    'LMP_TEMP_RAND',                      --13
    'LMP_TEMP_KEY',                       --14
    'LMP_ENCRYPTION_MODE_REQ',            --15
    'LMP_ENCRYPTION_KEY_SIZE_REQ',        --16
    'LMP_START_ENCRYPTION_REQ',           --17
    'LMP_STOP_ENCRYPTION_REQ',            --18
    'LMP_SWITCH_REQ',                     --19
    'LMP_HOLD',                           --20
    'LMP_HOLD_REQ',                       --21
    'LMP_SNIFF',                          --22
    'LMP_SNIFF_REQ',                      --23
    'LMP_UNSNIFF_REQ',                    --24
    'LMP_PARK_REQ',                       --25
    'unsupported',                        --26
    'LMP_SET_BROADCAST_SCAN_WINDOW',      --27
    'LMP_MODIFY_BEACON',                  --28
    'LMP_UNPARK_BD_ADDR_REQ',             --29
    'LMP_UNPARK_PM_ADDR_REQ',             --30
    'LMP_INCR_POWER_REQ',                 --31
    'LMP_DECR_POWER_REQ',                 --32
    'LMP_MAX_POWER',                      --33
    'LMP_MIN_POWER',                      --34
    'LMP_AUTO_RATE',                      --35
    'LMP_PREFERRED_RATE',                 --36
    'LMP_VERSION_REQ',                    --37
    'LMP_VERSION_RES',                    --38
    'LMP_FEATURES_REQ',                   --39
    'LMP_FEATURES_RES',                   --40
    'LMP_QUALITY_OF_SERVICE',             --41
    'LMP_QUALITY_OF_SERVICE_REQ',         --42
    'LMP_SCO_LINK_REQ',                   --43
    'LMP_REMOVE_SCO_LINK_REQ',            --44
    'LMP_MAX_SLOT',                       --45
    'LMP_MAX_SLOT_REQ',                   --46
    'LMP_TIMING_ACCURACY_REQ',            --47
    'LMP_TIMING_ACCURACY_RES',            --48
    'LMP_SETUP_COMPLETE',                 --49
    'LMP_USE_SEMI_PERMANENT_KEY',         --50
    'LMP_HOST_CONNECTION_REQ',            --51
    'LMP_SLOT_OFFSET',                    --52
    'LMP_PAGE_MODE_REQ',                  --53
    'LMP_PAGE_SCAN_MODE_REQ',             --54
    'LMP_SUPERVISION_TIMEOUT',            --55
    'LMP_TEST_ACTIVATE',                  --56
    'LMP_TEST_CONTROL',                   --57
    'LMP_ENCRYPTION_KEY_SIZE_MASK_REQ',   --58
    'LMP_ENCRYPTION_KEY_SIZE_MASK_RES',   --59
    'LMP_SET_AFH',                        --60
    'LMP_ENCAPSULATED_HEADER',            --61
    'LMP_ENCAPSULATED_PAYLOAD',           --62
    'LMP_SIMPLE_PAIRING_CONFIRM',         --63
    'LMP_SIMPLE_PAIRING_NUMBER',          --64
    'LMP_DHKEY_CHECK',                    --65
    'LMP_PAUSE_ENCRYPTION_AES_REQ',       --66
[124]='LMP_ESCAPE_1_OPCODE',                --124
[125]='LMP_ESCAPE_2_OPCODE',                --125
[126]='LMP_ESCAPE_3_OPCODE',                --126
[127]='LMP_ESCAPE_4_OPCODE',                --127
}

LMP_ESCAPE_COMMAND=
{
[0]= 'UNSUPPORTED',
     'LMP_ACCEPTED_EXT',                    -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 1)
     'LMP_NOT_ACCEPTED_EXT',                -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 2)
     'LMP_FEATURES_REQ_EXT',                -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 3)
     'LMP_FEATURES_RES_EXT',                -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 4)
     'LMP_SCATTER_REQ',                     -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 5)
     'LMP_UNSCATTER_REQ',                   -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 6)
     'LMP_SET_SUBRATE',                     -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 7)
     'LMP_SCATTER_ALGORITHMS_REQ',          -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 8)
     'LMP_SCATTER_ALGORITHMS_RES',          -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE, 9)
     'LMP_PP_EXTENSION_REQ',                -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,10)
     'LMP_PACKET_TYPE_TABLE_REQ',           -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,11)
     'LMP_ESCO_LINK_REQ',                   -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,12)
     'LMP_REMOVE_ESCO_LINK_REQ',            -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,13)
     'UNSUPPORTED',                         -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,14)
     'UNSUPPORTED',                         -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,15)
     'LMP_CHANNEL_CLASSIFICATION_REQ',      -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,16)
     'LMP_CHANNEL_CLASSIFICATION',          -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,17)
     'LMP_ALIAS_ADDRESS',                   -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,18)
     'LMP_ACTIVE_ADDRESS',                  -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,19)
     'LMP_FIXED_ADDRESS',                   -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,20)
     'LMP_SNIFF_SUBRATING_REQ',             -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,21)
     'LMP_SNIFF_SUBRATING_RES',             -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,22)
     'LMP_PAUSE_ENCRYPTION_REQ',            -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,23)
     'LMP_RESUME_ENCRYPTION_REQ',           -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,24)
     'LMP_IO_CAPABILITY_REQUEST',           -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,25)
     'LMP_IO_CAPABILITY_RESPONSE',          -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,26)
     'LMP_NUMERIC_COMPARISON_FAILED',       -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,27)
     'LMP_PASSKEY_ENTRY_FAILED',            -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,28)
     'LMP_OOB_FAILED',                      -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,29)
     'LMP_KEYPRESS_NOTIFICATION',           -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,30)
     'LMP_POWER_CONTROL_REQ',               -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,31)
     'LMP_POWER_CONTROL_RESP',              -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,32)
     'LMP_PING_REQ',                        -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,33)
     'LMP_PING_RESP',                       -- ENCODE_ESC_OPCODE(LMP_ESCAPE_4_OPCODE,34)
}

function func_desc_UPT_D300_FIXED(address, data)
    if bit.rshift(bit.band(data,0xFF00),8) == 0x7F  then
        return string.format('[LMP_IN]%s',LMP_ESCAPE_COMMAND[data-0X7F00])
    else
      return string.format('[LMP_IN]%s',LMP_COMMAND[data])
    end
end
-- end for one description
function func_desc_UPT_D301_FIXED(address, data)
    if bit.rshift(bit.band(data,0xfF00),8) == 0x7F  then
        return string.format('[LMP_OUT]%s',LMP_ESCAPE_COMMAND[data-0X7F00])
    else
      return string.format('[LMP_OUT]%s',LMP_COMMAND[data])
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_LE_LL_Control_PDU_Opcodes=
{
[0]='LL_CONNECTION_UPDATE_REQ',   --  = 0,
    'LL_CHANNEL_MAP_REQ',         --  = 1,
    'LL_TERMINATE_IND',           --  = 2,
    'LL_ENC_REQ',                 --  = 3,
    'LL_ENC_RSP',                 --  = 4,
    'LL_START_ENC_REQ',           --  = 5,
    'LL_START_ENC_RSP',           --  = 6,
    'LL_UNKNOWN_RSP',             --  = 7,
    'LL_FEATURE_REQ',             --  = 8,
    'LL_FEATURE_RSP',             --  = 9,
    'LL_PAUSE_ENC_REQ',           --  = 10,
    'LL_PAUSE_ENC_RSP',           --  = 11,
    'LL_VERSION_IND',             --  = 12,
    'LL_REJECT_IND',              --  = 13,
    'LL_SLAVE_FEATURE_REQ',       --  = 14,
    'LL_CONNECTION_PARAM_REQ',    --  = 15,
    'LL_CONNECTION_PARAM_RSP',    --  = 16,
    'LL_REJECT_IND_EXT',          --  = 17,
    'LL_PING_REQ',                --  = 18,
    'LL_PING_RSP',                --  = 19,
    'LL_LENGTH_REQ',              --  = 20,
    'LL_LENGTH_RSP',              --  = 21,
    'LL_PHY_REQ',                --  = 22,
    'LL_PHY_RSP',                --  = 23,
    'LL_PHY_UPDATE_IND',           --  = 24,
    'LL_MIN_USED_CHANNELS_IND',    --  = 25,
    'LL_SUPPLEMENTAL_REQ',         --  = 26,
    'LL_SUPPLEMENTAL_RSP',         --  = 27,
    'LL_NO_OPERATION',            --   = 28
}
function func_desc_UPT_D77A_FIXED(address, data)
    if t_LE_LL_Control_PDU_Opcodes[bit.band(data,0xFF)] then
        return string.format('[BLE_LL_IN]link_id=%d, opcode:%s', bit.rshift(bit.band(data,0xFF00),8), t_LE_LL_Control_PDU_Opcodes[bit.band(data,0xFF)])
    else
        return string.format('[LL_IN]link_id=%d, opcode=0x%X', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end

function func_desc_UPT_D77B_FIXED(address, data)
    if t_LE_LL_Control_PDU_Opcodes[bit.band(data,0xFF)] then
        return string.format('[BLE_LL_OUT]link_id=%d, opcode:%s', bit.rshift(bit.band(data,0xFF00),8), t_LE_LL_Control_PDU_Opcodes[bit.band(data,0xFF)])
    else
        return string.format('[BLE_LL_OUT]link_id=%d, opcode=0x%X', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
sniff_state=
{
[0x21]='SNIFF_ACTIVATION_PENDING',
[0x22]='SNIFF_ACTIVE',
[0x23]='SNIFF_INACTIVE',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if sniff_state[data] then
        return string.format('Sniff State:%s @LEconnection_Swtich_Check(f)', sniff_state[data])
    else
        return string.format('Sniff State=0x%X @LEconnection_Swtich_Check(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
msbc_conversion_status=
{
       'MSBC_NOT_ENCODED',
       'MSBC_NOT_DECODED',
[0x04]='MSBC_ENCODE_PENDING',
[0x08]='MSBC_ENCODED',
[0x10]='MSBC_DECODE_PENDING',
[0x20]='MSBC_DECODED',
[0x40]='MSBC_ERR_PKT',
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if msbc_conversion_status[data] then
        return string.format('qd->msbc_conversion_status:%s @BTq_Enqueue(f)', msbc_conversion_status[data])
    else
        return string.format('qd->msbc_conversion_status=0x%X @BTq_Enqueue(f)', data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if msbc_conversion_status[data] then
        return string.format('q->headers_tail->msbc_conversion_status:%s @BTq_Commit(f)', msbc_conversion_status[data])
    else
        return string.format('q->headers_tail->msbc_conversion_status=0x%X @BTq_Commit(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if msbc_conversion_status[data] then
        return string.format('qd->msbc_conversion_status:%s @BTq_Commit(f)', msbc_conversion_status[data])
    else
        return string.format('qd->msbc_conversion_status=0x%X @BTq_Commit(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if USLCpage_ctrl_state[data] then
        return string.format('bluetooth page control states:%s @LEconfig_Switch_To_LE(f)',USLCpage_ctrl_state[data])
    else
        return string.format('bluetooth page control states=0x%X @LEconfig_Switch_To_LE(f)',data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if USLCpage_ctrl_state[data] then
        return string.format('bluetooth page control states:%s @LSLCslot_Handle_TIM2(f)',USLCpage_ctrl_state[data])
    else
        return string.format('bluetooth page control states=0x%X @LSLCslot_Handle_TIM2(f)',data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
IRQ_TYPE=
{
[0]='LE_TIM_0',             --0x00
    'LE_TIM_2',             --0x01
    'LE_PKA',               --0x02
    'LE_PKD',               --0x03
    'LE_NO_PKD',            --0x04
    'LE_SYNC_DET',          --0x05
    'LE_AES_COMPLETE',      --0x06
    'LE_RX_HDR',            --0x07
    'LE_TIM_1',             --0x08
    'LE_TIM_3',             --0x09
    '0XA???',               --0x0A
    '0XB???',               --0x0B
}

LE_STATE_SM=
{
[0]='STANDBY_STATE',      --= 0,
    'ADVERTISING_STATE',  --= 1,
    'SCANNING_STATE',     --= 2,
    'INITIATING_STATE',   --= 3,
    'CONNECTION_STATE',   --= 4,
    'TEST_STATE',         --= 5
}

LE_SUB_STATE=
{
[0x00]='SUBSTATE_IDLE',        -- 0x00
       'W4_T2_PRE_ADV_TX(Not used now)',  --0x01//updated from ceva release 20140311
       'W4_ADV_TX',            -- 0x02
       'W4_ADV_RX',            -- 0x03
       'W4_SCAN_RESP_TX',      -- 0x04
       'W4_N_x_T2',            -- 0x05
       'W4_N_x_T0',            -- 0x06
       'W4_T0_PRE_ADV_TX',     -- 0x07

[0x10]='W4_T2_PRE_SCAN',       --0x10
[0x20]='W4_SCAN_RX',           --0x20
[0x30]='W4_SCAN_TX',           --0x30
[0x40]='W4_SCAN_RESP_RX',      --0x40
[0x50]='W4_SCAN_RESUME',       --0x50
[0x60]='W4_SCAN_PKD',          --0x60
[0x70]='W4_SCAN_RESP_PKD',     --0x70
[0x80]='W4_SCAN_DUMMY_TX',     --0x80
[0x90]='W4_DUMMY_SCAN_RESP_TX', --0x90
[0xA0]='W4_RESUME_SCAN',        --0xA0
[0xB0]='W4_RESUME_SCAN_NEXT_TIM', --0xB0
[0xC0]='W4_RESUME_FROM_CLASSIC',  --0xC0
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('LE link=%d,Slave_Link_Active=%d,LE_config.state:%s,IRQ:%s @LE_LL_Ctrl_Handle_LE_IRQ(f)', bit.rshift(bit.band(data,0xF000),12),bit.rshift(bit.band(data,0x0F00),8),LE_STATE_SM[bit.rshift(bit.band(data,0x0F0),4)],IRQ_TYPE[bit.band(data,0x0F)])
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if LE_SUB_STATE[bit.band(data,0xFF)] then
        return string.format('LE_config.state:%s,LE_config.substate:%s @LEadv_Handle_Advertising(f)', LE_STATE_SM[bit.rshift(bit.band(data,0xFF00),8)], LE_SUB_STATE[bit.band(data,0xFF)])
    else
        return string.format('LE_config.state=%d,LE_config.substate=0x%X @LEadv_Handle_Advertising(f)', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if IRQ_TYPE[data] then
        return string.format('IRQ_Type:%s @LEadv_Handle_Advertising(f)',IRQ_TYPE[data])
    else
        return string.format('IRQ_Type=0x%X @LEadv_Handle_Advertising(f)',data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if LE_SUB_STATE[bit.band(data,0xFF)] then
        return string.format('LE_config.state:%s,LE_config.substate:%s @LE_LL_Ctrl_Handle_Connection_Event(f)', LE_STATE_SM[bit.rshift(bit.band(data,0xFF00),8)], LE_SUB_STATE[bit.band(data,0xFF)])
    else
        return string.format('LE_config.state=%d,LE_config.substate=0x%X @LE_LL_Ctrl_Handle_Connection_Event(f)', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if IRQ_TYPE[data] then
        return string.format('IRQ_Type:%s @LE_LL_Ctrl_Handle_Connection_Event(f)',IRQ_TYPE[data])
    else
        return string.format('IRQ_Type=0x%X @LE_LL_Ctrl_Handle_Connection_Event(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if LE_SUB_STATE[bit.band(data,0xFF)] then
        return string.format('LE_config.state:%s,LE_config.substate:%s @LEscan_Ctrl_Handle_Scanning(f)', LE_STATE_SM[bit.rshift(bit.band(data,0xFF00),8)], LE_SUB_STATE[bit.band(data,0xFF)])
    else
        return string.format('LE_config.state=%d,LE_config.substate=0x%X @LEscan_Ctrl_Handle_Scanning(f)', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if IRQ_TYPE[data] then
        return string.format('IRQ_Type:%s @LEscan_Ctrl_Handle_Scanning(f)',IRQ_TYPE[data])
    else
        return string.format('IRQ_Type=0x%X @LEscan_Ctrl_Handle_Scanning(f)',data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if LE_SUB_STATE[bit.band(data,0xFF)] then
        return string.format('LE_config.state:%s,LE_config.substate:%s @LEtest_Ctrl_Handle_Test_Mode_Event(f)', LE_STATE_SM[bit.rshift(bit.band(data,0xFF00),8)], LE_SUB_STATE[bit.band(data,0xFF)])
    else
        return string.format('LE_config.state=%d,LE_config.substate=0x%X @LEtest_Ctrl_Handle_Test_Mode_Event(f)', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if IRQ_TYPE[data] then
        return string.format('IRQ_Type:%s @LEtest_Ctrl_Handle_Test_Mode_Event(f)',IRQ_TYPE[data])
    else
        return string.format('IRQ_Type=0x%X @LEtest_Ctrl_Handle_Test_Mode_Event(f)',data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
CONNECT_SUB_STATE=
{
[0x00]='SUBSTATE_IDLE',
       'W4_T2_MASTER_CONN_FIRST_TX',        -- 0x01
       'W4_MASTER_CONN_FIRST_TX',           -- 0x02
       'W4_MASTER_CONN_RX',                 -- 0x03
       'W4_MASTER_CONN_TX',                 -- 0x04
       'W4_T0_PRE_MASTER_FIRST_CONN_TX',    -- 0x05
[0x10]='W4_T0_PRE_SLAVE_CONN_FIRST_RX',     -- 0x10
[0x11]='W4_T2_SLAVE_CONN_FIRST_RX',         -- 0x11
[0x12]='W4_SLAVE_CONN_FIRST_RX',            -- 0x12
[0x13]='W4_SLAVE_CONN_TX',                  -- 0x13
[0x14]='W4_SLAVE_CONN_RX',                  -- 0x14
[0x15]='W4_T1_SLAVE_CONN_FIRST_FULL_RX',    -- 0x15
[0x16]='W4_T2_SLAVE_CONN_FIRST_FULL_RX',    -- 0x16
[0x17]='W4_T1_PRE_SLAVE_CE',                -- 0x17
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('LE State:%s, connection sub state:%s @LEconnection_Handle_Connection_Event(f)',LE_STATE_SM[bit.rshift(bit.band(data,0xFF00),8)], CONNECT_SUB_STATE[bit.band(data,0x0FF)])
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
bt_packet=
{
[0]='NULLpkt',      -- =  0,   /* a NULL packet */
    'POLLpkt',      -- =  1,   /* a POLL packet */
    'FHSpkt',       -- =  2,   /* an FHS packet */
    'DM1',          -- =  3,   /* a DM1 packet */
    'DH1',          -- =  4,   /* a DH1 packet */
    'HV1',          -- =  5,   /* a HV1 packet */
    'HV2',          -- =  6,   /* a HV2 packet */
    'HV3',          -- =  7,   /* a HV3 packet */
    'DV',           -- =  8,   /* a DV packet */
    'AUX1',         -- =  9,   /* an AUX1 packet */
    'DM3',          -- = 10,   /* a DM3 packet */
    'DH3',          -- = 11,   /* a DH3 packet */
    'EV4',          -- = 12,   /* an EV4 packet */
    'EV5',          -- = 13,   /* an EV5 packet */
    'DM5',          -- = 14,   /* a DM5 packet */
    'DH5',          -- = 15,   /* a DH5 packet */
    'IDpkt',        -- = 16,   /* an ID packet */
    'INVALIDpkt',   -- = 17,   /* an unexpected packet type */
    'ERR_pkt',      -- = 18
    'ERR_pkt',      -- = 19
    'EDR_2DH1',     -- = 20, // 0x14
    'EV3',          -- = 21,//23 /* CM: 11 Sep 2007. To be set to 21 */
    'EDR_2EV3',     -- = 22, // 0x16
    'EDR_3EV3',     -- = 23,//0x17 /* CM: 11 Sep 2007. To be set to 23 */
    'EDR_3DH1',     -- = 24, // 0x18
    'EDR_AUX1',     -- = 25, // 0x19
    'EDR_2DH3',     -- = 26, // 0x1A
    'EDR_3DH3',     -- = 27, // 0x1B
    'EDR_2EV5',     -- = 28, // 0x1C
    'EDR_3EV5',     -- = 29, // 0x1D
    'EDR_2DH5',     -- = 30, // 0x1E
    'EDR_3DH5',     -- = 31  // 0x1F
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if bt_packet[bit.band(data,0xFF)] then
        return string.format('dalta=%d,Tx_Packet_Typ:%s @Patch_Get_Link_Tx_Activity_Check(f)', bit.rshift(bit.band(data,0xFF00),8), bt_packet[bit.band(data,0xFF)])
    else
        return string.format('dalta=%d,Tx_Packet_Typ=%d @Patch_Get_Link_Tx_Activity_Check(f)', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('testScenario/packetType/rxgain=0x%X one by one @TC_Rx_Testmode_Set_Parameters(f)', data)
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if bt_packet[bit.band(data,0xFF)] then
        return string.format('dalta=%d,Tx_Packet_Typ:%s @LMpol_Get_Next_Master_Tx_Activity(f)', bit.rshift(bit.band(data,0xFF00),8), bt_packet[bit.band(data,0xFF)])
    else
        return string.format('dalta=%d,Tx_Packet_Typ=%d @LMpol_Get_Next_Master_Tx_Activity(f)', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if bt_packet[data] then
        return string.format('Tx_Packet_Typ:%s @LMpol_Get_Next_Master_Tx_Activity(f)', bt_packet[data])
    else
        return string.format('Tx_Packet_Typ=0x%X @LMpol_Get_Next_Master_Tx_Activity(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if LE_STATE_SM[data] then
        return string.format('LE previous state:%s @_LEscan_Scan_Window_Complete(f)', LE_STATE_SM[data])
    else
        return string.format('LE previous state=0x%X @_LEscan_Scan_Window_Complete(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if pageScan_ctrl_state[bit.rshift(bit.band(data,0xFF00),8)] then
        if inqScan_ctrl_state[bit.band(data,0xFF)] then
            return string.format('Pagescan state:%s Inquiryscan state:%s @LEconfig_Has_Classic_Scan_Procedure(f)', pageScan_ctrl_state[bit.rshift(bit.band(data,0xFF00),8)] , inqScan_ctrl_state[bit.band(data,0xFF)])
        else
            return string.format('Pagescan state:%s Inquiryscan state:%d @LEconfig_Has_Classic_Scan_Procedure(f)', pageScan_ctrl_state[bit.rshift(bit.band(data,0xFF00),8)] , bit.band(data,0xFF))
        end
    else
        if inqScan_ctrl_state[bit.band(data,0xFF)] then
            return string.format('Pagescan state:%d Inquiryscan state:%s @LEconfig_Has_Classic_Scan_Procedure(f)', bit.rshift(bit.band(data,0xFF00),8) , inqScan_ctrl_state[bit.band(data,0xFF)])
        else
            return string.format('Pagescan state=%d Inquiryscan state=%d @LEconfig_Has_Classic_Scan_Procedure(f)', bit.rshift(bit.band(data,0xFF00),8) , bit.band(data,0xFF))
        end
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if LE_STATE_SM[data] then
        return string.format('LE state:%s @LEll_Decode_Advertising_ChannelPDU(f)', LE_STATE_SM[data])
    else
        return string.format('LE state=0x%X(SCANNING_STATE)@LEll_Decode_Advertising_ChannelPDU(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_LE_LL_Control_PDU_Opcodes[data] then
        return string.format('Pending LL opcode:%s @_LEconnection_Encode_DataPDU(f)', t_LE_LL_Control_PDU_Opcodes[data])
    else
        return string.format('Pending LL opcode=0x%X @_LEconnection_Encode_DataPDU(f)', data)
    end
end
-- end for one description


-- BLE description
-- NOTE:  by default, lua table start with index=1
LEDEBUG_TRACE_CODE=
{
    --  define for le adv
    [0X0]='LEADV_TRACE_CODE_BEGIN',
    [0X1]='LEADV_TRACE_LOSS_IRQ',
    [0X2]='LEADV_TRACE_PKD_ERROR',
    [0X3]='LEADV_TRACE_NO_ADV_TOSTART',
    [0X4]='LEADV_TRACE_ALLOCATEID_FAIL',
    [0X5]='LEADV_TRACE_START_ERROR',
    [0XFF]='LEADV_TRACE_CODE_MAX',

    -- define for le scan
    [0X100]='LESCAN_TRACE_CODE_BEGIN',
    [0X101]='LESCAN_TRACE_LOSS_IRQ',
    [0X102]='LESCAN_TRACE_IDLE_ERROR',
    [0X103]='LESCAN_TRACE_HDR_ERROR',
    [0X104]='LESCAN_TRACE_PKD_ERROR',
    [0X105]='LESCAN_TRACE_ADVTYPE_ERROR',
    [0X106]='LESCAN_TRACE_INIT_UNEXPECTEDTYPE',
    [0X107]='LESCAN_TRACE_SCANFILTER_FAIL',
    [0X108]='LESCAN_TRACE_INITFILTER_FAIL',
    [0X109]='LESCAN_TRACE_CODE_MAX',
    [0X10A]='LEAPCF_TRACE_MEMORY_FULL',
    [0X10B]='LEAPCF_TRACE_UNSPECIFIED_ERROR',
    [0X1FF]='LEADVEX_TRACE_CODE_MAX',

    -- define for le adv extension
    [0X200]='LEADVEX_TRACE_CODE_BEGIN',
    [0x2ff]='LEADVEX_TRACE_CODE_MAX = 0x2ff',

    -- define for le connection
    [0X300]='LECON_TRACE_CODE_BEGIN',
    [0X301]='LECON_TRACE_FIRST_RX_CRC',
    [0X302]='LECON_TRACE_SLAVE_RX_CRC',
    [0X303]='LECON_TRACE_BACK2BACK_CRC',
    [0X304]='LECON_TRACE_MAX_NUM_ERROR',
    [0X305]='LECON_TRACE_CMD_DISALLOWED',
    [0X306]='LECON_TRACE_INVALID_PARAM',
    [0X307]='LECON_TRACE_INVALID_PARAM01',
    [0X308]='LECON_TRACE_INVALID_PARAM02',
    [0X309]='LECON_TRACE_INVALID_PARAM03',
    [0X30A]='LECON_TRACE_INVALID_PARAM04',
    [0X30B]='LECON_TRACE_INVALID_PARAM05',
    [0X30C]='LECON_TRACE_INVALID_PARAM06',
    [0X30D]='LECON_TRACE_INVALID_PARAM07',
    [0X30E]='LECON_TRACE_INVALID_PARAM08',
    [0X30F]='LECON_TRACE_INVALID_PARAM09',
    [0X310]='LECON_TRACE_UNSPECIFIED',
    [0X311]='LECON_TRACE_PPR_INVALID_PARAM',
    [0X312]='LECON_TRACE_PPR_INVALID_PARAM01',
    [0X313]='LECON_TRACE_PPR_INVALID_PARAM02',
    [0X314]='LECON_TRACE_PPR_NO_CONNECTION',
    [0X315]='LECON_TRACE_PRNR_NO_CONNECTION',
    [0X316]='LECON_TRACE_UPDATE_INVALID_PARAM',
    [0X317]='LECON_TRACE_UPDATE_INVALID_PARAM1',
    [0X318]='LECON_TRACE_UPDATE_INVALID_PARAM2',
    [0X319]='LECON_TRACE_UPDATE_INVALID_PARAM3',
    [0X31A]='LECON_TRACE_UPDATE_INVALID_PARAM4',
    [0X31B]='LECON_TRACE_UPDATE_INVALID_PARAM5',
    [0X31C]='LECON_TRACE_UPDATE_TRAN_COLLISION',
    [0X31D]='LECON_TRACE_UPDATE_LIMITED_RESOURCES',
    [0X31E]='LECON_TRACE_UPDATE_CMD_DISALLOWED',
    [0X31F]='LECON_TRACE_HOP_INCREMENT_INVALID',
    [0X320]='LECON_TRACE_HANDLE_IS_INVALID',
    [0X321]='LECON_TRACE_RRUF_NO_CONNECTION',
    [0X322]='LECON_TRACE_RRVI_NO_CONNECTION',
    [0X323]='LECON_TRACE_RRVI_CMD_DISALLOWED',
    [0X324]='LECON_TRACE_LLCENCODE_ERROR',
    [0X325]='LECON_TRACE_LLCENCODE_ERROR1',
    [0X326]='LECON_TRACE_LLCENCODE_ERROR2',
    [0X327]='LECON_TRACE_LLCENCODE_MEMORY_FULL',
    [0X328]='LECON_TRACE_GNEST_ERROR',
    [0X329]='LECON_TRACE_GLME_MEMORY_FULL',
    [0X32A]='LECON_TRACE_GLME_UNSPECIFIED_ERROR',
    [0X32B]='LECON_HCI_CACHE_NO_CONNECTION',
    [0X32C]='LECON_HCI_CACHE_NO_CONNECTION1',
    [0X32D]='LECON_HCI_CACHE_DQUEUE_ERROR',
    [0X32E]='LECON_HCI_CACHE_DQUEUE_ERROR1',
    [0X32F]='LECON_HCI_CACHE_EQUEUE_ERROR',
    [0X330]='LECON_HCI_CACHE_FREE_ERROR',
    [0X331]='LECON_HCI_CACHE_FREE_ERROR1',
    [0X332]='LECON_HCI_CACHE_FREE_ERROR2',
    [0X333]='LECON_HCI_CACHE_FREE_ERROR3',
    [0X334]='LECON_HCI_CACHE_MALLOC_ERROR',
    [0X335]='LECON_EVENT_HANDLE_IRQ_ERROR',
    [0X3FF]='LECON_EVENT_HANDLE_IRQ_ERROR',
}

BLE_IRQ=
{
    [0]='LE_TIM_0',
    [1]='LE_TIM_1',
    [2]='LE_TIM_2',
    [3]='LE_TIM_3',
    [4]='LE_PKA',
    [5]='LE_SYNC_DET',
    [6]='LE_RX_HDR',
    [7]='LE_PKD',   
    [8]='LE_NO_PKD',        
}
BLE_MASTER_STATE=
{
    [0]='W4_MASTER_PRE_CONN_FIRST_TX',
    [1]='W4_MASTER_CONN_FIRST_TX',
    [2]='W4_MASTER_CONN_RX',
    [3]='W4_MASTER_CONN_TX',
    [4]='W4_MASTER_CONN_FINAL_RX',
    [8]='LE_MASTER_STATE_MAX',      
}
BLE_SLAVE_STATE=
{
    [0]='W4_SLAVE_PRE_CONN_FIRST_RX',
    [1]='W4_SLAVE_CONN_FIRST_RX',
    [2]='W4_SLAVE_CONN_TX',
    [3]='W4_SLAVE_CONN_RX',
    [4]='W4_SLAVE_CONN_FINAL_RX',
    [8]='LE_SLAVE_STATE_MAX',       
}
BLE_ADV_STATE=
{
    [0]='ADV_IDLE',                  
    'W4_ADV_TX',                   
    'W4_ADV_RX',           
    'W4_SCAN_RESP_TX',   
    'W4_PERIODIC_ADV_TX',            
    'W4_N_x_T2',  
    'W4_END_THIS',                      
}

BLE_SCAN_STATE=
{
    [0]='W4_SCAN_IDLE',                  
    'W4_SCAN_RX',                  
    'W4_SCAN_PKD',           
    'W4_SCAN_TX',    
    'W4_SCAN_RESP_PKD',              
    'W4_PKD_END',  
    [8]='LESCAN_EVENT_STATE_MAX',                   
}

ADV_SCAN_PDU_TYPE=
{
[0]='ADV_IND',                 --= 0,
    'ADV_DIRECT_IND',          --= 1,
    'ADV_NONCONN_IND',         --= 2,
    'SCAN_REQ',                --= 3,
    'SCAN_RSP',                --= 4,
    'CONNECT_REQ',             --= 5,
    'ADV_SCAN_IND',            --= 6, 
    'ADV_EXT_CHN_PDU_TYPE',    --= 7
    'AUX_CONNECT_RSP_CHN_PDU', --= 8
    'ADV_DUMMY',               --= 9
}



function func_desc_UPT_D7FF_FIXED(address, data)
    if LEDEBUG_TRACE_CODE[data] then
        return string.format('ble trace 0x%x', LEDEBUG_TRACE_CODE[data])
    else
        return string.format('ble trace 0x%x', data)
    end
end

function func_desc_UPT_D75F_FIXED(address, data)
    if BLE_MASTER_STATE[bit.rshift(bit.band(data,0x00F0),4)] then
        if BLE_IRQ[bit.band(data,0x000F)] then
            return string.format('total_links=0x%x link_id=0x%x state=%s, irq=%s', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                BLE_MASTER_STATE[bit.rshift(bit.band(data,0x00F0),4)], BLE_IRQ[bit.band(data,0x000F)])
        else
            return string.format('total_links=0x%x link_id=0x%x state=%s, irq=0x%x', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                BLE_MASTER_STATE[bit.rshift(bit.band(data,0x00F0),4)], bit.band(data,0x000F))
        end
    else
        if BLE_IRQ[bit.band(data,0x000F)] then
        
            return string.format('total_links=0x%x link_id=0x%x state=0x%x, irq=%s', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                bit.rshift(bit.band(data,0x00F0),4), BLE_IRQ[bit.band(data,0x000F)])
        else
            return string.format('total_links=0x%x link_id=0x%x state=0x%x, irq=0x%x', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                bit.rshift(bit.band(data,0x00F0),4), bit.band(data,0x000F))
        end
    end
end

function func_desc_UPT_D760_FIXED(address, data)
    if BLE_SLAVE_STATE[bit.rshift(bit.band(data,0x00F0),4)] then
        if BLE_IRQ[bit.band(data,0x000F)] then
            return string.format('total_links=0x%x link_id=0x%x state=%s, irq=%s', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                BLE_SLAVE_STATE[bit.rshift(bit.band(data,0x00F0),4)], BLE_IRQ[bit.band(data,0x000F)])
        else
            return string.format('total_links=0x%x link_id=0x%x state=%s, irq=0x%x', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                BLE_SLAVE_STATE[bit.rshift(bit.band(data,0x00F0),4)], bit.band(data,0x000F))
        end
    else
        if BLE_IRQ[bit.band(data,0x000F)] then
        
            return string.format('total_links=0x%x link_id=0x%x state=0x%x, irq=%s', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                bit.rshift(bit.band(data,0x00F0),4), BLE_IRQ[bit.band(data,0x000F)])
        else
            return string.format('total_links=0x%x link_id=0x%x state=0x%x, irq=0x%x', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8),
                bit.rshift(bit.band(data,0x00F0),4), bit.band(data,0x000F))
        end
    end
end

function func_desc_UPT_D710_FIXED(address, data)
    if BLE_ADV_STATE[bit.rshift(bit.band(data,0xFF00),8)] then
        if BLE_IRQ[bit.band(data,0xFF)] then
            return string.format('le adv handle state=%s  irq_type=%s', BLE_ADV_STATE[bit.rshift(bit.band(data,0xFF00),8)], BLE_IRQ[bit.band(data,0xFF)])
        else
            return string.format('le adv handle state=%s  irq_type=0x%x', BLE_ADV_STATE[bit.rshift(bit.band(data,0xFF00),8)], bit.band(data,0xFF))
        end 
    else
        if BLE_IRQ[bit.band(data,0xFF)] then
            return string.format('le adv handle state=0x%x  irq_type=%s', bit.rshift(bit.band(data,0xFF00),8), BLE_IRQ[bit.band(data,0xFF)])
        else
            return string.format('le adv handle state=0x%x  irq_type=0x%x', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
        end
    end
end

function func_desc_UPT_D700_FIXED(address, data)
    if BLE_SCAN_STATE[bit.rshift(bit.band(data,0xFF00),8)] then
        if BLE_IRQ[bit.band(data,0xFF)] then
            return string.format('le adv handle state=%s  irq_type=%s', BLE_SCAN_STATE[bit.rshift(bit.band(data,0xFF00),8)], BLE_IRQ[bit.band(data,0xFF)])
        else
            return string.format('le adv handle state=%s  irq_type=0x%x', BLE_SCAN_STATE[bit.rshift(bit.band(data,0xFF00),8)], bit.band(data,0xFF))
        end 
    else
        if BLE_IRQ[bit.band(data,0xFF)] then
            return string.format('le adv handle state=0x%x  irq_type=%s', bit.rshift(bit.band(data,0xFF00),8), BLE_IRQ[bit.band(data,0xFF)])
        else
            return string.format('le adv handle state=0x%x  irq_type=0x%x', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
        end
    end
end

function func_desc_UPT_D704_FIXED(address, data)
    if ADV_SCAN_PDU_TYPE[data] then
        return string.format('Encode ADV PDU:%s',ADV_SCAN_PDU_TYPE[data])
    else
        return string.format('Encode ADV PDU=0x%x',data)
    end
end

function func_desc_UPT_D705_FIXED(address, data)
    if ADV_SCAN_PDU_TYPE[data] then
        return string.format('Decode ADV PDU:%s',ADV_SCAN_PDU_TYPE[data])
    else
        return string.format('Decode ADV PDU=0x%x',data)
    end
end

function func_desc_UPT_D758_FIXED(address, data)
    if BLE_EVT_SUB[bit.band(data,0xFF)] then
        return string.format('LE meta event link_id=%d, event:%s', bit.rshift(bit.band(data,0xFF00),8), BLE_EVT_SUB[bit.band(data,0xFF)])
    else
        return string.format('LE meta event link_id=%d, event=%d', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end

-- end for BLE description










-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
key_type=
{
[0]='COMBINATION_KEY',                       -- 0
    'LOCAL_UNIT_KEY',                        -- 1
    'REMOTE_UNIT_KEY',                       -- 2
    'DEBUG_COMBINATION_KEY',                 -- 3
    'UNAUTHENTICATED_COMBINATION_KEY',       -- 4
    'AUTHENTICATED_COMBINATION_KEY',         -- 5
    'CHANGED_COMBINATION_KEY',               -- 6
    'UNAUTHENTICATED_COMBINATION_KEY_P256',  -- 7
    'AUTHENTICATED_COMBINATION_KEY_P256',    -- 8
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if key_type[data] then
        return string.format('p_link->key_type %s @_LMssp_Calculate_Link_Key(f)', key_type[data])
    else
        return string.format('p_link->key_type=0x%X @_LMssp_Calculate_Link_Key(f)', data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_LE_LL_Control_PDU_Opcodes[data] then
        return string.format('LL pending opcode:%s @_LEconnection_Encode_DataPDU(f)', t_LE_LL_Control_PDU_Opcodes[data])
    else
        return string.format('LL pending opcode=0x%X @_LEconnection_Encode_DataPDU(f)', data)
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1f
function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('RxValidPackets/RxInvalidPackets/rx_packet_type/JAL_EDR_PTT_ACL/JAL_EDR_PTT_ESCO=0x%X one by one @TC_Set_Nonsig_Rx_Testmode_Check_Packet_Type(f)', data)
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_scanEnable=
{
[0]='NO_SCANS_ENABLED',             --  = 0x00, /* No scanning enabled */
    'INQUIRY_SCAN_ONLY_ENABLED',    --  = 0x01, /* Only inquiry scan enabled */
    'PAGE_SCAN_ONLY_ENABLED',       --  = 0x02, /* Only page scan enabled */
    'BOTH_SCANS_ENABLED',           --  = 0x03  /* Both page scan and inquiry scan enabled */
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_scanEnable[data] then
        return string.format('scanEnable:%s @LMscan_Write_Scan_Enable(f)', t_scanEnable[data])
    else
        return string.format('scanEnable=0x%X @LMscan_Write_Scan_Enable(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if HCI_STATUS_TYPE[data] then
        return string.format('status:%s @HCeg_Generate_Event(f)', HCI_STATUS_TYPE[data])
    else
        return string.format('status=0x%X @HCeg_Generate_Event(f)', data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
-- function func_desc_UPT_Dxxx_FIXED(address, data)
-- mawei: do not for DA55
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_ulc_procedure[data] then
        return string.format('procedure:%s @USLCchac_Procedure_Request(f)',t_ulc_procedure[data])
    else
        return string.format('procedure=0x%X @USLCchac_Procedure_Request(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1f
function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('(q_type<<8|pending_commits)/num_entries=0x%X one by one @BTq_Enqueue(f)', data)
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('p_data_queue->next_free_pointer/packet_type=0x%X separated by DB29 @_BTq_Allocate_Header(f)', data)
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if LMP_COMMAND[data] then
        return string.format('opcode:%s @LM_Encode_LMP_PDU_patch(f)', LMP_COMMAND[data])
    else
        return string.format('opcode=0x%X @LM_Encode_LMP_PDU_patch(f)', data)
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1

irq_irq=
{
    'PKA_IRQ',       -- 0x01
    'PKD_IRQ',       -- 0x02
    'NO_PKD_IRQ',    -- 0x03
    'TIM0_IRQ',      -- 0x04
    'TIM2_IRQ',      -- 0x05
    'SCHED_NOIRQ',   -- 0x06
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_RadioMode[bit.rshift(bit.band(data,0xF000),12)] then
        if irq_irq[bit.band(data,0x000F)] then
            return string.format('RadioMode:%s,net_Status_t2=%d,Esco_Scatternet_Status_t0=%d,irq:%s @Esco_Piconet_Switch_Sch(f)', t_RadioMode[bit.rshift(bit.band(data,0xF000),12)], bit.rshift(bit.band(data,0x0F00),8), bit.rshift(bit.band(data,0x00F0),4), irq_irq[bit.band(data,0x000F)])
        else
            return string.format('RadioMode:%s,net_Status_t2=%d,Esco_Scatternet_Status_t0=%d,irq=%d @Esco_Piconet_Switch_Sch(f)', t_RadioMode[bit.rshift(bit.band(data,0xF000),12)], bit.rshift(bit.band(data,0x0F00),8), bit.rshift(bit.band(data,0x00F0),4), bit.band(data,0x000F))
        end
    else
        if irq_irq[bit.band(data,0x000F)] then
            return string.format('RadioMode=%d,net_Status_t2=%d,Esco_Scatternet_Status_t0=%d,irq:%s @Esco_Piconet_Switch_Sch(f)', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8), bit.rshift(bit.band(data,0x00F0),4), irq_irq[bit.band(data,0x000F)])
        else
            return string.format('RadioMode=%d,net_Status_t2=%d,Esco_Scatternet_Status_t0=%d,irq=%d @Esco_Piconet_Switch_Sch(f)', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8), bit.rshift(bit.band(data,0x00F0),4), bit.band(data,0x000F))
        end
    end
end
-- end for one description



-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if irq_irq[bit.band(data,0x000F)] then
        return string.format('(Unused %d),net_Status_t2=%d,Esco_Scatternet_Status_t0=%d,irq:%s @Esco_Piconet_Switch_Sch(f)', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8), bit.rshift(bit.band(data,0x00F0),4), irq_irq[bit.band(data,0x000F)])
    else
        return string.format('(Unused %d),net_Status_t2=%d,Esco_Scatternet_Status_t0=%d,irq=%d @Esco_Piconet_Switch_Sch(f)', bit.rshift(bit.band(data,0xF000),12), bit.rshift(bit.band(data,0x0F00),8), bit.rshift(bit.band(data,0x00F0),4), bit.band(data,0x000F))
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_lm_sco_states=
{
[0]='SCO_UNUSED',                              -- = 0,
    'SCO_MASTER_DEACTIVATION_PENDING',         -- = 1,
    'SCO_IDLE',                                -- = 2,
    'SCO_ACTIVATION_PENDING',                  -- = 3,
    'SCO_ACTIVE',                              -- = 4,
    'SCO_CHANGE_PKT_ACCEPT_ACK_PENDING',       -- = 5
    'eSCO_MASTER_ACTIVATION_PENDING',          -- = 6,
    'eSCO_MASTER_INACTIVE',                    -- = 7,
    'eSCO_MASTER_RESERVED_SLOT_TX',            -- = 8,
    'eSCO_MASTER_RESERVED_SLOT_RX',            -- = 9,
    'eSCO_MASTER_RETRANSMISSION_WINDOW_TX',    -- = 10,
    'eSCO_MASTER_RETRANSMISSION_WINDOW_RX',    -- = 11,
    'eSCO_SLAVE_ACTIVATION_PENDING',           -- = 12,
    'eSCO_SLAVE_INACTIVE',                     -- = 13,
    'eSCO_SLAVE_RESERVED_SLOT_TX',             -- = 14,
    'eSCO_SLAVE_RESERVED_SLOT_RX',             -- = 15,
    'eSCO_SLAVE_RETRANSMISSION_WINDOW_TX',     -- = 16,
    'eSCO_SLAVE_RETRANSMISSION_WINDOW_RX',     -- = 17
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_lm_sco_states[data] then
        return string.format('previous_status:%s @LMpol_Is_SCO_Next_Activity_Scatternet(f)',  t_lm_sco_states[data])
    else
        return string.format('previous_status=0x%X @LMpol_Is_SCO_Next_Activity_Scatternet(f)',  data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
FM_SUB_CMD=
{
[0x00]='FM_RX_CMD_ENABLE',                 --  0x00       /*Enable command*/
       'FM_RX_CMD_TUNE',                   --  0x01       /*Tune command*/
       'FM_RX_CMD_MUTE',                   --  0x02       /*MUTE command*/
       'FM_RX_CMD_SEARCH',                 --  0x03       /*Search command*/
       'FM_RX_CMD_COMBO_SEARCH',           --  0x04       /*Combo Search command:search FM with frequency wrap and this command has parameter*/
       'FM_RX_CMD_SEARCH_ABORT',           --  0x05       /*Search Abort command,and this command no parameter*/
       'FM_RX_CMD_SET_RDS_MODE',           --  0x06       /*Enable RDS/AF for FM command*/
       'FM_RX_CMD_SET_RDS_TYPE',           --  0x07       /*Set RDS Type command:RDS or RDBS*/
       'FM_RX_CMD_AUDIO_MODE',             --  0x08       /*Auduio Mode command: Configure FM audio mode to be mono/stereo/blend*/
       'FM_RX_CMD_SET_AUDIO_PATH',         --  0x09      /*Set Audio path command*/
       'FM_RX_CMD_SET_REGION',             --  0x0a       /*Set Region command*/
       'FM_RX_CMD_SET_SCAN_STEP',          --  0x0b       /*Set Scan Step command: 50KHZ/100KHZ*/
       'FM_RX_CMD_CONFIG_DEEMPHASIS',      --  0x0d       /*Config Deemphasis command*/
       'FM_RX_CMD_ESTIMATE_NOISE_FLOOR',   --  0x0e       /*Estimate Noise Floor command*/
       'FM_RX_CMD_READ_AUDIO_QUALITY',     --  0x0f       /* Read Audio Quality of Current Station command*/
       'FM_RX_CMD_SET_VOLUME',             --  0x10      /*Set Volume command*/
       'UNKNOWN',                          --  0x11
       'FM_RX_CMD_DISABLE',                --  0x12          /*Disable command*/
       'FM_RX_CMD_GET_RSSI',               --  0x13    /*Get Current RSSI command*/
       'FM_RX_CMD_CLEANUP',                --  0x14       /*Close the Interface command*/
       'FM_RX_CMD_SOFTMUTE',               --  0x15       /*Soft mute command*/
       'FM_RX_CMD_FREQ_OFFSET',            --  0x17/*Freq Offset command*/
       'FM_RX_CMD_PILOT_PWR',              --  0x18/*Pilot Power command*/
       'FM_RX_CMD_PILOT_NOISE',            --  0x19/*Pilot Noise command*/
[0x20]='FM_RX_CMD_TUNE_TEST',              --  0x20/*Tune pandora test command*/
[0x21]='FM_RX_CMD_SEEK_TEST',              --  0x21/*Seek pandora test command*/
[0x22]='FM_RX_CMD_READ_REG_TEST',          --  0x22/*Read reg pandora test command*/
[0x23]='FM_RX_CMD_WRITE_REG_TEST',         --  0x23/*Write reg pandora test command*/
}

function func_desc_UPT_Dxxx_FIXED(address, data)
    if FM_SUB_CMD[data] then
        return string.format('FM_sub_cmd:%s @Handle_FM_Command(f)',FM_SUB_CMD[data])
    else
        return string.format('FM_sub_cmd=0x%X @Handle_FM_Command(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_ulc_procedure[data] then
        return string.format('chan_ctrl active procedure:%s @Has_SP_Procedure(f)',t_ulc_procedure[data])
    else
        return string.format('chan_ctrl active procedure=0x%X @Has_SP_Procedure(f)',data)
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_LCHmessage=
{
[0]='LCH_null',        --  = 0,
    'LCH_continue',    --  = 1,
    'LCH_start',       --  = 2,
    'LMP_msg/LE_LLC',  --  = 3,
}
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_LCHmessage[bit.rshift(bit.band(data,0xFF00),8)] then
        return string.format('Rx PDU LLID:%s,Len=%d @_LEconnection_Decode_DataPDU(f)', t_LCHmessage[bit.rshift(bit.band(data,0xFF00),8)], bit.band(data,0xFF))
    else
        return string.format('Rx PDU LLID=%d,Len=%d @_LEconnection_Decode_DataPDU(f)', bit.rshift(bit.band(data,0xFF00),8), bit.band(data,0xFF))
    end
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    if t_RadioMode[data] then
        return string.format('RadioMode:%s @USLCchac_Procedure_Set_Status(f)',t_RadioMode[data])
    else
        return string.format('RadioMode=0x%X @USLCchac_Procedure_Set_Status(f)',data)
    end
end
-- end for one description


-- -- used in func_desc_UPT_Dxxx_FIXED
-- -- NOTE:  by default, lua table start with index=1
-- function func_desc_UPT_Dxxx_FIXED(address, data)
--  if bt_packet[data] then
--      return string.format('RX   packet_type:%s', bt_packet[data])
--  else
--      return string.format('packet_type=0x%X', data)
--  end
-- end
-- -- end for one description
-- 
-- -- used in func_desc_UPT_Dxxx_FIXED
-- -- NOTE:  by default, lua table start with index=1
-- function func_desc_UPT_Dxxx_FIXED(address, data)
--  if bt_packet[data] then
--      return string.format('TX   packet_type:%s', bt_packet[data])
--  else
--      return string.format('packet_type=0x%X', data)
--  end
-- end
-- -- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
t_role=
{
    [0]='MASTER',
    [1]='SLAVE',
}
function func_desc_UPT_D113_FIXED(address, data)
    local pkt_type=bit.band(data,0xFF)
    local dev_index=bit.rshift(bit.band(data,0xF00),8)
    local peer_role=bit.rshift(bit.band(data,0xF000),12)
    if t_role[1-peer_role] then
        if bt_packet[pkt_type] then
            return string.format('RX   role=%s,device index=%d packet type=%s', t_role[1-peer_role], dev_index, bt_packet[pkt_type])
        else
            return string.format('RX   role=%s,device index=%d packet type=%d', t_role[1-peer_role], dev_index, pkt_type)
        end
    else
        if bt_packet[pkt_type] then
            return string.format('RX   peer_role=%d,device index=%d packet type=%s', peer_role, dev_index, bt_packet[pkt_type])
        else
            return string.format('RX   peer_role=%d,device index=%d packet type=%d', peer_role, dev_index, pkt_type)
        end
    end
end
-- end for one description
function func_desc_UPT_D114_FIXED(address, data)
    local pkt_type=bit.band(data,0xFF)
    local dev_index=bit.rshift(bit.band(data,0xF00),8)
    local peer_role=bit.rshift(bit.band(data,0xF000),12)
    if t_role[1-peer_role] then
        if bt_packet[pkt_type] then
            return string.format('TX   role=%s,device index=%d packet type=%s', t_role[1-peer_role], dev_index, bt_packet[pkt_type])
        else
            return string.format('TX   role=%s,device index=%d packet type=%d', t_role[1-peer_role], dev_index, pkt_type)
        end
    else
        if bt_packet[pkt_type] then
            return string.format('TX   peer_role=%d,device index=%d packet type=%s', peer_role, dev_index, bt_packet[pkt_type])
        else
            return string.format('TX   peer_role=%d,device index=%d packet type=%d', peer_role, dev_index, pkt_type)
        end
    end
end
-- end for one description

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
arqn_type=
{
[0]='NAK',          --= 0,
    'ACK',          --= 1,
}

-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
flow_type=
{
[0]='STOP',        --= 0,
    'GO',          --= 1,
}

-- used in func_desc_UPT_D103_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D103_FIXED(address, data)
    local RX_SEQ = bit.band(data,0x0001)
    local RX_AM_ADDR = bit.rshift(bit.band(data,0x000e), 1)
    local RX_L_CH = bit.rshift(bit.band(data,0x0030), 4)
    local RX_P_FLOW = bit.rshift(bit.band(data,0x0040), 6)
    return string.format('rx packet rx_status_reg_high16 info:  rx_seqn = %d,  rx_am_addr = %d,  rx_l_ch = %d,  rx_p_folw = %d',RX_SEQ, RX_AM_ADDR, RX_L_CH, RX_P_FLOW)
end
-- end for one description

-- used in func_desc_UPT_D102_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D102_FIXED(address, data)
    local RX_LEN = bit.band(data,0x3FF)
    local RX_FLOW = bit.rshift(bit.band(data,0x4000),14)
    local RX_ARQN = bit.rshift(bit.band(data,0x8000),15)
    return string.format('rx packet rx_status_reg_low16 info:  rx_len = %d,  rx_ack = %s,  rx_flow = %s',RX_LEN, arqn_type[RX_ARQN], flow_type[RX_FLOW])
end
-- end for one description

-- used in func_desc_UPT_D115_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D115_FIXED(address, data)
    local TX_LEN = bit.band(data,0x3FF)
    local TX_FLOW = bit.rshift(bit.band(data,0x4000),14)
    local TX_ARQN = bit.rshift(bit.band(data,0x8000),15)
    return string.format('tx packet tx_ctrl_reg_low16 info:  tx_len = %d,  tx_ack = %s,  tx_flow = %s', TX_LEN, arqn_type[TX_ARQN], flow_type[TX_FLOW])
end
-- end for one description

hw_tx_mode=
{
[0]='TXm_TRANSMITTER_DISABLED',
    'TXm_NORMAL',
    'TXm_SLAVE_1ST_HALF__MASTER_BOTH',
    'TXm_2ND_HALF_SLOT',
}

hw_rx_mode=
{
[0]='RXm_RECEIVER_DISABLED',
    'RXm_SINGLE_WIN',
    'RXm_DOUBLE_WIN',
    'RXm_FULL_WIN',
}

-- used in func_desc_UPT_D116_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D116_FIXED(address, data)
    local TX_SEQ = bit.band(data,0x0001)
    local TX_MODE = bit.rshift(bit.band(data,0x000c), 2)
    local TX_L_CH = bit.rshift(bit.band(data,0x0030), 4)
    local TX_P_FLOW = bit.rshift(bit.band(data,0x0040), 6)
    return string.format('tx packet tx_ctrl_reg_high16 info:  tx_seqn = %s,  tx_mode = %s,  tx_l_ch = %s,  tx_p_folw = %s', TX_SEQ, hw_tx_mode[TX_MODE], TX_L_CH, TX_P_FLOW)
end
-- end for one description

lslc_common_state=
{
[0]='COM_IDLE', --= 0,
    'COM_W4_TX_START', --= 1,
    'COM_W4_ENABLE_RXR', --= 2,
    'COM_W4_3SLOT_INTR_TX', --= 3,
    'COM_W4_5SLOT_INTR_TX', --= 4,
    'COM_W4_5SLOT_1ST_TIM0', --= 5,
    'COM_W4_5SLOT_1ST_TIM2', --= 6,
    'COM_W4_SETUP_ENABLE_RXR', --= 7,
    'COM_W4_RX_START', --= 8,
    'COM_W4_RX_INTR', --= 9,
    'COM_W4_COMPLETE_RX', --= 10,
    'COM_W4_3SLOT_INTR_RX', --= 11,
    'COM_W4_5SLOT_INTR_RX', --= 12,
    'COM_W4_PKD_INTR', --= 13,
    'COM_R2P_SCAN', --= 14,
}


es_irq_type=
{
[0]='TIM0',
    'TIM1',
    'TIM2',
    'TIM3',
    'PKA',
    'SYN_DEC',
    'HDR',
    'PKD',
    'NO_PKT',
    'AUX',
    'CROSS_EVENT_ISR',
    'IRQ_MAX',
}


uslc_prepare_type=
{
[0]='PREPARE_SCO',
    'PREPARE_SNIFF',
    'PREPARE_ACL',
    'PREPARE_R2P',
    'PREPARE_MSS',
    'PREPARE_PAGE',
    'PREPARE_PAGESCAN',
    'PREPARE_NUM',
}

-- used in func_desc_UPT_D16E_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D16E_FIXED(address, data)
    local IRQ = bit.rshift(bit.band(data,0xFF00), 8)
    local LSLC_STATE = bit.band(data,0x00FF)
    return string.format('lslc common irq = %s,  uslc prepare type = %s', es_irq_type[IRQ], lslc_common_state[LSLC_STATE])
end
-- end for one description

-- used in func_desc_UPT_D16F_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D16F_FIXED(address, data)
    local BEFORE_STATE = bit.rshift(bit.band(data,0xFF00), 8)
    local TO_STATE = bit.band(data,0x00FF)
    return string.format('lslc common state from=%s    to=%s', lslc_common_state[BEFORE_STATE], lslc_common_state[TO_STATE])
end
-- end for one description

uslc_page_state=
{
[0]='OS_START_PAGE',
    'OS_END_PAGE',
    'OS_NOT_ACTIVE_PAGE',
    'OS_PAGING_TX',
    'OS_PAGING_RX',
    'OS_MASTER_PAGE_RESP_TX',
    'OS_MASTER_PAGE_RESP_RX',
    'OS_MASTER_PAGE_RESP_LOOK_AHEAD_RX',
    'OS_POLL_RESP_TX',
    'OS_POLL_RESP_RX',
    'OS_POLL_RESP_LOOK_AHEAD_RX',
    'OS_CONNECTED_TO_SLAVE',
    'OS_PAGING_LOOK_AHEAD_RX',
    'OS_SUSPEND_PAGE',
    'OS_RESUME_PAGE',
}
-- used in func_desc_UPT_D128_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D128_FIXED(address, data)
    return string.format('uslc page state = %s', uslc_page_state[bit.band(data,0xFFFF)])
end
-- end for one description

uslc_inquiry_state=
{
[0]='OS_START_INQUIRY',
    'OS_END_INQUIRY',
    'OS_NOT_ACTIVE_INQUIRY',
    'OS_INQUIRY_TX_RX',
    'OS_EXTENDED_INQUIRY_RESPONSE',
    'OS_SUSPEND_INQUIRY',
    'OS_RESUME_INQUIRY',
    'OS_INQUIRY_MAX',
}
-- used in func_desc_UPT_D125_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D125_FIXED(address, data)
    return string.format('uslc inquiry state = %s', uslc_inquiry_state[bit.band(data,0xFFFF)])
end
-- end for one description


uslc_pagescan_state=
{
[0]='OS_START_PAGESCAN',
    'OS_END_PAGESCAN',
    'OS_NOT_ACTIVE_PAGESCAN',
    'OS_RESUME_PAGE_SCANNING',
    'OS_PAGE_SCAN',
    'OS_SLAVE_PAGE_RESP',
    'OS_POLL_RESP_RX_PAGESCAN',
    'OS_CONNECTED_TO_MASTER',
    'OS_END_AT_NEXT_TX_START',
    'OS_PAGESCAN_2ND_TRAIN',
    'OS_SUSPEND_PAGESCAN',
    'OS_RESUME_PAGESCAN',
}
-- used in func_desc_UPT_D125_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D129_FIXED(address, data)
    return string.format('uslc page scan state = %s', uslc_pagescan_state[bit.band(data,0xFFFF)])
end
-- end for one description


uslc_inqscan_state=
{
[0]='OS_START_INQUIRYSCAN',
    'OS_END_INQUIRYSCAN',
    'OS_NOT_ACTIVE_INQUIRYSCAN',
    'OS_INQUIRY_SCAN',
    'OS_INQUIRY_RAND_WAIT',
    'OS_INQUIRY_RESPONSE',
    'OS_INQUIRY_SCAN_RESUME',
    'OS_INQUIRY_W4_RESPONSE_COMPLETE',
    'OS_INQUIRY_SCAN_2ND_TRAIN',
    'OS_INQUIRY_GENERATE_EIR_PACKET',
    'OS_SUSPEND_INQUIRYSCAN',
    'OS_RESUME_INQUIRYSCAN',
}
-- used in func_desc_UPT_D125_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D126_FIXED(address, data)
    return string.format('uslc inquiry scan state = %s', uslc_inqscan_state[bit.band(data,0xFFFF)])
end
-- end for one description

uslc_mss_state=
{
[0]='OS_INACTIVE_MSS',
    'OS_START_MSS',

    'OS_SLAVE_A_TDD_SWITCH_TX',
    'OS_SLAVE_A_TDD_SWITCH_RX',
    'OS_MASTER_A_PICONET_SWITCH_TX',
    'OS_MASTER_A_PICONET_SWITCH_RX',
    'OS_SLAVE_A_MSS_FAILURE_RECOVER_TDD',
    'OS_SLAVE_A_MSS_FAILURE_RECOVER_SLOT_OFFSET',
    'OS_SLAVE_A_MSS_FAILURE_RECOVER_CLK',
    'OS_MASTER_A_CONNECTED_TO_SLAVE',
    'OS_MASTER_B_TDD_SWITCH_RX',
    'OS_SLAVE_B_PICONET_SWITCH_INTRASLOT_ADJUST',
    'OS_SLAVE_B_PICONET_SWITCH_RX',
    'OS_MASTER_B_END',
    'OS_SLAVE_B_CONNECTED_TO_MASTER',
    'OS_RECOVER_ORIGINAL_PICONET',
    'OS_SENTINEL_MSS',
}
-- used in func_desc_UPT_D125_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D127_FIXED(address, data)
    return string.format('uslc mss state = %s', uslc_mss_state[bit.band(data,0xFFFF)])
end
-- end for one description

lmp_esco_state=
{
[0]='SCO_UNUSED',
    'SCO_MASTER_DEACTIVATION_PENDING',
    'SCO_IDLE',
    'SCO_ACTIVATION_PENDING',
    'SCO_ACTIVE',
    'SCO_CHANGE_PKT_ACCEPT_ACK_PENDING',
    'eSCO_MASTER_ACTIVATION_PENDING',
    'eSCO_MASTER_INACTIVE',
    'eSCO_MASTER_RESERVED_SLOT_TX',
    'eSCO_MASTER_RESERVED_SLOT_RX',
    'eSCO_MASTER_RETRANSMISSION_WINDOW_TX',
    'eSCO_MASTER_RETRANSMISSION_WINDOW_RX',
    'eSCO_SLAVE_ACTIVATION_PENDING',
    'eSCO_SLAVE_INACTIVE',
    'eSCO_SLAVE_RESERVED_SLOT_TX',
    'eSCO_SLAVE_RESERVED_SLOT_RX',
    'eSCO_SLAVE_RETRANSMISSION_WINDOW_TX',
    'eSCO_SLAVE_RETRANSMISSION_WINDOW_RX',
}
-- used in func_desc_UPT_D353_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D353_FIXED(address, data)
    local BEFORE_STATE = bit.rshift(bit.band(data,0xFF00), 8)
    local TO_STATE = bit.band(data,0x00FF)
    return string.format('is_next_sco_activity lmp esco state from=%s    to=%s', lmp_esco_state[BEFORE_STATE], lmp_esco_state[TO_STATE])
end
-- end for one description

-- used in func_desc_UPT_D356_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D356_FIXED(address, data)
    local BEFORE_STATE = bit.rshift(bit.band(data,0xFF00), 8)
    local TO_STATE = bit.band(data,0x00FF)
    return string.format('get_next_sco_activity lmp esco state from=%s    to=%s', lmp_esco_state[BEFORE_STATE], lmp_esco_state[TO_STATE])
end
-- end for one description


lmp_sniff_state=
{
[0]='LMP_SNIFF_ACTIVATION_PENDING',
    'LMP_SNIFF_ACTIVE',
    'LMP_SNIFF_INACTIVE',
}
-- used in func_desc_UPT_D34E_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D34E_FIXED(address, data)
    local BEFORE_STATE = bit.rshift(bit.band(data,0x0300), 8)
    local TO_STATE = bit.band(data,0x0003)
    return string.format('get_next_master_sniff_activity  lmp sniff  state from=%s    to=%s', lmp_sniff_state[BEFORE_STATE-1], lmp_sniff_state[TO_STATE-1])
end
-- end for one description


-- used in func_desc_UPT_D35A_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D35A_FIXED(address, data)
    local BEFORE_STATE = bit.rshift(bit.band(data,0x0300), 8)
    local TO_STATE = bit.band(data,0x0003)
    return string.format('get_next_slave_sniff_activity  lmp sniff  state from=%s    to=%s', lmp_sniff_state[BEFORE_STATE-1], lmp_sniff_state[TO_STATE-1])
end
-- end for one description

lslc_page_state=
{
[0]='PAG_IDLE',
    'PAG_W4_TX_START',
    'PAG_W4_2ND_PKA',
    'PAG_W4_RXR',
    'PAG_W4_RX_START',
    'PAG_W4_PKD_INTR',
}
-- used in func_desc_UPT_D178_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D178_FIXED(address, data)
    local IRQ = bit.rshift(bit.band(data,0xF000), 12)
    local BEFORE_STATE = bit.rshift(bit.band(data,0x0F00), 8)
    local TO_STATE = bit.rshift(bit.band(data,0x00F0), 4)
    return string.format('lslc page_event irq=%s,   lslc page state from=%s    to=%s', es_irq_type[IRQ], lslc_page_state[BEFORE_STATE], lslc_page_state[TO_STATE])
end
-- end for one description


lslc_inquiry_state=
{
[0]='INQ_IDLE',
    'INQ_W4_TX_ID',
    'INQ_W4_2ND_PKA',
    'INQ_W4_FHS_RXR',
    'INQ_W4_FHS_INTR',

    'INQ_W4_1ST_FHS_PKD',
    'INQ_W4_1ST_EIR_INTR',
    'INQ_W4_1ST_EIR_PKD',

    'INQ_W4_2ND_FHS_PKD',
    'INQ_W4_2ND_EIR_INTR',
    'INQ_W4_2ND_EIR_PKD',
    'INQ_W4_TIM2_2ND_EIR',
}
-- used in func_desc_UPT_D174_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D174_FIXED(address, data)
    local IRQ = bit.rshift(bit.band(data,0xF000), 12)
    local BEFORE_STATE = bit.rshift(bit.band(data,0x0F00), 8)
    local TO_STATE = bit.rshift(bit.band(data,0x00F0), 4)
    return string.format('lslc inquiry_event irq=%s,   lslc inquiry state from=%s    to=%s', es_irq_type[IRQ], lslc_inquiry_state[BEFORE_STATE], lslc_inquiry_state[TO_STATE])
end
-- end for one description

es_event_type=
{
[0]='EVT_INQUIRY_SCAN',
    'EVT_PAGE_SCAN',
    'EVT_ADVERTISER',
    'EVT_SCANNER',
    'EVT_INITIATOR',
    'EVT_EXT_ADVERTISER',
    'EVT_RFU_T1',
    'EVT_RFU_T2',

    'EVT_INQUIRY',
    'EVT_PAGE',
    'EVT_HIGH_DUTY_ADV',
    'EVT_EXT_HIGH_DUTY_ADV',
    'EVT_NPI_CLASSIC',
    'EVT_NPI_LE',
    'EVT_RFU_P1',
    'EVT_RFU_P2',

    'EVT_ACL',
    'EVT_RFU_N1',
    'EVT_RFU_N2',

    'EVT_SNIFF',
    'EVT_ESCO',
    'EVT_ROLE_SWITCH',
    'EVT_LE',
    'EVT_EXT_ADV_ON_SECONDARY',
    'EVT_PERIODIC_ADV',
    'EVT_SCAN_ON_SECONDARY',
    'EVT_PERIODIC_SCAN',
    'EVT_INITIATE_ON_SECONDARY',
    'EVT_RFU_C1',
    'EVT_RFU_C2',
    'EVT_RFU_C3',

    'EVT_IDLE',
    'EVT_MAX',
}
-- used in func_desc_UPT_D501_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D501_FIXED(address, data)
    local LINK_ID = bit.rshift(bit.band(data,0xFF00), 8)
    return string.format('es_event_checker_request: current event link id = %d,  event type = %s', LINK_ID, es_event_type[bit.band(data,0x00FF)])
end
-- end for one description

-- used in func_desc_UPT_D503_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D503_FIXED(address, data)
    local LINK_ID = bit.rshift(bit.band(data,0xFF00), 8)
    return string.format('es_event_end_indication: new event link id = %d,  event type = %s', LINK_ID, es_event_type[bit.band(data,0x00FF)])
end
-- end for one description

-- used in func_desc_UPT_D502_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D502_FIXED(address, data)
    local LINK_ID = bit.rshift(bit.band(data,0xFF00), 8)
    return string.format('new event selected in es_event_checker_request: new event link id = %d,  event type = %s', LINK_ID, es_event_type[bit.band(data,0x00FF)])
end
-- end for one description

-- used in func_desc_UPT_D570_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D570_FIXED(address, data)
    local LINK_ID = bit.rshift(bit.band(data,0xFF00), 8)
    return string.format('es_event_skip: skip event link id = %d,  event type = %s', LINK_ID, es_event_type[bit.band(data,0x00FF)])
end
-- end for one description

-- used in func_desc_UPT_D57A_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D57A_FIXED(address, data)
    local EVT_TYPE = bit.rshift(bit.band(data,0xFF00), 8)
    local IRQ_TYPE = bit.band(data,0x00FF)
    return string.format('next event type = %s,  compensate IRQ type = %s', es_event_type[EVT_TYPE], es_irq_type[IRQ_TYPE])
end
-- end for one description

uslc_r2p_state=
{
[0]='OS_INACTIVE_R2P',
    'OS_START_R2P',
    'OS_RECONNECTING',
    'OS_SENTINEL_R2P',
};

-- used in func_desc_UPT_D12C_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D12C_FIXED(address, data)
    local R2P_STATE = bit.band(data,0x00FF)
    return string.format('r2p ctrl state = %s', uslc_r2p_state[R2P_STATE])
end
-- end for one description


-- used in func_desc_UPT_D179_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D179_FIXED(address, data)
    local IRQ = bit.rshift(bit.band(data,0xF000), 12)
    local TX_MODE = bit.rshift(bit.band(data,0x0F00), 8)
    local RX_MODE = bit.rshift(bit.band(data,0x00F0), 4)
    return string.format('lslc pagescan event irq = %s,  tx_mode = %s,  rx_mode = %s', es_irq_type[IRQ], hw_tx_mode[TX_MODE], hw_rx_mode[RX_MODE])
end
-- end for one description


-- used in func_desc_UPT_D173_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D173_FIXED(address, data)
    local IRQ = bit.rshift(bit.band(data,0xF000), 12)
    local TX_MODE = bit.rshift(bit.band(data,0x0F00), 8)
    local RX_MODE = bit.rshift(bit.band(data,0x00F0), 4)
    return string.format('lslc inqscan event irq = %s,  tx_mode = %s,  rx_mode = %s', es_irq_type[IRQ], hw_tx_mode[TX_MODE], hw_rx_mode[RX_MODE])
end
-- end for one description

lmp_afh_mode=
{
[0]='AFH_MODE_DISABLED',
    'AFH_MODE_ENABLED',
    'AFH_MODE_EX_79',
    'AFH_MODE_EX_ENABLED_ON_ACK',
    'AFH_MODE_ERR',
    'AFH_MODE_ERR',
    'AFH_MODE_ERR',
    'AFH_MODE_ERR',
    'AFH_MODE_EX_INACTIVE',
}
-- used in func_desc_UPT_D167_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D167_FIXED(address, data)
    local CURR_AFH_MODE = bit.rshift(bit.band(data,0xF000), 12)
    local NEXT_AFH_MODE = bit.rshift(bit.band(data,0x0F00), 8)
    local AFH_MOVED = bit.rshift(bit.band(data,0x00F0), 4)
    local AFH_TABLE_UPDATED = bit.band(data,0x000F)
    return string.format('AFH instant expired point: current_afh_mode = %s,  next_afh_mode = %s,  afh_instant_moved = %d,  afh_table_updated = %d', lmp_afh_mode[CURR_AFH_MODE], lmp_afh_mode[NEXT_AFH_MODE], AFH_MOVED, AFH_TABLE_UPDATED)
end
-- end for one description


-- used in func_desc_UPT_D168_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D168_FIXED(address, data)
    local CURR_AFH_MODE = bit.rshift(bit.band(data,0xF000), 12)
    local NEXT_AFH_MODE = bit.rshift(bit.band(data,0x0F00), 8)
    local AFH_MOVED = bit.rshift(bit.band(data,0x00F0), 4)
    local AFH_TABLE_UPDATED = bit.band(data,0x000F)
    return string.format('LSLCafh_Get_Frequency_Channel: current_afh_mode = %s,  next_afh_mode = %s,  afh_instant_moved = %d,  afh_table_updated = %d', lmp_afh_mode[CURR_AFH_MODE], lmp_afh_mode[NEXT_AFH_MODE], AFH_MOVED, AFH_TABLE_UPDATED)
end
-- end for one description


lslc_r2p_state=
{
[0]='R2P_IDLE',
    'R2P_ACTIVE',
}

-- used in func_desc_UPT_D17F_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D17F_FIXED(address, data)
    local IRQ = bit.rshift(bit.band(data,0xFF00), 8)
    local R2P_STATE = bit.band(data,0x00FF)
    return string.format('lslc r2p irq = %s,  lslc r2p state = %s', es_irq_type[IRQ], lslc_r2p_state[R2P_STATE])
end
-- end for one description

rx_pkt_status=
{
[0]='rx hec error!',
    'rx crc error!',
    'rx am addr error!',
    'rx duplicate packet and crc error!',
    'rx duplicate packet!',
}

-- used in func_desc_UPT_D10A_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D10A_FIXED(address, data)
    return string.format('lslc rx packet error: %s', rx_pkt_status[bit.band(data,0x000F)])
end
-- end for one description

lslc_mss_state=
{
[0]='MSS_IDLE',
    'MSS_MASTER_CONTEXT_ACTIVE',
    'MSS_SLAVE_CONTEXT_ACTIVE',
}

-- used in func_desc_UPT_D177_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D177_FIXED(address, data)
    local IRQ = bit.rshift(bit.band(data,0xF000), 12)
    local before_state = bit.rshift(bit.band(data,0x0F00), 8)
    local after_state = bit.rshift(bit.band(data,0x00F0), 4)
    return string.format('lslc mss irq is %s, lslc mss state from %s to %s', es_irq_type[IRQ], lslc_mss_state[before_state], lslc_mss_state[after_state])
end
-- end for one description


device_ctrl_state=
{
[0]='NOT_CONNECTED',
    'CONNECTED_TO_MASTER',
    'CONNECTED_TO_SLAVE',
    'CONNECTED_TO_MASTER_INACTIVE',
    'CONNECTED_TO_SLAVE_INACTIVE',
}

device_role=
{
[0]='MASTER',
    'SLAVE',
}
-- used in func_desc_UPT_D57F_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_D57F_FIXED(address, data)
    local ctrl_state = bit.rshift(bit.band(data,0xF000), 12)
    local role_of_peer = bit.rshift(bit.band(data,0x0F00), 8)
    local piconet_clk_index = bit.rshift(bit.band(data,0x00F0), 4)
	local role = bit.band(data,0x000F)
    return string.format('switch piconet: ctrl_state is %s, role_of_peer is %s, piconet_clk_index is %s, role is %s', device_ctrl_state[ctrl_state], device_role[role_of_peer], piconet_clk_index, device_role[role])
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('HCI_EVT_BODY:0x%x  ----- Number of COmpleted Packets Event ', data)
end
-- end for one description


-- used in func_desc_UPT_Dxxx_FIXED
-- NOTE:  by default, lua table start with index=1
function func_desc_UPT_Dxxx_FIXED(address, data)
    return string.format('+++++++++++++++++++++++++++++++++++++++++++++++++++++ bt native clock=%d', data)
end
-- end for one description



