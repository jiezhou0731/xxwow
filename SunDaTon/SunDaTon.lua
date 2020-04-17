local function SunDaTon_CheckMacro()
	--SunDaTon_EditMacro(SunDaTon_MacroStart, SunDaTon_MacroStart_body)
	SunDaTon_EditMacro(SunDaTon_MacroAction,"")
	SunDaTon_EditMacro(SunDaTon_MacroAttack, "")
	if SunDaTonConfig.Other.EnableBangke
		and string.len(SunDaTonConfig.Other.BangkeName) > 0 then
		SunDaTon_MacroStart_body=string.format(SunDaTon_MacroBangke, SunDaTonConfig.Other.BangkeName)
	else
		SunDaTon_MacroStart_body="/sdt check"
	end
	SunDaTon_EditMacro(SunDaTon_MacroStart, SunDaTon_MacroStart_body)
	-- SunDaTon_CheckMacro
end

local function SunDaTon_OnInitial()
	local lc,ec,cindex = UnitClass("player")
	SunDaTon_Player_level = UnitLevel("player")
	SunDaTon_Player_Class = cindex
	local loaded, reason = LoadAddOn(SUNDATON_CONFIG_TITLE .. "_" ..SunDaTon_UnitClassSample(cindex))
	if not loaded then
		SunDaTon_Log(SUNDATON_TIPS_LOADING_ERROR .. reason)
	else
		SunDaTon_Player:OnInitial()
	end
	--SunDaTon_OnInitial
end

local function SunDaTon_OnDestory()

	--SunDaTon_OnDestory
end

local function SunDaTon_Check()
	if SunDaTon_Player then
		SunDaTon_Player:Check()
	else
		SunDaTon_Log(SUNDATON_TIPS_NO_PROFILE)
	end
end

local function SunDaTon_OnEvent(self, event, addon)
	if event == "PLAYER_LOGIN" then
		SunDaTon_CheckMacro()
	elseif event=="PLAYER_ENTERING_WORLD" then
		SunDaTon_InitialData()
		SunDaTon_OnInitial()
	elseif event=="PLAYER_LEAVING_WORLD" then
		SunDaTon_OnDestory()
	elseif event=="PLAYER_REGEN_ENABLED" then
		SunDaTon_Leave_Combat_Time=GetTime()
		SunDaTon_EditMacro(SunDaTon_MacroAction,"")
	elseif event=="BAG_UPDATE" then
		if SunDaTonConfig.Rubbish.Enable and addon>=0 then
			SunDaTon_AutoRubbish()
		end
	end
	--SunDaTon_OnEvent
end

local function SunDaTon_SlashCmd(msg)
	msg = string.lower(msg)
	if msg==nil or string.len(msg)==0 then
		SunDaTonConfigShow()
	elseif msg == "check" and not UnitAffectingCombat("player") then
		if GetTime()-SunDaTon_Leave_Combat_Time>SunDaTonConfig.Other.CombatDelay then
			SunDaTon_Check()
		end
	elseif msg == "config" then
		SunDaTonConfigShow()
	end
	--SunDaTon_SlashCmd	
end

SLASH_SUNDATON1 = "/sdt"
SLASH_SUNDATON2 = "/sundaton"
SlashCmdList["SUNDATON"] = function(msg)
   SunDaTon_SlashCmd(msg)
end

SunDaTon = CreateFrame("Frame")
SunDaTon:RegisterEvent("PLAYER_LOGIN")
SunDaTon:RegisterEvent("PLAYER_ENTERING_WORLD")
SunDaTon:RegisterEvent("PLAYER_LEAVING_WORLD")
SunDaTon:RegisterEvent("PLAYER_REGEN_ENABLED")
SunDaTon:RegisterEvent("BAG_UPDATE")
SunDaTon:SetScript("OnEvent", function(self, event, addon)
	SunDaTon_OnEvent(self, event, addon)
end)
SunDaTon:SetScript("OnUpdate", function(self) 
	if UnitAffectingCombat("player")  and SunDaTonConfig.Other.Combat_State~=1 then 
		SunDaTonConfig.Other.Combat_State = 1 
		SunDaTonConfig_SaveAttack()
	end
	if not UnitAffectingCombat("player") and SunDaTonConfig.Other.Combat_State~=0 then
		SunDaTonConfig.Other.Combat_State = 0
		SunDaTonConfig_SaveAttack()
	end
end)
