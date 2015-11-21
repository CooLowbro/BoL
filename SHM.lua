--[[

   _____            _                              _______ _    _ __  __ 
  / ____|          | |                            |__   __| |  | |  \/  |
 | |     ___   ___ | |     _____      __  ______     | |  | |__| | \  / |
 | |    / _ \ / _ \| |    / _ \ \ /\ / / |______|    | |  |  __  | |\/| |
 | |___| (_) | (_) | |___| (_) \ V  V /              | |  | |  | | |  | |
  \_____\___/ \___/|______\___/ \_/\_/               |_|  |_|  |_|_|  |_|
                                                                         
                                                                         
--]]
--[[
              TO DO LIST
            • Packets for VIP           [?]
            • Auto Level                [ ]
            • Auto Updater              [X]
            • Lag-Free Circles          [X]
            • Summoner Spells support   [ ]
            • Dont Heal under recall    [ ]
            • Lane-Clear UseQ           [ ]
            • Item usage                [ ]
            • Ward assistant            [ ]
            • KS                        [ ]
--]]
-- Those stuff to be called on the whole script
local myHero = GetMyHero()
local version = "1.01"
local obw_URL = "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua"
local Vpred_URL = "https://raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua"
local Dpred_PATH = LIB_PATH.."DivinePred.lua"
local obw_PATH = LIB_PATH.."SxOrbwalk.lua"
local Vpred_PATH = LIB_PATH.."VPrediction.lua"
local ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 1200)
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/CooLowbro/BoL/master/SHM.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH
local Skills = {
    
  SkillQ = {name = myHero:GetSpellData(_Q).name, range = 970, delay = 0.5, speed = 1500, width = 110},
  
  SkillW = {name = myHero:GetSpellData(_W).name, range = 550, delay = 0.5, speed = 1000, width = 0},
  
  SkillE = {name = myHero:GetSpellData(_E).name, range = 925, delay = 0.5, speed = 2000, width = 25},
  
  SkillR = {name = myHero:GetSpellData(_R).name, delay = 0.5}
}
-- Those stuff to be called on the whole script

--Auto Updater
function _AutoupdaterMsg(msg) 
print("<b><font color=\"#FF0000\">Soraka The Healer Machine:</font></b> <font color=\"#FFFFFF\">"..msg.."</font>") 
end
if AUTOUPDATE then
  local ServerData = GetWebResult(UPDATE_HOST, "/CooLowbro/BoL/master/SHM.version")
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
--Auto Updater

-- Load one time only
function OnLoad()
  if myHero.charName == "Soraka" and tonumber(version) == ServerVersion then
    print("<b><font color=\"#FF0000\">Soraka The Healer Machine v"..version.." loaded!</b></font>")
    OpenMenu()
		initCLF()
    LoadPred()
    Orbwalker()
    return
  elseif myHero.charName ~= "Soraka" then
    print("<b><font color=\"#FF0000\">Sorry, this script is not supported for this champion!</b></font>")
    wilwork = false
    return    
  end
end
-- Load one time only

-- Loop 100x/s
function OnTick()
  if predwillwork == true and obwwillwork == true and tonumber(version) == ServerVersion  then
  Target = GetTarget()
	ckCLF()
  QREADY = (myHero:CanUseSpell(_Q) == READY)
  WREADY = (myHero:CanUseSpell(_W) == READY)
  EREADY = (myHero:CanUseSpell(_E) == READY)
  RREADY = (myHero:CanUseSpell(_R) == READY)
  FightMode()
  HarassMode()
  HealAlly()
  UltAlly()
  UltSelf()
  end
end
-- Loop 100x/s

-- Lag free circles (by barasia, vadash and viseversa)
function initCLF()
  _G.oldDrawCircle = rawget(_G, 'DrawCircle')
  _G.DrawCircle = DrawCircle2
end
function ckCLF()
  if not themenu.draws.LFC.LagFree then _G.DrawCircle = _G.oldDrawCircle end
  if themenu.draws.LFC.LagFree then
    _G.DrawCircle = DrawCircle2
  end
end
function DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
    radius = radius or 300
  quality = math.max(8,round(180/math.deg((math.asin((chordlength/(2*radius)))))))
  quality = 2 * math.pi / quality
  radius = radius*.92
    local points = {}
    for theta = 0, 2 * math.pi + quality, quality do
        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
    end
    DrawLines2(points, width or 1, color or 4294967295)
end
function round(num) 
 if num >= 0 then return math.floor(num+.5) else return math.ceil(num-.5) end
end
function DrawCircle2(x, y, z, radius, color)
    local vPos1 = Vector(x, y, z)
    local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
    local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
    local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
    if OnScreen({ x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
        DrawCircleNextLvl(x, y, z, radius, 1, color, themenu.draws.LFC.CL) 
    end
end
-- Lag free circles (by barasia, vadash and viseversa)

--Draw spells range
function OnDraw()
  if predwillwork == true and obwwillwork == true and tonumber(version) == ServerVersion then
    -- Draw Q
    if themenu.draws.qdraw and not myHero.dead and QREADY then
      DrawCircle(myHero.x, myHero.y, myHero.z, Skills.SkillQ.range, ARGB(255,255,0,0))
    end
  
    --Draw W
    if themenu.draws.wdraw and not myHero.dead and WREADY then
      DrawCircle(myHero.x, myHero.y, myHero.z, Skills.SkillW.range, ARGB(255,102,204,0))
    end
  
    -- Draw E
    if themenu.draws.edraw and not myHero.dead and EREADY then
      DrawCircle(myHero.x, myHero.y, myHero.z, Skills.SkillE.range, ARGB(255,255,0,0))
    end
  end
end
--Draw spells range

-- Target Selector
function GetTarget()
  ts:update()
  if _G.MMA_Target and _G.MMA_Target.type == myHero.type then return _G.MMA_Target end
  if _G.AutoCarry and _G.AutoCarry.Crosshair and _G.AutoCarry.Attack_Crosshair and _G.AutoCarry.Attack_Crosshair.target and _G.AutoCarry.Attack_Crosshair.target.type == myHero.type then return _G.AutoCarry.Attack_Crosshair.target end
  return ts.target
end
-- Target Selector

-- Prediction Stuff
function Vpredck()
    if FileExist(Vpred_PATH) then
        print("<b><font color=\"#6699FF\">VPrediction:</font> <font color=\"#FFFFFF\"> Loading!</b></font>")
        require("VPrediction")
        VP = VPrediction()
        predwillwork = true
        return
      elseif not FileExist(Vpred_PATH) then
        predwillwork = false
        print("<b><font color=\"#FF000\">Downloading Vprediction. Dont press 2xF9! Please wait!</b></font>")
        DownloadFile(Vpred_URL, Vpred_PATH,function() AutoupdaterMsg("<b><font color=\"#FF0000\">Vpred downloaded, please reload (2xF9)</b></font>") end)
      end
end
function Dpredck()
  if FileExist(Dpred_PATH) then
    print("<b><font color=\"#9966CC\">[DivinePrediction]</font> Loading!</b></font>")
    print("<b><font color=\"#9966CC\">[DivinePrediction]</font> Remember: This is a paid prediction!</b></font>")
    print("<b><font color=\"#9966CC\">[DivinePrediction]</font> You must have bought it in order to use!</b></font>")
    require("DivinePred")
    DP = DivinePred()
    predwillwork = true
    return
  elseif not FileExist(Dpred_PATH) then
    predwillwork = false
    print("<b><font color=\"#FF0000\">You need to download DivinePred manually!")
    print("<b><font color=\"#FF0000\">Remember: This is a paid prediction!</b></font>")
    print("<b><font color=\"#FF0000\">You must have bought it in order to use!</b></font>")
    return
  end
end
function CastQ()
if QREADY and ValidTarget(Target) then
  if themenu.predtouse == 1 then
    local CastPosition, HitChance, Enemies = VP:GetCircularAOECastPosition(Target, Skills.SkillQ.delay, Skills.SkillQ.width, Skills.SkillQ.range, Skills.SkillQ.speed, myHero)
    if HitChance >= 2 and Enemies >= 1 then
        --if VIP_USER and themenu.ads.packets then
          --Packet("S_CAST", {spellId = _Q, toX = CastPosition.x, toY = CastPosition.z , fromX = CastPosition.x , fromY = CastPosition.z }):send()
       -- else
          CastSpell(_Q, CastPosition.x, CastPosition.z)
        --end
    end    
  elseif themenu.predtouse == 2 then
    local CircleSS = CircleSS(Skills.SkillQ.speed, Skills.SkillQ.range, Skills.SkillQ.width, (Skills.SkillQ.delay * 1000), math.ruge, 1)
    local ssq = DP:bindSS(myHero:GetSpellData(_Q).name.." ", CircleSS, 75)
    local status, hitPos, perc = DP:predict(myHero:GetSpellData(_Q).name.." ", Target)
    if status == SkillShot.STATUS.SUCCESS_HIT then
      --if VIP_USER and themenu.ads.packets then
       -- Packet("S_CAST", {spellId = _Q, toX = hitPos.x, toY = hitPos.z , fromX = hitPos.x , fromY = hitPos.z }):send()
      --else
        CastSpell(_Q, hitPos.x, hitPos.z)
     -- end
    end
  end
end
end
function CastE()
if EREADY and ValidTarget(Target) then
  if themenu.predtouse == 1 then
    local CastPosition, HitChance, Enemies = VP:GetCircularAOECastPosition(Target, Skills.SkillE.delay, Skills.SkillE.width, Skills.SkillE.range, Skills.SkillE.speed, myHero)
    if HitChance >= 2 and Enemies >= 1 then
      --if VIP_USER and themenu.ads.packets then
        --  Packet("S_CAST", {spellId = _E, toX = CastPosition.x, toY = CastPosition.z , fromX = CastPosition.x , fromY = CastPosition.z }):send()
       -- else
          CastSpell(_E, CastPosition.x, CastPosition.z)
      --  end
    end    
  elseif themenu.predtouse == 2 then
    local CircleSS = CircleSS(Skills.SkillE.speed, Skills.SkillE.range, Skills.SkillE.width, (Skills.SkillE.delay * 1000), math.ruge, 1)
    local ssq = DP:bindSS(myHero:GetSpellData(_E).name.." ", CircleSS, 75)
    local status, hitPos, perc = DP:predict(myHero:GetSpellData(_E).name.." ", Target)
    if status == SkillShot.STATUS.SUCCESS_HIT then
      --if VIP_USER and themenu.ads.packets then
       -- Packet("S_CAST", {spellId = _E, toX = hitPos.x, toY = hitPos.z , fromX = hitPos.x , fromY = hitPos.z }):send()
     -- else
        CastSpell(_E, hitPos.x, hitPos.z)
      --end
    end
  end
end
end
function LoadPred()
  if themenu.predtouse == 1 then
    Vpredck()
  elseif themenu.predtouse == 2 then
    Dpredck()
  end
end
-- Prediction Stuff

-- Orbwalker and Integration Stuff
function Orbwalker()
  print("<b><font color=\"#FF0000\">Checking for external Orbwalkers! Please wait!</b></font>")
  DelayAction(
    function()
      -- MMA      
      if _G.MMA_Loaded ~= nil then
      print("<b><font color=\"#FF0000\">MMA found! Disabling SxOrbWalker!</b></font>")
      themenu.obwc:addParam("mmafd", "MMA FOUND!!", SCRIPT_PARAM_INFO)
      MMA = true
      obwwillwork = true
      -- SAC R
      elseif _G.AutoCarry ~= nil then
      print("<b><font color=\"#FF0000\">SAC:R found! Disabling SxOrbWalker!</b></font>")
      themenu.obwc:addParam("sacfd", "SAC:R FOUND!!", SCRIPT_PARAM_INFO, "")
      SAC = true
      obwwillwork = true
      -- SxOrbWalker
      elseif FileExist(obw_PATH) then
      print("<b><font color=\"#FF0000\">No external orbwalker found! Activating SxOrbWalker!</b></font>")
      require("SxOrbwalk")
      SxOrb:LoadToMenu(themenu.obwc)
      SX = true
      obwwillwork = true
      elseif not FileExist(obw_PATH) then
      obwwillwork = false
      print("<b><font color=\"#FF0000\">Downloading SxOrbWalker. Dont press 2xF9! Please wait!</b></font>")      
      DownloadFile(obw_URL, obw_PATH, function() AutoupdaterMsg("<b><font color=\"#FF0000\">SxOrbWalker downloaded, please reload (2xF9)</b></font>") end)
      return
      end
    end, 10)
end
function LHKey()
  if themenu.hotkeys.checkhk then
    if SX then
      return SxOrb.isLastHit
    elseif SAC then
      return _G.AutoCarry.Keys.LastHit
    elseif MMA then
      return _G.MMA_IsLastHitting()
    end
  else
    return themenu.hotkeys.lasthit
  end
end
function ComboKey()
  if themenu.hotkeys.checkhk then
    if SX then
        return SxOrb.isFight
    elseif SAC then
        return _G.AutoCarry.Keys.AutoCarry
    elseif MMA then
        return _G.MMA_IsOrbwalking()
    end
  else
    return themenu.hotkeys.combo
  end
end
function HarassKey()
  if themenu.hotkeys.checkhk then
    if SX then
        return SxOrb.isHarass
    elseif SAC then
        return _G.AutoCarry.Keys.MixedMode
    elseif MMA then
        return _G.MMA_IsDualCarrying()
    end
  else
    return themenu.hotkeys.harass
  end
end
function LCKey()
  if themenu.hotkeys.checkhk then
    if SX then
        return SxOrb.isLaneClear
    elseif SAC then
        return _G.AutoCarry.Keys.LaneClear
    elseif MMA then
        return _G.MMA_IsLaneClearing()
    end
  else
    return themenu.hotkeys.laneclear
  end
end
-- Orbwalker and Integration Stuff

-- Modes to use the Script
function FightMode()
  if ComboKey() then
    if themenu.combomodepref.useqcombo then
      CastQ()
    end
    if themenu.combomodepref.useecombo then
      CastE()
    end
  end
end
function HarassMode()
  if HarassKey() then
    if themenu.harassmodepref.useqharass then
      CastQ()
    end  
    if themenu.harassmodepref.useeharass then
      CastE()
    end
  end
end
function LastHitMode()
end
function LaneClearMode()
end
-- Modes to use the Script

-- This is where the magic begins: The Healer :)
function HealAlly()
  for _, ally in ipairs(GetAllyHeroes()) do  
    if WREADY and not InFountain() and themenu.heal1[ally.charName] then
      if (ally.health / ally.maxHealth < themenu.heal1[ally.charName.."2"] /100) and (myHero.health / myHero.maxHealth > themenu.heal1.sorakashp /100) then
        if GetDistance(ally, myHero) <= Skills.SkillW.range then
         -- if VIP_USER and themenu.ads.packets then
          --  Packet("S_CAST", {spellId = _W, targetNetworkId = ally.networkID}):send()
          --else
            CastSpell(_W, ally)
          --end
        end
      end
    end
  end
end
function UltAlly()
  for _, ally in ipairs(GetAllyHeroes()) do  
    if RREADY and themenu.heal2[ally.charName] then
      if (ally.health / ally.maxHealth < themenu.heal2[ally.charName.."2"] /100) then
          --if VIP_USER and themenu.ads.packets then
          --  Packet("S_CAST", {spellId = _R, targetNetworkId = ally.networkID}):send()
          --else
            CastSpell(_R, ally)
          --end
      end
    end
  end
end
function UltSelf()
  if RREADY and themenu.heal2.selfult then
    if (myHero.health / myHero.maxHealth < themenu.heal2.selfult2 /100) then
      --if VIP_USER and themenu.ads.packets then
      --  Packet("S_CAST", {spellId = _R, targetNetworkId = myHero.networkID}):send()
      --else
        CastSpell(_R)
      --end
    end
  end
end
-- This is where the magic begins: The Healer :)

-- The Menu
function OpenMenu()
  themenu = scriptConfig("Healer Machine", "mainmenu")
  
  -- Hotkeys
  themenu:addSubMenu("Hotkeys","hotkeys")
  themenu.hotkeys:addParam("checkhk", "Use Orbwalker Hotkeys?", SCRIPT_PARAM_ONOFF, true)
  themenu.hotkeys:setCallback("checkhk",
    function(v)
      if v == false then
        themenu.hotkeys:removeParam("hkcon")
        themenu.hotkeys:removeParam("hkcon")
        themenu.hotkeys:addParam("combo", "Combo Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
        themenu.hotkeys:addParam("harass", "Harass Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
        themenu.hotkeys:addParam("laneclear", "Lane Clear Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
        themenu.hotkeys:addParam("lasthit", "Last Hit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
      elseif v and v == true then
        themenu.hotkeys:addParam("hkcon", "Hotkeys integrated with your Orbwalker", SCRIPT_PARAM_INFO, "")
        themenu.hotkeys:removeParam("combo")
        themenu.hotkeys:removeParam("harass")
        themenu.hotkeys:removeParam("laneclear")
        themenu.hotkeys:removeParam("lasthit")
      end
    end)
  if themenu.hotkeys.checkhk == true then
    themenu.hotkeys:addParam("hkcon", "Hotkeys integrated with your Orbwalker", SCRIPT_PARAM_INFO, "")
  elseif themenu.hotkeys.checkhk == false then
    themenu.hotkeys:addParam("combo", "Combo Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
    themenu.hotkeys:addParam("harass", "Harass Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
    themenu.hotkeys:addParam("laneclear", "Lane Clear Mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
    themenu.hotkeys:addParam("lasthit", "Last Hit", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
  end
  --themenu.hotkeys:addParam("humanizer1", "Humanizer Combo/Harass", SCRIPT_PARAM_SLICE, 1, 0, 150, 0)]]
  
  -- Combo Mode Preferences
  themenu:addSubMenu("Combo Mode","combomodepref")
  themenu.combomodepref:addParam("useqcombo", "Use Q", SCRIPT_PARAM_ONOFF, true)
  themenu.combomodepref:addParam("useecombo", "Use E", SCRIPT_PARAM_ONOFF, true)
  
  -- Harass Mode Preferences
  themenu:addSubMenu("Harass Mode","harassmodepref")
  themenu.harassmodepref:addParam("useqharass", "Use Q", SCRIPT_PARAM_ONOFF, true)
  themenu.harassmodepref:addParam("useeharass", "Use E", SCRIPT_PARAM_ONOFF, false)
  
  -- Lane Clear Preferences
  themenu:addSubMenu("Lane Clear","laneclearpref")
  --themenu.laneclearpref:addParam("useqcombo", "Use Q", SCRIPT_PARAM_ONOFF, true)
  
  -- Heal W
  themenu:addSubMenu("Heal W","heal1") 
  themenu.heal1:addParam("wglobal", "Global Config ON/OFF", SCRIPT_PARAM_ONOFF, false)

  for _, ally in ipairs(GetAllyHeroes()) do
    themenu.heal1:addParam(tostring(ally.charName), "Heal "..tostring(ally.charName).." ON/OFF", SCRIPT_PARAM_ONOFF, true)
  end
  for _, ally in ipairs(GetAllyHeroes()) do
    themenu.heal1:addParam(tostring(ally.charName).."2", "Heal "..tostring(ally.charName).."<= %HP", SCRIPT_PARAM_SLICE, 80, 1, 100, 0) 
  end
  themenu.heal1:addParam("sorakashp", "Minimum HP to Heal", SCRIPT_PARAM_SLICE, 15, 1, 100, 0)
  --themenu.heal1:addParam("humanizer2", "Healer Humanizer", SCRIPT_PARAM_SLICE, 0, 0, 150, 0)

  -- Heal R
  themenu:addSubMenu("Heal R","heal2")
  for _, ally in ipairs(GetAllyHeroes()) do
  themenu.heal2:addParam(tostring(ally.charName).."ult", "Ult "..tostring(ally.charName).." ON/OFF", SCRIPT_PARAM_ONOFF, true) end
  for _, ally in ipairs(GetAllyHeroes()) do
  themenu.heal2:addParam(tostring(ally.charName).."ult2", "Ult "..tostring(ally.charName).."<= %HP", SCRIPT_PARAM_SLICE, 80, 1, 100, 0) end
  themenu.heal2:addParam("selfult", "Ult on yourself ON/OFF", SCRIPT_PARAM_ONOFF, true)
  themenu.heal2:addParam("selfult2", "Ult on yourself <= %HP", SCRIPT_PARAM_SLICE, 20, 1, 100, 0)
  
  -- Draws
  themenu:addSubMenu("Draws","draws")
  themenu.draws:addSubMenu("Lag-Free Circles", "LFC")
  themenu.draws.LFC:addParam("LagFree", "Activate Lag Free Circles", 1, true)
  themenu.draws.LFC:addParam("CL", "Length before snapping", 4, 300, 75, 2000, 0)
  themenu.draws.LFC:addParam("CLinfo", "The lower your length the better system you need", 5, "")
  themenu.draws.LFC:addParam("credits", "Lag free circles (by barasia, vadash and viseversa)", SCRIPT_PARAM_INFO, "")
  themenu.draws:addParam("qdraw", "(Q) Starcall ON/OFF", SCRIPT_PARAM_ONOFF, true)
  themenu.draws:addParam("wdraw", "(W) Astral Infusion ON/OFF", SCRIPT_PARAM_ONOFF, false)
  themenu.draws:addParam("edraw", "(E) Equinox ON/OFF", SCRIPT_PARAM_ONOFF, true)
  
  --Others info
  --themenu:addSubMenu("Additional Settings", "ads")
  --if VIP_USER then
  --themenu.ads:addParam("packets", "Spell Packet Usage", SCRIPT_PARAM_ONOFF, true)
  --else
  --themenu:addParam("packets", "Packets usage are only for VIP Members!!", SCRIPT_PARAM_INFO, "")
  --end
    
  -- Orbwalker
  themenu:addSubMenu("Orbwalker","obwc")

  -- Prediction for the spells
  themenu:addParam("predtouse","Prediction to use:", SCRIPT_PARAM_LIST, 1, {'VPrediction', 'DivinePred'})
  themenu:setCallback("predtouse",
    function(v)
    if v == 1 then
    Vpredck()  
    elseif v == 2 then
    Dpredck()  
    end
    end)
  

  -- Info
  themenu:addParam("info1", "Version Info: ", SCRIPT_PARAM_INFO, version)
end
-- The Menu
