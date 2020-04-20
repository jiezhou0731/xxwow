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
		if not weapon2 then
			if string.len(SunDaTonConfig.DZ.SecondaryPoison)>0 
				and SunDaTon_CheckBag(SunDaTonConfig.DZ.SecondaryPoison) then
				SunDaTon_EditMacro(SunDaTon_MacroAction,string.format(SunDaTon_MacroDZSecondaryPoison, SunDaTonConfig.DZ.SecondaryPoison))
				return
			end
		end
	end
	for i=1,#SunDaTonConfig.BUFF.BuffList,1 do
		if string.len(SunDaTonConfig.BUFF.BuffList[i])>0 and SunDaTon_CheckBuff(SunDaTonConfig.BUFF.BuffList[i]) then
			if string.len(SunDaTonConfig.BUFF.SkillList[i])>0 
				and SunDaTon_CheckBag(SunDaTonConfig.BUFF.SkillList[i]) then
				SunDaTon_EditMacro(SunDaTon_MacroAction,SunDaTon_MacroStandUp .. SunDaTonConfig.BUFF.SkillList[i])
				return
			elseif string.len(SunDaTonConfig.BUFF.SkillList[i])>0 
				and IsUsableSpell(SunDaTonConfig.BUFF.SkillList[i]) then 
				SunDaTon_EditMacro(SunDaTon_MacroAction,SunDaTon_MacroStandUp .. SunDaTonConfig.BUFF.SkillList[i])
				return
			end
		end
	end
	if SunDaTon_CheckHealth(SunDaTonConfig.Restore.HealthPrecentage) and SunDaTon_CheckBuff("进食") then
		local local_macro = SunDaTon_MacroAction,SunDaTon_MacroActionStart .. "\n/sit\n"
		for i=1,#SunDaTonConfig.Restore.HealthList,1 do
			if string.len(SunDaTonConfig.Restore.HealthList[i])>0 
			and SunDaTon_CheckBag(SunDaTonConfig.Restore.HealthList[i]) then
				SunDaTon_EditMacro(SunDaTon_MacroAction,local_macro  ..SunDaTonConfig.Restore.HealthList[i])
				return
			elseif string.len(SunDaTonConfig.Restore.HealthList[i])>0
			and IsUsableSpell(SunDaTonConfig.Restore.HealthList[i]) then 
				SunDaTon_EditMacro(SunDaTon_MacroAction,local_macro .. SunDaTonConfig.Restore.HealthList[i])	
				return
			end
		end	
		SunDaTon_EditMacro(SunDaTon_MacroAction,"")
		return
	end
	if not SunDaTon_CheckBuff("进食") and SunDaTon_CheckHealth(99) then
		SunDaTon_EditMacro(SunDaTon_MacroAction,"")
		return
	end
	SunDaTon_EditMacro(SunDaTon_MacroAction, SunDaTonConfig.Target.Macro)
end