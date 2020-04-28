local Player={}

SunDaTon_Player = Player

function Player:OnInitial()
	SunDaTon_Log(SUNDATON_TIPS_LOADING_PROFILE..":潜行者")
	SunDaTon_EditMacro(SunDaTon_MacroStart, SunDaTon_MacroStart_body)
	SunDaTon_EditMacro(SunDaTon_MacroAction,"")
	SunDaTon_EditMacro(SunDaTon_MacroAttack, SunDaTonConfig.Attack.Macro)
	-- init data
	local DZ=SunDaTonConfig["DZ"]
	if DZ==nil then
		DZ={}
		SunDaTonConfig["DZ"]=DZ
	end
	if DZ["AutoPoison"]==nil then
		DZ["AutoPoison"]=false
	end
	if DZ["MainPoison"]==nil then
		DZ["MainPoison"]=""
	end
	if DZ["SecondaryPoison"]==nil then
		DZ["SecondaryPoison"]=""
	end
end

function Player:Check()
	local i
	if SunDaTonConfig.DZ.AutoPoison then
		local weapon1, arg1, arg2, arg3, weapon2, arg4, arg5, arg6 = GetWeaponEnchantInfo()
		if not weapon1 then
			if string.len(SunDaTonConfig.DZ.MainPoison)>0 
				and SunDaTon_CheckBag(SunDaTonConfig.DZ.MainPoison) then
				SunDaTon_EditMacro(SunDaTon_MacroAction,string.format(SunDaTon_MacroDZMainPoison, SunDaTonConfig.DZ.MainPoison))
				return
			end
		end

		local offHandLink = GetInventoryItemLink("player",17)
		local _, _, _, _, _, _, itemType = GetItemInfo(offHandLink)
		local itemTypeSt = "" .. itemType
		if not weapon2 and itemTypeSt ~= "Miscellaneous" then
			DEFAULT_CHAT_FRAME:AddMessage("in", 1.0, 1.0, 0.0);
			if string.len(SunDaTonConfig.DZ.SecondaryPoison)>0 
				and SunDaTon_CheckBag(SunDaTonConfig.DZ.SecondaryPoison) then
				SunDaTon_EditMacro(SunDaTon_MacroAction,string.format(SunDaTon_MacroDZSecondaryPoison, SunDaTonConfig.DZ.SecondaryPoison))
				return
			end
		end
	end

	local Regen = "/stopmacro [combat]\n/equipslot 17 Darkmist Orb of Spirit\n/cast [nocombat,stance:0] stealth\n/sit\n/stopmacro [stance:0]\n"
	if SunDaTon_CheckHealth(70) then
		Regen = Regen .. Jie_Regen_Equip
		SunDaTon_EditMacro(SunDaTon_MacroAction,Regen)
		return
	end
	if SunDaTon_GetHealth() > 85 and SunDaTon_GetHealth() < 99 then
		Regen = Regen .. Jie_Fight_Equip
		SunDaTon_EditMacro(SunDaTon_MacroAction,Regen)
		return
	end
	if SunDaTon_GetHealth() == 100 then
		SunDaTon_EditMacro(SunDaTon_MacroAction, SunDaTonConfig.Target.Macro)
		return
	end
	SunDaTon_EditMacro(SunDaTon_MacroAction, Regen)
end
