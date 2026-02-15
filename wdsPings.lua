---@diagnostic disable: trailing-space
wdsPings = {}
wdsPings.name = "wdsPings"
wdsPings.ImportString = ""
wdsPings.SenderPosition = {}

--Export to elms
--add option to choose sound
--detect when player is standing still and auto share pings
--delete ping close to where youre looking and share that deleted ping
--shapes?
--animations
--  -none
--  -pulse
--  -up and down
--  -flash color


function wdsPings:OnIncomingPing(tag, data)
  --decode
  local x, y, z, texture, type = data.encoded:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")

  x = x * 10
  y = y * 10
  z = z * 10

  --ignore self pings
  if (GetGroupIndexByUnitTag("player") == GetGroupIndexByUnitTag(tag)) then
    return
  end

  --only accept ping if zoneid matches the sender or is permanent
  local zoneidSender, _, _, _ = GetUnitRawWorldPosition(tag)
  local zoneidReceiver, _, _, _ = GetUnitRawWorldPosition("player")
  if (zoneidSender == zoneidReceiver or type ~= "p") then
    wdsPings.placePing(x, y, z, wdsPings.textures[tonumber(texture)], type, zoneidSender)
  else
  end
end

function wdsPings.sendData(x, y, z, texture, type)
  local string = x .. "," .. y .. "," .. z .. "," .. wdsPings.getTextureIdFromString(texture) .. "," .. type
  wdsPings.protocol:Send({
    encoded = string,
  });
end

function wdsPings.InitLibGroupBroadcast()
  if not LibGroupBroadcast then return end
  local LGB = LibGroupBroadcast


  wdsPings.handler = LGB:RegisterHandler("wdsPings")
  wdsPings.handler:SetDisplayName("wd's pings stuff")
  wdsPings.handler:SetDescription("Shares pings and markers.")

  wdsPings.protocol = wdsPings.handler:DeclareProtocol(167, "wdsPings")

  wdsPings.protocol:AddField(LGB.CreateStringField("encoded"))
  wdsPings.protocol:OnData(function(...) wdsPings:OnIncomingPing(...) end)

  wdsPings.protocol:Finalize({
    isRelevantInCombat = true,
    replaceQueuedMessages = false
  })
end

function wdsPings.Initialize()
  EVENT_MANAGER:UnregisterForEvent(wdsPings.name, EVENT_ADD_ON_LOADED)

  --libGroupBroadcast
  wdsPings.InitLibGroupBroadcast()

  wdsPings.submenuLocked = false
  wdsPings.headerLocked = false
  wdsPings.headerString = ""
  wdsPings.array = {}

  wdsPings.defaultSavedVariables =
  {
    pingIconTemp = "wdsPings/icons/default_ping.dds",
    pingIconPerm = "wdsPings/icons/default_ping_purple.dds",
    showTempDungeons = "Everyone",
    showTempTrials = "Everyone",
    showPermDungeons = "Everyone",
    showPermTrials = "Group Leader Only",
    scalePing = 8,
    scaleMarker = 8,
    savedPings = {},
    ESS = false
  }

  wdsPings.savedVariables = ZO_SavedVars:NewAccountWide("wdsPingsVariables", 23, nil, wdsPings.defaultSavedVariables,
    GetWorldName())

  local fakePing = {}

  fakePing[1] = {
    [1] = 11,
    [2] = 11,
    [3] = 11,
    [4] = "wdsPings/icons/default_ping.dds",
  }
  fakePing[2] = {
    [1] = 11,
    [2] = 11,
    [3] = 11,
    [4] = "wdsPings/icons/default_ping.dds",
  }

  wdsPings.savedVariables.savedPings[363] = fakePing

  wdsPings.settings =
  {
    pingIconTemp = wdsPings.savedVariables.pingIconTemp,
    pingIconPerm = wdsPings.savedVariables.pingIconPerm,
    showTempDungeons = wdsPings.savedVariables.showTempDungeons,
    showTempTrials = wdsPings.savedVariables.showTempTrials,
    showPermDungeons = wdsPings.savedVariables.showPermDungeons,
    showPermTrials = wdsPings.savedVariables.showPermTrials,
    scalePing = wdsPings.savedVariables.scalePing,
    scaleMarker = wdsPings.savedVariables.scaleMarker,
    savedPings = wdsPings.savedVariables.savedPings

    --wdsPings.savedVariables.savedPings[zoneid][pingIndex][x/y/z][texture]
  }

  wdsPings.optionsTable = {}

  SLASH_COMMANDS["/wd"] = wdsPings.SlashCommand

  --starts LAM so that message doesnt show in chat??? unsure why that is but this fixes it
  wdsPings.statLAM()
end

function wdsPings.SlashCommand(input)
  local LAM = LibAddonMenu2
  input = string.lower(input)
  local command = input:match("%w+")
  if (command == nil) then
    LAM:OpenToPanel(wdsPings.panel)
    return
  end
  local rest = input.sub(input, string.len(command) + 2, 100)

  if (command == "debug") then
  end

  if (command == "debug2") then

  end

  if (command == "debug3") then

  end

  if (command == "clear" or command == "2" or command == "c" or command == "remove" or command == "x") then
    wdsPings.ClearSavedMarkers()
    return
  end

  if (command == "clearclose" or command == "cc" or command == "removeclose") then
    if (IsUnitGroupLeader('player') == false) then
      d("|cEAC8E9[wd's pings] |cee5555[!] group leader is required to clear everyone's pings [!]")
      return
    end
    wdsPings.ClearClosestMarker()
    return
  end

  if (command == "t" or command == "p" or command == "temp" or command == "temporary") then
    wdsPings.CreatePingOrMarker("p")
    return
  end

  if (command == "p" or command == "perm" or command == "permanent") then
    wdsPings.CreatePingOrMarker("marker")
    return
  end

  if (command == "s" or command == "share") then
    wdsPings.ShareMarkers()
  end

  if (command == "pos") then
    d(GetUnitRawWorldPosition("player"))
  end
end

function wdsPings.UpdatePingsAnim(icon)
  if (false) then
    if (icon.counter == nil) then
      icon.counter = 300
      icon.direction = "down"
    end

    if (icon.counter < 80) then
      icon.direction = "stop"
    end

    if (icon.direction == "down") then
      icon.counter = icon.counter - 3
      --icon.data.texture = "wdsPings/icons/Arrow_aqua.dds"
    end

    icon.data.size = icon.counter
    --icon.data.color = {math.random(), math.random(), math.random()}
  end
end

function wdsPings.getTextureIdFromString(textureString)
  for i = 1, #wdsPings.textures do
    if (textureString == wdsPings.textures[i]) then
      return i
    end
  end
end

function wdsPings.placePing(x, y, z, texture, type, zoneid)
  --saves icon returned by OSI in array so i have my own version of the pings collection
  local iconOSI = OSI.CreatePositionIcon(x, y, z, texture, wdsPings.settings.scalePing * 10, OSI.BASECOLOR, 0, callback)
  wdsPings.array[#wdsPings.array + 1] = iconOSI
  iconOSI.counter = nil

  --todo ping animations
  --iconOSI.callback = function() wdsPings.UpdatePingsAnim(iconOSI) end

  --attempt to save marker, if overlapping return
  if (type ~= "p") then
    local overlapping = wdsPings.attemptSaveMarker(x, y, z, zoneid, texture)
    if (overlapping == true) then
      return
    end
  end

  --if ping then delete after 3500ms
  --TODO: CHANGE 3500 TO SOMETHING CONFIGURABLE
  if (type == "p") then
    zo_callLater(
      function()
        OSI.DiscardPositionIcon(iconOSI)
        --remove from array, should prob change the name at some point (edit 2 weeks later: i will not)
        for i = 1, #wdsPings.array do
          if (wdsPings.array[i] == iconOSI) then
            table.remove(wdsPings.array, i)
          end
        end
      end, 3500)
  end
end

function wdsPings.CreatePingOrMarker(type)
  local zoneid, x, y, z = GetUnitRawWorldPosition("player")

  local cameraHeading = GetPlayerCameraHeading() - math.pi
  local xsin = math.sin(cameraHeading)
  local zcos = math.cos(cameraHeading)

  --TODO check if i can get if its positive angle or negative compared to horizon
  local uX, uY, uZ = OSI.ctrl:Get3DRenderSpaceUp()
  local angle = uY

  --TOOD there's probably some math way to do this but i had to hard code because i dont know math
  --max range: 5000
  local value = "500"
  if true then
    if angle > 0.999 and angle < 0.9995 then
      value = "400"
    end
    if angle > 0.9985 and angle < 0.999 then
      value = "350"
    end
    if angle > 0.998 and angle < 0.9985 then
      value = "315"
    end
    if angle > 0.996 and angle < 0.998 then
      value = "280"
    end
    if angle > 0.993 and angle < 0.996 then
      value = "240"
    end
    if angle > 0.99 and angle < 0.993 then
      value = "200"
    end
    if angle > 0.987 and angle < 0.99 then
      value = "170"
    end
    if angle > 0.985 and angle < 0.987 then
      value = "150"
    end
    if angle > 0.983 and angle < 0.985 then
      value = "135"
    end
    if angle > 0.98 and angle < 0.983 then
      value = "120"
    end
    if angle > 0.97 and angle < 0.98 then
      value = "100"
    end
    if angle > 0.96 and angle < 0.97 then
      value = "085"
    end
    if angle > 0.94 and angle < 0.96 then
      value = "075"
    end
    if angle > 0.93 and angle < 0.94 then
      value = "065"
    end
    if angle > 0.92 and angle < 0.93 then
      value = "057"
    end
    if angle > 0.90 and angle < 0.92 then
      value = "050"
    end
    if angle > 0.85 and angle < 0.90 then
      value = "045"
    end
    if angle > 0.80 and angle < 0.85 then
      value = "038"
    end
    if angle > 0.75 and angle < 0.80 then
      value = "032"
    end
    if angle > 0.70 and angle < 0.75 then
      value = "028"
    end
    if angle > 0.6 and angle < 0.7 then
      value = "020"
    end
    if angle > 0.5 and angle < 0.6 then
      value = "018"
    end
    if angle > 0.4 and angle < 0.5 then
      value = "014"
    end
    if angle > 0.3 and angle < 0.4 then
      value = "011"
    end
    if angle > 0.2 and angle < 0.3 then
      value = "007"
    end
    if angle > 0.1 and angle < 0.2 then
      value = "005"
    end
    if angle > 0.0 and angle < 0.1 then
      value = "000"
    end
  end

  --slightly more accurate rotation than sending raw radians
  local radiansPercentage = math.abs(cameraHeading) * 100 / math.pi
  radiansPercentage = string.sub(radiansPercentage, 1, 2)

  --adds a 0 if radiansPercentage is single digit so data string stays consistent in size
  if (tonumber(radiansPercentage) < 10) then
    radiansPercentage = "0" .. radiansPercentage
  end

  -- [deprecated] old encoding system
  -- MAX VALUE 62331613569
  -- Example:  10099120063
  -- 1        00          99         120       0       63
  -- LENGTH   future?     ICON       VALUE     SIGN    RADIANSPERCENTAGE

  local texture
  if (type == "p") then
    texture = wdsPings.settings.pingIconTemp
  else
    texture = wdsPings.settings.pingIconPerm
  end

  local valueFinal = tonumber(value) * 10

  x = x + (xsin * tonumber(valueFinal))
  z = z + (zcos * tonumber(valueFinal))

  --place ping local
  wdsPings.placePing(x, y, z, texture, type, zoneid)

  x = x / 10
  x = math.floor(x)

  z = z / 10
  z = math.floor(z)

  y = y / 10
  y = math.floor(y)

  --share ping to group
  wdsPings.sendData(x .. "", y .. "", z .. "", texture, type)




  --TODO PLAY AROUND WITH THIS
  local callback = nil
end

function wdsPings.OnAddOnLoaded(event, addonName)
  if addonName == wdsPings.name then
    EVENT_MANAGER:UnregisterForEvent(wdsPings.name, EVENT_ADD_ON_LOADED)

    wdsPings.Initialize()
  end
end

ZO_CreateStringId("SI_BINDING_NAME_PING_TEMP", "Temporary Ping")
ZO_CreateStringId("SI_BINDING_NAME_PING_PERM", "Permanent Ping")
ZO_CreateStringId("SI_BINDING_NAME_CLEAR_PINGS", "Clear Pings")
ZO_CreateStringId("SI_BINDING_NAME_CLEAR_PINGS_ALL", "Clear Pings for Everyone")


EVENT_MANAGER:RegisterForEvent(wdsPings.name, EVENT_ADD_ON_LOADED, wdsPings.OnAddOnLoaded)
