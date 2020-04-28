
Jie_Wear_Offhand_Weapon = "/equipslot 17 Sliverblade\n"
Jie_Fight_Equip = ""
Jie_Fight_Equip = Jie_Fight_Equip .. "/equip Imperial Cloak\n"
Jie_Fight_Equip = Jie_Fight_Equip .. "/equip Blood Ring\n"
Jie_Fight_Equip = Jie_Fight_Equip .. "/equip Ranger Gloves of the Monkey\n"
Jie_Fight_Equip = Jie_Fight_Equip .. "/equip Tracker's Leggings of the Monkey\n"
Jie_Fight_Equip = Jie_Fight_Equip .. "/equip Huntsman's Armor of the Monkey\n"


Jie_Regen_Equip = ""
Jie_Regen_Equip = Jie_Regen_Equip .. "/equip Gossamer Cape of Spirit\n"
Jie_Regen_Equip = Jie_Regen_Equip .. "/equip Thallium Hoop of Spirit\n"
Jie_Regen_Equip = Jie_Regen_Equip .. "/equip Regal Leggings of Spirit\n"
Jie_Regen_Equip = Jie_Regen_Equip .. "/equip Nocturnal Tunic of Spirit\n"
Jie_Regen_Equip = Jie_Regen_Equip .. "/equip Sorcerer Gloves of Spirit\n"

Jie_Current_Equip = 0

SunDaTon = nil
SunDaTon_Player = nil
SunDaTon_Player_Class = nil
SunDaTon_Player_level = 0
SunDaTon_Leave_Combat_Time=0

SunDaTon_CMD_Config = "config"
SunDaTon_CMD_Check = "check"

SunDaTon_MacroDefaultIcon = "INV_MISC_QUESTIONMARK"
SunDaTon_MacroStart = "判断"
SunDaTon_MacroStart_body = "/sdt check"
SunDaTon_MacroAction = "动作"
SunDaTon_MacroAttack = "攻击"
SunDaTon_MacroClearTarget = "清除目标"
SunDaTon_MacroBangke="/use %s \n/sdt check"
SunDaTon_MacroActionStart="/stopmacro [combat]\n/cast "
SunDaTon_MacroStandUp="/stopmacro [combat]\n/click MovePadRotateLeft\n/click MovePadRotateLeft\n/cast "
SunDaTon_MacroCast="\n/cast "
SunDaTon_MacroDZMainPoison="/stopmacro [combat]\n/use %s\n/use 16"
SunDaTon_MacroDZSecondaryPoison="/stopmacro [combat]\n/use %s\n/use 17"
SunDaTon_MacroZSCharge="/cast [nocombat,exists,nodead] 冲锋\n"
SunDaTon_MacroLRPet="/stopmacro [combat]\n/cast 复活宠物"
SunDaTon_MacroLRPetHealth="/stopmacro [combat]\n/cast [pet] 治疗宠物"
SunDaTon_MacroLRPetMeat="/stopmacro [combat]\n/cast [pet] 喂养宠物\n/use %s"
SunDaTon_MacroPetTarget="\n/target [noexists][dead][help] pettarget"
SunDaTon_MacroClearTargetBody="/cleartarget [nocombat]\n"
SunDaTon_MacroPetAttack="/petattack [exists,nodead,harm]\n"
SunDaTon_MacroLRMeleeAttack="/cast [combat] 猛禽一击\n"
SunDaTon_MacroXDDeform="/cast [nostance] %s\n"

SunDaTonConfig={}

-- target start
SunDaTon_Target_Macro_Start=Jie_Fight_Equip .. "\n/stopmacro [combat]\n"
SunDaTon_Target_Enemy="\n/targetenemy [noexists][help][dead]"
SunDaTon_Target_Skinning="\n/target [noexists][help][dead] %s"
SunDaTon_Target_NoSkinning="\n/target [noexists][help][dead] %s"
-- attack start
SunDaTon_Attack_Macro_Start= "/stopmacro [nocombat]\n/startattack [combat,exists]\n/stopmacro [noexists][help][dead]\n"
SunDaTon_Attack_Macro_Skill="/castsequence reset=target "
SunDaTon_Attack_Macro_End="0,0,"

function SunDaTon_InitialData()
	-- target
	local target = SunDaTonConfig["Target"]
	if target == nil then
		target={}
		SunDaTonConfig["Target"]=target
	end
	if target["isTargetEnemy"] == nil then
		target["isTargetEnemy"]=false
	end
	if target["IsSkinning"]==nil then
		target["IsSkinning"]=false
	end
	if target["PetTarget"]==nil then
		target["PetTarget"]=true
	end
	if target["TargetList"]==nil then
		target["TargetList"]={"","","",""}
	end
	if target["Macro"]==nil then
		target["Macro"]="/stopmacro [combat]"
	end
	-- attack
	local attack = SunDaTonConfig["Attack"]
	if attack==nil then
		attack={}
		SunDaTonConfig["Attack"]=attack
	end
	if attack["Cycle"]==nil then
		attack["Cycle"]=false
	end
	if attack["SkillList"]==nil then
		attack["SkillList"]={"","","","","","","","","","","",""}
	end
	if attack["Macro"]==nil then
		attack["Macro"]="/startattack [combat] \n/stopmacro [noexists][help][dead]"
	end
	if attack["ZSCharge"]==nil then
		attack["ZSCharge"]=false
	end
	if attack["PetAttack"]==nil then
		attack["PetAttack"]=true
	end
	-- BUFF
	local buff = SunDaTonConfig["BUFF"]
	if buff==nil then
		buff={}
		SunDaTonConfig["BUFF"]=buff
	end
	if buff["BuffList"]==nil then
		buff["BuffList"]={"","","",""}
	end
	if buff["SkillList"]==nil then
		buff["SkillList"]={"","","",""}
	end
	-- Restore
	local restore=SunDaTonConfig["Restore"]
	if restore==nil then
		restore={}
		SunDaTonConfig["Restore"]=restore
	end
	if restore["HealthPrecentage"]==nil then
		restore["HealthPrecentage"]=70
	end
	if restore["PowerPrecentage"]==nil then
		restore["PowerPrecentage"]=70
	end
	if restore["HealthList"]==nil then
		restore["HealthList"]={"","","",""}
	end
	if restore["PowerList"]==nil then
		restore["PowerList"]={"","","",""}
	end
	-- Rubbish
	local rubbish=SunDaTonConfig["Rubbish"]
	if rubbish==nil then
		rubbish={}
		SunDaTonConfig["Rubbish"]=rubbish
	end
	if rubbish["Enable"]==nil then
		rubbish["Enable"]=false
	end
	if rubbish["List"]==nil then
		rubbish["List"]={"","","","","","","","","","","",""}
	end
	-- other
	local other=SunDaTonConfig["Other"]
	if other==nil then
		other={}
		SunDaTonConfig["Other"]=other
	end
	if other["EnableBangke"]==nil then
		other["EnableBangke"]=false
	end
	if other["BangkeName"]==nil then
		other["BangkeName"]=""
	end
	if other["CombatDelay"]==nil then
		other["CombatDelay"]=5
	end
end

-- String
SUNDATON_CONFIG_TITLE="SunDaTon"
SUNDATON_CONFIG_ABOUT="关于"
SUNDATON_CONFIG_CLOSE="关闭"
SUNDATON_CONFIG_SAVE="保存"
SUNDATON_CONFIG_RESET="恢复默认设置"
SUNDATON_CONFIG_RELOAD="重载界面"

SUNDATON_CONFIG_TARGET="目标设置"
SUNDATON_CONFIG_ATTACK="攻击宏设置"
SUNDATON_CONFIG_BUFF="BUFF检查"
SUNDATON_CONFIG_RESTORE="自动恢复设置"
SUNDATON_CONFIG_OTHER="其他设置"
SUNDATON_CONFIG_RUBBISH="自动扔垃圾"
SUNDATON_CONFIG_ZS="战士"
SUNDATON_CONFIG_QS="圣骑士"
SUNDATON_CONFIG_SM="萨满祭司"
SUNDATON_CONFIG_LR="猎人"
SUNDATON_CONFIG_XD="德鲁伊"
SUNDATON_CONFIG_DZ="潜行者"
SUNDATON_CONFIG_FS="法师"
SUNDATON_CONFIG_MS="牧师"
SUNDATON_CONFIG_SS="术士"

SUNDATON_CONFIG_TARGET_TARGETENEMY="优先选取前方敌对单位"
SUNDATON_CONFIG_TARGET_SKINNING="剥皮"
SUNDATON_CONFIG_TARGET_PET="优先获取宠物的目标"
SUNDATON_CONFIG_TARGET_TARGET1="目标1"
SUNDATON_CONFIG_TARGET_TARGET2="目标2"
SUNDATON_CONFIG_TARGET_TARGET3="目标3"
SUNDATON_CONFIG_TARGET_TARGET4="目标4"
SUNDATON_CONFIG_TARGET_PREVIEW="目标宏预览"
SUNDATON_CONFIG_TARGET_MACRO="/stopmacro [combat]"
SUNDATON_CONFIG_TARGET_CLEARTARGET="生成清除目标宏"

SUNDATON_CONFIG_ATTACK_SKILL_LIST="技能序列"
SUNDATON_CONFIG_ATTACK_SKILL_CYCLE="开启技能循环"
SUNDATON_CONFIG_ATTACK_PREVIEW="攻击宏预览"
SUNDATON_CONFIG_ATTACK_MACRO="/stopmacro [help][dead][noexists]"

SUNDATON_CONFIG_BUFF_LIST="监控的BUFF名称"
SUNDATON_CONFIG_BUFF_SKILL_LIST="施放BUFF的技能或物品名称"
SUNDATON_CONFIG_BUFF_ADVANCE="在BUFF结束前补BUFF"
SUNDATON_CONFIG_BUFF_TIME="剩余%d秒补BUFF" 

SUNDATON_CONFIG_HEALTH_SLIDER_TIPS="生命值回复比例"
SUNDATON_CONFIG_HEALTH_FOOD = "恢复生命值的物品列表"
SUNDATON_CONFIG_POWER_SLIDER_TIPS="法力值回复比例"
SUNDATON_CONFIG_POWER_DRICK = "恢复法力值的物品列表"

SUNDATON_CONFIG_RUBBISH_ENABLE="开启自动扔垃圾功能"
SUNDATON_CONFIG_RUBBISH_LIST="自动丢弃物品列表"

SUNDATON_CONFIG_OTHER_BANGKE="自动开蚌壳"
SUNDATON_CONFIG_OTHER_BANGKE_NAME="蚌壳名称"
SUNDATON_CONFIG_OTHER_COMBAT_DELAY="战斗间隔时间：%d"

SUNDATON_CONFIG_PET_ATTACK_TIPS="宠物优先攻击（术士/猎人可用）"

SUNDATON_CONFIG_DZ_AUTOPOSION="自动上毒药"
SUNDATON_CONFIG_DZ_SECONDARYPOSION="副手武器毒药名称"
SUNDATON_CONFIG_DZ_MAINPOSION="主手武器毒药名称"

SUNDATON_CONFIG_SM_AUTOENCHANT="自动强化武器"
SUNDATON_CONFIG_SM_ENCHANTSKILL="强化武器技能"

SUNDATON_CONFIG_ZS_CHARGE="战士冲锋（仅战士可用）"

SUNDATON_CONFIG_SS_PET="自动召唤宠物"
SUNDATON_CONFIG_SS_PETSKILL="召唤宠物技能名称"
SUNDATON_CONFIG_SS_PETHEALTH="监控宠物生命值"
SUNDATON_CONFIG_SS_PETHEALTH_TIPS="宠物生命值回复比例"
SUNDATON_CONFIG_SS_PETHEALTH_SKILL="宠物生命值回复技能"

SUNDATON_CONFIG_LR_PET_REVIVE="自动复活宠物"
SUNDATON_CONFIG_LR_PETHAPPYNESS="监控宠物心情"
SUNDATON_CONFIG_LR_PETHEALTH="自动治疗宠物（需要学会治疗宠物）"
SUNDATON_CONFIG_LR_PETMEAT="食物名称"

SUNDATON_CONFIG_XD_DEFORM="打怪的形态（熊形态/猎豹形态）"

SUNDATON_TIPS_NO_PROFILE="尚未加载职业配置"
SUNDATON_TIPS_LOADING_PROFILE="加载职业配置"
SUNDATON_TIPS_LOADING_ERROR="加载职业配置错误"




