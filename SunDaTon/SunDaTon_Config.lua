local SunDaTon_CurrentPanel=nil

function SunDaTonConfigShow()
	SunDaTonConfigFrame:Show()
	if SunDaTon_Player_Class==3 then
		SunDaTonConfigLRButton:Show()
	elseif SunDaTon_Player_Class==4 then
		SunDaTonConfigDZButton:Show()
	elseif SunDaTon_Player_Class==7 then
		SunDaTonConfigSMButton:Show()
	elseif SunDaTon_Player_Class==9 then
		SunDaTonConfigSSButton:Show()
	elseif SunDaTon_Player_Class==11 then
		SunDaTonConfigXDButton:Show()
	end
	--SunDaTonConfigShow
end

function SunDaTonConfigClose()
	SunDaTonConfigFrame:Hide()
	--SunDaTonConfigClose
end

function SunDaTon_Config_LoadSlider(self,vText,Min,Max,Step,pageStep)
    self.text = vText;
    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
    g=_G[self:GetName().."Low"]
    g:SetText(Min);
    g=_G[self:GetName().."High"]
    g:SetText(Max);
    self:SetMinMaxValues(Min,Max);
    self:SetValueStep(Step);
    self:SetStepsPerPage(pageStep);
	--SunDaTon_Config_LoadSlider
end

-- target event start
function SunDaTon_ShowTargetPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigTargetSettingsPanel
	SunDaTonConfigTargetSettingsPanel:Show()
	-- initial UI
	SunDaTonConfigTargetenemy:SetChecked(SunDaTonConfig.Target.isTargetEnemy)
	SunDaTonConfigSkinning:SetChecked(SunDaTonConfig.Target.IsSkinning)
	SunDaTonConfigPetTarget:SetChecked(SunDaTonConfig.Target.PetTarget)
	SunDaTonConfigTarget1:SetText(SunDaTonConfig.Target.TargetList[1])
	SunDaTonConfigTarget2:SetText(SunDaTonConfig.Target.TargetList[2])
	SunDaTonConfigTarget3:SetText(SunDaTonConfig.Target.TargetList[3])
	SunDaTonConfigTarget4:SetText(SunDaTonConfig.Target.TargetList[4])
	SunDaTonConfigTargetPreview:SetText(SunDaTonConfig.Target.Macro)
end

function SunDaTonConfig_SaveTarget()
	local macro = SunDaTon_Target_Macro_Start
	if SunDaTon_Player_Class==3 and SunDaTonConfig.Target.PetTarget then
		macro=macro .. SunDaTon_MacroPetTarget
	elseif SunDaTon_Player_Class==9 and SunDaTonConfig.Target.PetTarget then
		macro=macro .. SunDaTon_MacroPetTarget
	end
	if SunDaTonConfig.Target.isTargetEnemy then
		macro = macro .. SunDaTon_Target_Enemy
	end
	local i
	for i=1,#SunDaTonConfig.Target.TargetList,1 do
		if string.len(SunDaTonConfig.Target.TargetList[i])>0 then
			if SunDaTonConfig.Target.IsSkinning then
				macro = macro .. string.format(SunDaTon_Target_Skinning, SunDaTonConfig.Target.TargetList[i])
			else
				macro = macro .. string.format(SunDaTon_Target_NoSkinning, SunDaTonConfig.Target.TargetList[i])
			end
		end
	end
	if SunDaTon_Player_Class==1 and SunDaTonConfig.Attack.ZSCharge then
		macro = SunDaTon_MacroZSCharge .. macro
	end
	SunDaTonConfigTargetPreview:SetText(macro)
	SunDaTonConfig.Target.Macro = macro
end

function SunDaTonConfigTargetenemy_Click(self)
	SunDaTonConfig.Target.isTargetEnemy = self:GetChecked()
	SunDaTonConfig_SaveTarget()
end

function SunDaTonConfigTargetSkinning_Click(self)
	SunDaTonConfig.Target.IsSkinning = self:GetChecked()
	SunDaTonConfig_SaveTarget()
end

function SunDaTonConfigTarget_OnTextChanged(self, index)
	SunDaTonConfig.Target.TargetList[index]=self:GetText()
	SunDaTonConfig_SaveTarget()
end

function SunDaTonConfigClearTarget_Click()
	SunDaTon_EditMacro(SunDaTon_MacroClearTarget, SunDaTon_MacroClearTargetBody)
end

function SunDaTonConfigTargetPet_Click(self)
	SunDaTonConfig.Target.PetTarget=self:GetChecked()
end
-- target event end

-- Attack event start
function SunDaTon_ShowAttackPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigAttackSettingsPanel
	SunDaTonConfigAttackSettingsPanel:Show()
	-- initial
	SunDaTonConfigAttackCycle:SetChecked(SunDaTonConfig.Attack.Cycle)
	SunDaTonConfigAttackZSCharge:SetChecked(SunDaTonConfig.Attack.ZSCharge)
	SunDaTonConfigPetAttack:SetChecked(SunDaTonConfig.Attack.PetAttack)
	SunDaTonConfigAttack1:SetText(SunDaTonConfig.Attack.SkillList[1])
	SunDaTonConfigAttack2:SetText(SunDaTonConfig.Attack.SkillList[2])
	SunDaTonConfigAttack3:SetText(SunDaTonConfig.Attack.SkillList[3])
	SunDaTonConfigAttack4:SetText(SunDaTonConfig.Attack.SkillList[4])
	SunDaTonConfigAttack5:SetText(SunDaTonConfig.Attack.SkillList[5])	
	SunDaTonConfigAttack6:SetText(SunDaTonConfig.Attack.SkillList[6])
	SunDaTonConfigAttack7:SetText(SunDaTonConfig.Attack.SkillList[7])
	SunDaTonConfigAttack8:SetText(SunDaTonConfig.Attack.SkillList[8])
	SunDaTonConfigAttack9:SetText(SunDaTonConfig.Attack.SkillList[9])
	SunDaTonConfigAttack10:SetText(SunDaTonConfig.Attack.SkillList[10])
	SunDaTonConfigAttack11:SetText(SunDaTonConfig.Attack.SkillList[11])
	SunDaTonConfigAttackPreview:SetText(SunDaTonConfig.Attack.Macro)
end

function SunDaTonConfig_SaveAttack()
	local macro = SunDaTon_Attack_Macro_Skill
	local i
	for i=1,#SunDaTonConfig.Attack.SkillList,1 do
		if string.len(SunDaTonConfig.Attack.SkillList[i])>0 then
			macro = macro .. SunDaTonConfig.Attack.SkillList[i] .. ","
		end
	end
	if SunDaTon_Player_Class==11 then
		if string.len(SunDaTonConfig.XD.Deform) > 0 then
			macro= string.format(SunDaTon_MacroXDDeform, SunDaTonConfig.XD.Deform) .. macro
		end
	end
	if SunDaTon_Combat_State=0 then
		macro = SunDaTon_Attack_Macro_Start .. macro
	else
		macro = SunDaTon_Attack_Macro_Start_In_Combat .. macro
	end
	if SunDaTonConfig.Attack.Cycle then
		macro = macro
	else
		macro = macro .. SunDaTon_Attack_Macro_End
	end
	if SunDaTon_Player_Class==1 and SunDaTonConfig.Attack.ZSCharge then
		macro = SunDaTon_MacroZSCharge .. macro
	elseif SunDaTon_Player_Class==3 and SunDaTonConfig.Attack.PetAttack then
		macro = SunDaTon_MacroPetAttack .. macro
	elseif SunDaTon_Player_Class==9 and SunDaTonConfig.Attack.PetAttack then
		macro = SunDaTon_MacroPetAttack .. macro
	end
	SunDaTonConfig.Attack.Macro=macro
	SunDaTonConfigAttackPreview:SetText(SunDaTonConfig.Attack.Macro)
	SunDaTon_EditMacro(SunDaTon_MacroAttack, SunDaTonConfig.Attack.Macro)
end

function SunDaTonConfigAttackZSCharge_Click(self)
	SunDaTonConfig.Attack.ZSCharge = self:GetChecked()
	SunDaTonConfig_SaveAttack()
	SunDaTonConfig_SaveTarget()
end

function SunDaTonConfigAttackCycle_Click(self)
	SunDaTonConfig.Attack.Cycle = self:GetChecked()
	SunDaTonConfig_SaveAttack()
end

function SunDaTonConfigAttack_OnTextChanged(self, index)
	SunDaTonConfig.Attack.SkillList[index]=self:GetText()
	SunDaTonConfig_SaveAttack()
end

function SunDaTonConfigPetAttack_Click(self)
	SunDaTonConfig.Attack.PetAttack=self:GetChecked()
	SunDaTonConfig_SaveAttack()
end
-- Attack event end

-- Buff start
function SunDaTon_ShowBuffPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigBuffSettingsPanel
	SunDaTonConfigBuffSettingsPanel:Show()
	-- initial
	if SunDaTonConfig.BUFF.BuffList[1] then
		SunDaTonConfigBuff1:SetText(SunDaTonConfig.BUFF.BuffList[1])
	end
	if SunDaTonConfig.BUFF.BuffList[2] then
		SunDaTonConfigBuff2:SetText(SunDaTonConfig.BUFF.BuffList[2])
	end
	if SunDaTonConfig.BUFF.BuffList[3] then
		SunDaTonConfigBuff3:SetText(SunDaTonConfig.BUFF.BuffList[3])
	end
	if SunDaTonConfig.BUFF.BuffList[4] then
		SunDaTonConfigBuff4:SetText(SunDaTonConfig.BUFF.BuffList[4])
	end
	if SunDaTonConfig.BUFF.SkillList[1] then
		SunDaTonConfigBuffSkill1:SetText(SunDaTonConfig.BUFF.SkillList[1])
	end
	if SunDaTonConfig.BUFF.SkillList[2] then
		SunDaTonConfigBuffSkill2:SetText(SunDaTonConfig.BUFF.SkillList[2])
	end
	if SunDaTonConfig.BUFF.SkillList[3] then
		SunDaTonConfigBuffSkill3:SetText(SunDaTonConfig.BUFF.SkillList[3])
	end
	if SunDaTonConfig.BUFF.SkillList[4] then
		SunDaTonConfigBuffSkill4:SetText(SunDaTonConfig.BUFF.SkillList[4])
	end
end

function SunDaTonConfig_ResetBuff()
	
end

function SunDaTonConfigBuff_OnTextChanged(self, index)
	SunDaTonConfig.BUFF.BuffList[index]=self:GetText()
end

function SunDaTonConfigBuffSkill_OnTextChange(self, index)
	SunDaTonConfig.BUFF.SkillList[index]=self:GetText()
end
-- Buff end

-- Restore start
function SunDaTon_ShowResorePanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigRestorePanel
	SunDaTonConfigRestorePanel:Show()
	-- initial
	SunDaTon_Config_LoadSlider(SunDaTonHealthSlider,SUNDATON_CONFIG_HEALTH_SLIDER_TIPS .. ":" .. SunDaTonConfig.Restore.HealthPrecentage .. "%",0,100,5,5)
	SunDaTon_Config_LoadSlider(SunDaTonPowerSlider,SUNDATON_CONFIG_POWER_SLIDER_TIPS .. ":" .. SunDaTonConfig.Restore.PowerPrecentage .. "%",0,100,5,5)
	SunDaTonHealthSlider:SetValue(SunDaTonConfig.Restore.HealthPrecentage)
	SunDaTonPowerSlider:SetValue(SunDaTonConfig.Restore.PowerPrecentage)
	SunDaTonConfigFood1:SetText(SunDaTonConfig.Restore.HealthList[1])
	SunDaTonConfigFood2:SetText(SunDaTonConfig.Restore.HealthList[2])
	SunDaTonConfigFood3:SetText(SunDaTonConfig.Restore.HealthList[3])
	SunDaTonConfigFood4:SetText(SunDaTonConfig.Restore.HealthList[4])
	SunDaTonConfigDrick1:SetText(SunDaTonConfig.Restore.PowerList[1])
	SunDaTonConfigDrick2:SetText(SunDaTonConfig.Restore.PowerList[2])
	SunDaTonConfigDrick3:SetText(SunDaTonConfig.Restore.PowerList[3])
	SunDaTonConfigDrick4:SetText(SunDaTonConfig.Restore.PowerList[4])
end

function SunDaTonConfigHealth_OnValueChange(self)
	SunDaTonConfig.Restore.HealthPrecentage=math.floor(self:GetValue())
	SunDaTonHealthSliderText:SetText(SUNDATON_CONFIG_HEALTH_SLIDER_TIPS .. ":" .. SunDaTonConfig.Restore.HealthPrecentage .. "%")
end

function SunDaTonConfigPower_OnValueChange(self)
	SunDaTonConfig.Restore.PowerPrecentage=math.floor(self:GetValue())
	SunDaTonPowerSliderText:SetText(SUNDATON_CONFIG_POWER_SLIDER_TIPS .. ":" .. SunDaTonConfig.Restore.PowerPrecentage .. "%")
end

function SunDaTonConfigHealth_OnTextChanged(self, index)
	SunDaTonConfig.Restore.HealthList[index]=self:GetText()
end

function SunDaTonConfigPower_OnTextChanged(self, index)
	SunDaTonConfig.Restore.PowerList[index]=self:GetText()
end
-- Restore end

-- Rubbish Panel start
function SunDaTon_ShowRubbishPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigRubbishPanel
	SunDaTonConfigRubbishPanel:Show()
	-- initial
	SunDaTonConfigEnableRubbish:SetChecked(SunDaTonConfig.Rubbish.Enable)
	SunDaTonConfigRubbish1:SetText(SunDaTonConfig.Rubbish.List[1])
	SunDaTonConfigRubbish2:SetText(SunDaTonConfig.Rubbish.List[2])
	SunDaTonConfigRubbish3:SetText(SunDaTonConfig.Rubbish.List[3])
	SunDaTonConfigRubbish4:SetText(SunDaTonConfig.Rubbish.List[4])
	SunDaTonConfigRubbish5:SetText(SunDaTonConfig.Rubbish.List[5])
	SunDaTonConfigRubbish6:SetText(SunDaTonConfig.Rubbish.List[6])
	SunDaTonConfigRubbish7:SetText(SunDaTonConfig.Rubbish.List[7])
	SunDaTonConfigRubbish8:SetText(SunDaTonConfig.Rubbish.List[8])
end

function SunDaTonConfigEnableRubbish_Click(self)
	SunDaTonConfig.Rubbish.Enable = self:GetChecked()
end

function SunDaTonConfigRubbish_OnTextChanged(self, index)
	SunDaTonConfig.Rubbish.List[index]=self:GetText()
end
--Rubbish Panel end

--Other Panel start
function SunDaTon_ShowOtherPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigOtherPanel
	SunDaTonConfigOtherPanel:Show()
	-- initial
	SunDaTonConfigEnableBangke:SetChecked(SunDaTonConfig.Other.EnableBangke)
	if SunDaTonConfig.Other.BangkeName then
		SunDaTonConfigBangkeName:SetText(SunDaTonConfig.Other.BangkeName)
	end
	SunDaTon_Config_LoadSlider(SunDaTonConfigCombatDelay,string.format(SUNDATON_CONFIG_OTHER_COMBAT_DELAY, SunDaTonConfig.Other.CombatDelay),0,10,1,1)
	SunDaTonConfigCombatDelay:SetValue(SunDaTonConfig.Other.CombatDelay)
end

function SunDaTon_SaveBangke()
	if SunDaTonConfig.Other.EnableBangke
		and string.len(SunDaTonConfig.Other.BangkeName) > 0 then
		SunDaTon_MacroStart_body=string.format(SunDaTon_MacroBangke, SunDaTonConfig.Other.BangkeName)
	else
		SunDaTon_MacroStart_body="/sdt check"
	end
	--SunDaTon_Log(SunDaTon_MacroStart_body)
	SunDaTon_EditMacro(SunDaTon_MacroStart, SunDaTon_MacroStart_body)
end

function SunDaTonConfigEnableBangke_Click(self)
	SunDaTonConfig.Other.EnableBangke=self:GetChecked()
	SunDaTon_SaveBangke()
end

function SunDaTonConfigBangkeName_OnTextChanged(self)
	SunDaTonConfig.Other.BangkeName=self:GetText()
	SunDaTon_SaveBangke()
end

function SunDaTonConfigCombatDelay_OnValueChange(self)
	SunDaTonConfig.Other.CombatDelay=self:GetValue()
	SunDaTonConfigCombatDelayText:SetText(string.format(SUNDATON_CONFIG_OTHER_COMBAT_DELAY, SunDaTonConfig.Other.CombatDelay))
end
--Other Panel end

-- DZ panel start
function SunDaTon_ShowDZPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigDZPanel
	SunDaTonConfigDZPanel:Show()
	-- initial UI
	SunDaTonConfigAutoPoison:SetChecked(SunDaTonConfig.DZ.AutoPoison)
	SunDaTonConfigMainPoison:SetText(SunDaTonConfig.DZ.MainPoison)
	SunDaTonConfigSecondaryPoison:SetText(SunDaTonConfig.DZ.SecondaryPoison)
end

function SunDaTonConfigAutoPoison_Click(self)
	SunDaTonConfig.DZ.AutoPoison=self:GetChecked()
end

function SunDaTonConfigMainPoison_OnTextChanged(self)
	SunDaTonConfig.DZ.MainPoison=self:GetText()
end

function SunDaTonConfigSecondaryPoison_OnTextChanged(self)
	SunDaTonConfig.DZ.SecondaryPoison=self:GetText()
end
-- DZ panel end

-- SM panel start
function SunDaTon_ShowSMPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigSMPanel
	SunDaTonConfigSMPanel:Show()
	-- initial UI
	SunDaTonConfigAutoEnchant:SetChecked(SunDaTonConfig.SM.AutoEnchant)
	SunDaTonConfigEnchantSkill:SetText(SunDaTonConfig.SM.EnchantSkill)
end

function SunDaTonConfigAutoEnchant_Click(self)
	SunDaTonConfig.SM.AutoEnchant=self:GetChecked()
end

function SunDaTonConfigEnchantSkill_OnTextChanged(self)
	SunDaTonConfig.SM.EnchantSkill=self:GetText()
end
-- SM panel end

-- SS PANEL START
function SunDaTon_ShowSSPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigSSPanel
	SunDaTonConfigSSPanel:Show()
	-- initial
	SunDaTon_Config_LoadSlider(SunDaTonSSPetHealthSlider,SUNDATON_CONFIG_SS_PETHEALTH_TIPS,0,100,5,5)
	SunDaTonSSPetHealthSlider:SetValue(SunDaTonConfig.SS.PetHealthPrecent)
	SunDaTonSSPetHealthSliderText:SetText(SUNDATON_CONFIG_SS_PETHEALTH_TIPS .. ":" .. SunDaTonConfig.SS.PetHealthPrecent .. "%")
	SunDaTonConfigSSPet:SetChecked(SunDaTonConfig.SS.AutoPet)
	SunDaTonConfigSSPetSkill:SetText(SunDaTonConfig.SS.PetSkill)
	SunDaTonConfigSSPetHealth:SetChecked(SunDaTonConfig.SS.AutoPetHealth)
	SunDaTonConfigSSPetHealthSkill:SetText(SunDaTonConfig.SS.PetHealthSkill)
end

function SunDaTonConfigSSPet_Click(self)
	SunDaTonConfig.SS.AutoPet=self:GetChecked()
end

function SunDaTonConfigSSPetSkill_OnTextChanged(self)
	SunDaTonConfig.SS.PetSkill=self:GetText()
end

function SunDaTonConfigSSPetHealth_Click(self)
	SunDaTonConfig.SS.AuthPetHealth=self:GetChecked()
end

function SunDaTonConfigSSPetHealth_OnValueChange(self)
	SunDaTonConfig.SS.PetHealthPrecent=math.floor(self:GetValue())
	SunDaTonSSPetHealthSliderText:SetText(SUNDATON_CONFIG_SS_PETHEALTH_TIPS .. ":" .. SunDaTonConfig.SS.PetHealthPrecent .. "%")
end

function SunDaTonConfigSSPetHealthSkill_OnTextChanged(self)
	SunDaTonConfig.SS.PetHealthSkill=self:GetText()
end
-- SS PANEL END

-- LR panel start
function SunDaTon_ShowLRPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigLRPanel
	SunDaTonConfigLRPanel:Show()
	-- initial
	SunDaTonConfigLRPet:SetChecked(SunDaTonConfig.LR.AutoPet)
	SunDaTonConfigLRPetHealth:SetChecked(SunDaTonConfig.LR.PetHealth)
	SunDaTonConfigLRPetHappyness:SetChecked(SunDaTonConfig.LR.PetHappyness)
	SunDaTonConfigLRPetMeat:SetText(SunDaTonConfig.LR.PetMeat)
end

function SunDaTonConfigLRPet_Click(self)
	SunDaTonConfig.LR.AutoPet=self:GetChecked()
end

function SunDaTonConfigLRPetHealth_Click(self)
	SunDaTonConfig.LR.PetHealth=self:GetChecked()
end

function SunDaTonConfigLRPetHappyness_Click(self)
	SunDaTonConfig.LR.PetHappyness=self:GetChecked()
end

function SunDaTonConfigLRPetMeat_OnTextChanged(self)
	SunDaTonConfig.LR.PetMeat=self:GetText()
end
-- LR panel end

-- XD Panel start
function SunDaTon_ShowXDPanel()
	if SunDaTon_CurrentPanel then
		SunDaTon_CurrentPanel:Hide()
	end
	SunDaTon_CurrentPanel=SunDaTonConfigXDPanel
	SunDaTonConfigXDPanel:Show()
	-- initial
	SunDaTonConfigXDDeform:SetText(SunDaTonConfig.XD.Deform)
end

function SunDaTonConfigXDDeform_OnTextChanged(self)
	SunDaTonConfig.XD.Deform=self:GetText()
	SunDaTonConfig_SaveAttack()
end
-- XD Panel end









