function SunDaTon_CheckBag(name)
	local b,s,i
	for b=0,4 do 
		for s=1,20 do 
			i=GetContainerItemLink(b,s) 
			if i and i:find(name) then 
				return true
			end 
		end 
	end 
	return false
	-- SunDaTong_CheckBag(name)
end

function SunDaTon_CheckBuff(buff)
	local i,b
	for i=1,9 do 
		b,_,_,_,_,Time=UnitBuff("player",i)
		if b and b==buff then
			return false
		end 
	end
	return true
	-- SunDaTong_CheckBuff(buff)
end

function SunDaTon_CheckDebuff(debuff)
	local i,b
	for i=1,9 do 
		b=UnitDebuff("player",i); 
		if b and b==debuff then
			return false
		end 
	end
	return true
	--SunDaTon_CheckDebuff
end

function SunDaTon_CheckHealth(Precent)
	if UnitHealth("player")/UnitHealthMax("player")*100<Precent then 
		return true
	else
		return false
	end
	-- SunDaTong_CheckHealth()
end

function SunDaTon_GetHealth()
	return UnitHealth("player")/UnitHealthMax("player")*100
end

function SunDaTon_CheckPower(Precent)
	if UnitPower("player")/UnitPowerMax("player")*100<Precent then 
		return true
	else
		return false
	end
	-- SunDaTong_CheckPower()
end

function SunDaTon_CheckPetHealth(Precent)
	if UnitHealth("pet")/UnitHealthMax("pet")*100<Precent then 
		return true
	else
		return false
	end
	-- SunDaTon_CheckPetHealth()
end

function SunDaTon_EditMacro(MacroName, body)
	local i=GetMacroIndexByName(MacroName)
	if i==0 then
        i = CreateMacro(MacroName, SunDaTon_MacroDefaultIcon, body, nil)
    else
        i = EditMacro(i, nil, nil, body, 1);
    end
	-- SunDaTong_EditMacro(body)
end


function SunDaTon_AutoRubbish()
	local b,s,i,l
	for i=1,#SunDaTonConfig.Rubbish.List,1 do 
		if string.len(SunDaTonConfig.Rubbish.List[i]) > 0 then
			for b=0,4 do 
				for s=1,20 do 
					l=GetContainerItemLink(b,s) 
					if l and l:find(SunDaTonConfig.Rubbish.List[i]) then 
						PickupContainerItem(b,s)
						DeleteCursorItem()
					end 
				end 
			end 
		end
	end
	--SunDaTon_AutoRubbish
end

function SunDaTon_UnitClassSample(classIndex)
	if classIndex == 1 then
		return "ZS"
	elseif classIndex == 2 then
		return "QS"
	elseif classIndex == 3 then
		return "LR"
	elseif classIndex == 4 then
		return "DZ"
	elseif classIndex == 5 then
		return "MS"
	elseif classIndex == 6 then
		return "DK"
	elseif classIndex == 7 then
		return "SM"
	elseif classIndex == 8 then
		return "FS"
	elseif classIndex == 9 then
		return "SS"
	elseif classIndex == 10 then
		return "MK"
	elseif classIndex == 11 then
		return "XD"
	elseif classIndex == 12 then
		return "DH"
	else
		return "NONE"
	end
	-- SunDaTon_UnitClassSample
end

function SunDaTon_Log(msg)
	msg = "SunDaTon:" .. msg
	DEFAULT_CHAT_FRAME:AddMessage(msg)
	--SunDaTon_DEBUG
end