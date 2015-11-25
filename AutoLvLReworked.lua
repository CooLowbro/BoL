local abilitySequence
local ini=false
local _autoLevel = { spellsSlots = { SPELL_1, SPELL_2, SPELL_3, SPELL_4 }, levelSequence = {}, nextUpdate = 0, tickUpdate = 5 }
local __autoLevel__OnTick
local rOFF=0
--update func--
local version = "1.02"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/CooLowbro/BoL/master/AutoLvLReworked.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

function _AutoupdaterMsg(msg) 
print("<b><font color=\"#FF0000\">Tyler1 Auto Level Spells</font></b><b><font color=\"#33EE33\"> Reworked by CooLow:</font></b> <font color=\"#FFFFFF\">"..msg.."</font>") 
end

if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/CooLowbro/BoL/master/AutoLvLReworked.version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(version) < ServerVersion then
				_AutoupdaterMsg("New version available "..ServerVersion)
				_AutoupdaterMsg("Updating, please don't press F9")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () _AutoupdaterMsg("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
			else
				_AutoupdaterMsg("You have got the latest version ("..ServerVersion..")")
			end
		end
	else
		_AutoupdaterMsg("Error downloading version info")
	end
end
--end updt


function OnTick()
	if tonumber(version) == ServerVersion then
		Start()
		if ini then
			AutoLevel()
		end
	end
end

function Start()
	if Menu.start then
		if player.charName == "Jayce" then CarryRoff()
		else CarryRon() 
		end	
	end
end

function AutoLevel()
	autoLevelSetSequenceCustom(abilitySequence)
end

 function CarryRon()
    local sequence1, sequence2 = Menu.sequenceSpells, Menu.sequenceSpells2
		  ini = true
if sequence1 == 1 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
                           
elseif sequence1 == 2 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
                           
elseif sequence1 == 3 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
                           
elseif sequence1 == 4 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
                           
elseif sequence1 == 5 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
                           
elseif sequence1 == 6 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 5 then abilitySequence = { 3, 2, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
end
end

 function CarryRoff()
    local sequence1, sequence2 = Menu.sequenceSpells, Menu.sequenceSpells2
		  ini = true
 if sequence1 == 1 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
elseif sequence1 == 1 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3, }
                           
elseif sequence1 == 2 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
elseif sequence1 == 2 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2, }
                           
elseif sequence1 == 3 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
elseif sequence1 == 3 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3, }
                           
elseif sequence1 == 4 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
elseif sequence1 == 4 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1, }
                           
elseif sequence1 == 5 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 5 then abilitySequence = { 3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
elseif sequence1 == 5 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1, }
                           
elseif sequence1 == 6 and sequence2 == 1 then abilitySequence = { 1, 2, 3, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 2 then abilitySequence = { 1, 3, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 3 then abilitySequence = { 2, 1, 3, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 4 then abilitySequence = { 2, 3, 1, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 5 then abilitySequence = { 3, 2, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
elseif sequence1 == 6 and sequence2 == 6 then abilitySequence = { 3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2, }
end
end

local function autoLevel__OnLoad()
    if not __autoLevel__OnTick then
        function __autoLevel__OnTick()
            local tick = os.clock()
            if _autoLevel.nextUpdate > tick then return end
            _autoLevel.nextUpdate = tick + Menu.DelayTime
            local realLevel = rOFF + GetHeroLeveled()
            if player.level > realLevel and _autoLevel.levelSequence[realLevel + 1] ~= nil then
                local splell = _autoLevel.levelSequence[realLevel + 1]
                if splell == 0 and type(_autoLevel.onChoiceFunction) == "function" then splell = _autoLevel.onChoiceFunction() end
                if type(splell) == "number" and splell >= 1 and splell <= 4 then LevelSpell(_autoLevel.spellsSlots[splell]) end
            end
        end

        AddTickCallback(__autoLevel__OnTick)
    end
end

function autoLevelSetSequenceCustom(sequence1, sequence2)
    assert(sequence1, sequence2 == nil or type(sequence1, sequence2) == "table", "autoLevelSetSequence : wrong argument types (<table> or nil expected)")
    autoLevel__OnLoad()
    local sequence1, sequence2 = sequence1, sequence2 or {}
    for i = 1, 18 do
        local spell = sequence1[i], sequence2[i]
        if type(spell) == "number" and spell >= 0 and spell <= 4 then
            _autoLevel.levelSequence[i] = spell
       -- else
     --       _autoLevel.levelSequence[i] = nil
        end
    end
end

function RLoad()
	if player.charName == "Jayce" 
	or player.charName == "Elise" 
	or player.charName == "Karma" 
	or player.charName == "Nidalee" then
		rOFF=-1
	else
		rOFF=0
	end
end

function OnLoad()
	if tonumber(version) == ServerVersion then
	print("<b><font color=\"#FF0000\">Tyler1 Auto Level Spells</font></b><b><font color=\"#33EE33\"> Reworked by CooLow:</font></b> <font color=\"#FFFFFF\">Loading v</font>"..version)
	Menu = scriptConfig("["..myHero.charName.." - AutoLevel]", player.charName.."AutoLevel")
	Menu:addParam("sep1", "1 - Change for Humanizer "..myHero.charName, SCRIPT_PARAM_INFO, "")
	Menu:addParam("DelayTime", "Humanizer Time", SCRIPT_PARAM_SLICE, 1, 1, 60, 0)
	Menu:addParam("sep2", "2 - Define Sequence for "..myHero.charName, SCRIPT_PARAM_INFO, "")
	Menu:addParam("sequenceSpells2", "First 3", SCRIPT_PARAM_LIST, 1, { 'Q-W-E', 'Q-E-W', 'W-Q-E', 'W-E-Q', 'E-W-Q', 'E-Q-W' })
	Menu:addParam("sequenceSpells", "Sequence Spells", SCRIPT_PARAM_LIST, 1, { 'R-Q-W-E', 'R-Q-E-W', 'R-W-Q-E', 'R-W-E-Q', 'R-E-W-Q', 'R-E-Q-W' })
	Menu:addParam("sep3", "3 - for load Script... ", SCRIPT_PARAM_INFO, "")
	Menu:addParam("start", "Just Press Key ", SCRIPT_PARAM_ONKEYDOWN, false, 76)
	Menu:addParam("sep4", "Version Info: ", SCRIPT_PARAM_INFO, version)
	
	RLoad()
	print("<b><font color=\"#FF0000\">Tyler1 Auto Level Spells</font></b><b><font color=\"#33EE33\"> Reworked by CooLow:</font></b> <font color=\"#FFFFFF\">Sucessfully Loaded!</font>")
end end

_G.LevelSpell = function(id)
  local offsets = { 
    [_Q] = 0x61,
    [_W] = 0x81,
    [_E] = 0xA1,
    [_R] = 0xC1,
  }
  local p = CLoLPacket(0x0033)
  p.vTable = 0xE556E8
  p:EncodeF(myHero.networkID)
  p:Encode1(0x73)
  for i = 1, 4 do p:Encode1(0xF9) end
  for i = 1, 4 do p:Encode1(0x1E) end
  p:Encode1(offsets[id])
  for i = 1, 4 do p:Encode1(0x99) end
  for i = 1, 4 do p:Encode1(0x00) end
  SendPacket(p)
end
