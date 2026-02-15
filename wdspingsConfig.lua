local panelData =
{
    type = "panel",
    name = "wd's pings",
    displayName = "|cEAC8E9wd's pings|r",
    author = "@|cEAC8E9wdiscute|r on discord",
    version = "1.23",
    registerForRefresh = true
}
wdsPings.sounds = {}
wdsPings.sounds[1] = "No_Sound"
wdsPings.sounds[2] = "BG_CTF_FlagDropped_OtherTeam"
wdsPings.sounds[3] = "BG_Round_Recap_Flag_Score_Fade"
wdsPings.sounds[4] = "BG_Spectator_Cam_Close"
wdsPings.sounds[5] = "Campaign_Ready_Check"
wdsPings.sounds[6] = "CrownCrates_Card_Selected"


wdsPings.textures = {}
wdsPings.textures[1] = "wdsPings/icons/default_ping.dds"
wdsPings.textures[2] = "wdsPings/icons/default_ping_aqua.dds"
wdsPings.textures[3] = "wdsPings/icons/default_ping_green.dds"
wdsPings.textures[4] = "wdsPings/icons/default_ping_yellow.dds"
wdsPings.textures[5] = "wdsPings/icons/default_ping_orange.dds"
wdsPings.textures[6] = "wdsPings/icons/default_ping_rose.dds"
wdsPings.textures[7] = "wdsPings/icons/default_ping_purple.dds"

wdsPings.textures[8] = "wdsPings/icons/Assist.dds"
wdsPings.textures[9] = "wdsPings/icons/Assist_aqua.dds"
wdsPings.textures[10] = "wdsPings/icons/Assist_green.dds"
wdsPings.textures[11] = "wdsPings/icons/Assist_yellow.dds"
wdsPings.textures[12] = "wdsPings/icons/Assist_orange.dds"
wdsPings.textures[13] = "wdsPings/icons/Assist_rose.dds"
wdsPings.textures[14] = "wdsPings/icons/Assist_purple.dds"

wdsPings.textures[15] = "wdsPings/icons/Shield.dds"
wdsPings.textures[16] = "wdsPings/icons/Shield_aqua.dds"
wdsPings.textures[17] = "wdsPings/icons/Shield_green.dds"
wdsPings.textures[18] = "wdsPings/icons/Shield_yellow.dds"
wdsPings.textures[19] = "wdsPings/icons/Shield_orange.dds"
wdsPings.textures[20] = "wdsPings/icons/Shield_rose.dds"
wdsPings.textures[21] = "wdsPings/icons/Shield_purple.dds"

wdsPings.textures[15] = "wdsPings/icons/Arrow.dds"
wdsPings.textures[16] = "wdsPings/icons/Arrow_aqua.dds"
wdsPings.textures[17] = "wdsPings/icons/Arrow_green.dds"
wdsPings.textures[18] = "wdsPings/icons/Arrow_yellow.dds"
wdsPings.textures[19] = "wdsPings/icons/Arrow_orange.dds"
wdsPings.textures[20] = "wdsPings/icons/Arrow_rose.dds"
wdsPings.textures[21] = "wdsPings/icons/Arrow_purple.dds"

wdsPings.textures[22] = "wdsPings/icons/Shield.dds"
wdsPings.textures[23] = "wdsPings/icons/Shield_aqua.dds"
wdsPings.textures[24] = "wdsPings/icons/Shield_green.dds"
wdsPings.textures[25] = "wdsPings/icons/Shield_yellow.dds"
wdsPings.textures[26] = "wdsPings/icons/Shield_orange.dds"
wdsPings.textures[27] = "wdsPings/icons/Shield_rose.dds"
wdsPings.textures[28] = "wdsPings/icons/Shield_purple.dds"

wdsPings.textures[29] = "wdsPings/icons/Sparkles.dds"
wdsPings.textures[30] = "wdsPings/icons/Danger.dds"

wdsPings.textures[31] = "wdsPings/icons/1.dds"
wdsPings.textures[32] = "wdsPings/icons/2.dds"
wdsPings.textures[33] = "wdsPings/icons/3.dds"
wdsPings.textures[34] = "wdsPings/icons/4.dds"
wdsPings.textures[35] = "wdsPings/icons/5.dds"
wdsPings.textures[36] = "wdsPings/icons/6.dds"
wdsPings.textures[37] = "wdsPings/icons/7.dds"
wdsPings.textures[38] = "wdsPings/icons/8.dds"
wdsPings.textures[39] = "wdsPings/icons/9.dds"
wdsPings.textures[40] = "wdsPings/icons/10.dds"
wdsPings.textures[41] = "wdsPings/icons/11.dds"
wdsPings.textures[42] = "wdsPings/icons/12.dds"

wdsPings.textures[43] = "OdySupportIcons/icons/squares/square_orange_OT.dds"
wdsPings.textures[44] = "OdySupportIcons/icons/squares/square_red_MT.dds"

local optionsTable =
{
    [1] = {
        type = "description",
        title =
        "Quickly ping to your group with |cEAC8E9wd's pings™|r (trademark pending). Set keybinds under Controls > wd's pings. Others need to have this addon to see your pings.",
        text = "",
        width = "full",
    },
    [2] = {
        type = "header",
        name = "Your Icons",
        width = "full",
    },
    [3] = {
        type = "iconpicker",
        name = "Pings (Temporary):",
        choices = wdsPings.textures,
        getFunc = function() return wdsPings.settings.pingIconTemp end,
        setFunc = function(var)
            wdsPings.settings.pingIconTemp = var
            wdsPings.savedVariables.pingIconTemp = var
        end,
        iconSize = 50,
        maxColumns = 7,
        width = "half",
        default = "default"
    },
    [4] = {
        type = "iconpicker",
        name = "Markers (Permanent):",
        choices = wdsPings.textures,
        getFunc = function() return wdsPings.settings.pingIconPerm end,
        setFunc = function(var)
            wdsPings.settings.pingIconPerm = var
            wdsPings.savedVariables.pingIconPerm = var
        end,
        iconSize = 50,
        maxColumns = 7,
        width = "half",
        default = "default"
    },
    [5] = {
        type = "header",
        name = "Something went wrong. Please re-open this menu.", --SUMMERSET - [0] Markers loaded
        width = "full",
        reference = "ClearShareSettingsMenuReference"
    },
    [6] = {
        type = "description",
        title = nil,
        text = "You may also use |cFF746C/wd clear|r or |cFF746C/wd c|r", --left side above button
        width = "half",
    },
    [7] = {
        type = "description",
        title = nil,
        text = "You may also use |cFF746C/wd share|r or |cFF746C/wd s|r", --right side above button
        width = "half",
    },
    [8] = {
        type = "button",
        name = "Clear Markers",
        tooltip = "",
        func = function()
            wdsPings.ClearSavedMarkers()
            wdsPings.updateSettingsTable()
        end,
        width = "half",
        warning = "This button will clear all markers you have in this zone. Can not be undone!"
    },
    [9] = {
        type = "button",
        name = "Share Markers",
        tooltip = "",
        func = function()
            wdsPings.ShareMarkers()
            wdsPings.updateSettingsTable()
        end,
        width = "half",
        warning = "This button will re-share every marker in this zone with your group."
    },
    [10] = { --pings settings
        type = "submenu",
        name = "|c6488eaPINGS|r & |cb399ddMARKERS|r SETTINGS",
        controls = {
            [1] = {
                type = "slider",
                name = "|c6488eaPings|r (temporary) scale:",
                min = 0.1,
                max = 20,
                step = 0.01,
                decimals = 2,
                getFunc = function() return wdsPings.settings.scalePing end,
                setFunc = function(var)
                    wdsPings.settings.scalePing = var
                    wdsPings.savedVariables.scalePing = var
                end,
                width = "half",
                warning = "This scale is applied only on your game. It does not affect how others see pings."
            },
            [2] = {
                type = "slider",
                name = "|cb399ddMarkers|r (permanent) scale:",
                min = 0.1,
                max = 20,
                step = 0.01,
                decimals = 2,
                getFunc = function() return wdsPings.settings.scaleMarker end,
                setFunc = function(var)
                    wdsPings.settings.scaleMarker = var
                    wdsPings.savedVariables.scaleMarker = var
                end,
                width = "half",
                warning = "This scale is applied only on your game. It does not affect how others see pings."
            },
        },
    },
    [11] = { --import/export
        type = "submenu",
        name = "IMPORT & EXPORT",
        controls = {
            [1] = {
                type = "slider",
                name = "|c6488eaPings|r (temporary) scale:",
                min = 0.1,
                max = 20,
                step = 0.01,
                decimals = 2,
                getFunc = function() return wdsPings.settings.scalePing end,
                setFunc = function(var)
                    wdsPings.settings.scalePing = var
                    wdsPings.savedVariables.scalePing = var
                end,
                width = "half",
                warning = "This scale is applied only on your game. It does not affect how others see pings."
            },
            [2] = {
                type = "slider",
                name = "|cb399ddMarkers|r (permanent) scale:",
                min = 0.1,
                max = 20,
                step = 0.01,
                decimals = 2,
                getFunc = function() return wdsPings.settings.scaleMarker end,
                setFunc = function(var)
                    wdsPings.settings.scaleMarker = var
                    wdsPings.savedVariables.scaleMarker = var
                end,
                width = "half",
                warning = "This scale is applied only on your game. It does not affect how others see pings."
            },
        },
    },
}

function wdsPings.statLAM()
    local LAM = LibAddonMenu2
    wdsPings.panel = LAM:RegisterAddonPanel("wd's Pings", panelData)
    LAM:RegisterOptionControls("wd's Pings", optionsTable)
end

CALLBACK_MANAGER:RegisterCallback("LAM-PanelOpened", function(panel)
    if panel ~= wdsPings.panel then return end
    wdsPings.updateSettingsTable()
end)

function wdsPings.updateSettingsTable()
    if (wdsPings.headerLocked == false) then
        ClearShareSettingsMenuReference.data.name = "" ..
            wdsPings.GetCurrentZoneNameWithColor() ..
            "|r - |cA9DDB1[" .. wdsPings.GetNumberOfPingsInCurrentZone() .. "] MARKERS SAVED|r"
        ClearShareSettingsMenuReference:UpdateValue()
    end
end
