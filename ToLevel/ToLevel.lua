local ToLevel_EventFrame = CreateFrame("Frame")
local previousResults = {}
local previousKillTimes = {}
local minValue = 0
local maxValue = 0
local lastKillTimestamp = 0
local currentKillTimestamp = 0
table.reduce = function (list, fn) 
    local acc
    for k, v in ipairs(list) do
        if 1 == k then
            acc = v
        else
            acc = fn(acc, v)
        end 
    end 
    return acc 
end

table.sum = function(list)
	return table.reduce(
		list,
		function (a, b)
			return a + b
		end
	)
end
local frame, events = CreateFrame("Frame"), {};
function events:PLAYER_LEVEL_UP(...)
	previousResults = {}
end
function events:UPDATE_EXHAUSTION(...)
	previousResults = {}
end

function events:ZONE_CHANGED(...)
	previousResults = {}
end
function events:ZONE_CHANGED_INDOORS(...)
	previousResults = {}
end
function events:ZONE_CHANGED_NEW_AREA(...)
	previousResults = {}
end
frame:SetScript("OnEvent", function(self, event, ...)
	events[event](self, ...);
end);

for k, v in pairs(events) do
	frame:RegisterEvent(k);
end



function calculateXpToLevel(xp)

	local xpTotal, xpCurrent, xpToLevel, mobsToLevel
	
	xpTotal = UnitXPMax("player");
	xpCurrent = UnitXP("player") + xp;
	xpToLevel = xpTotal - xpCurrent;
	mobsToLevel = abs(xpToLevel / xp) + 1;
	
	return floor(mobsToLevel) + 1;
	
end

ToLevel_EventFrame:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
ToLevel_EventFrame:SetScript("OnEvent",
    function(self, event, xpGainText)
	    local xpTotal, xpCurrent, xpToLevel, mobsToLevel, mobsToLevelRound, outputText, tableSum, previousResultMultiplier;
		_, _, creatureName, xp = string.find(xpGainText, "(.+) dies, you gain (%d+) experience.")
		
		if creatureName then
			lastKillTimestamp = currentKillTimestamp
			currentKillTimestamp = time()

			if table.getn(previousResults) > 5 then
				table.remove(previousResults,1)
			end
			
			if table.getn(previousResults) > 0 then
				
				if minValue > xp then
					minValue = xp;
				end
				
				if maxValue < xp then
					maxValue = xp;
				end
			end
			
			if table.getn(previousResults) == 0 then
			
				minValue = xp;
				maxValue = xp;
				for i = 1,10 do 
				   table.insert(previousResults, xp);
				end
			
			end
			
			table.insert(previousResults, xp);
			
			tableSum = table.sum(previousResults);
			
			mobsToLevelRound = calculateXpToLevel(tableSum / table.getn(previousResults));
			
			outputText = format("%d mobs needed to level up. ", mobsToLevelRound);

			if lastKillTimestamp > 0 then
				table.insert(previousKillTimes, currentKillTimestamp - lastKillTimestamp);
				if table.getn(previousKillTimes) > 10 then
					table.remove(previousKillTimes,1);
				end
				averageKillTime = table.sum(previousKillTimes) /  table.getn(previousKillTimes);
				outputText = outputText .. string.format("%.1f", mobsToLevelRound * averageKillTime / 3600) .. " hours left. "
			end
			
			DEFAULT_CHAT_FRAME:AddMessage(outputText, 1.0, 1.0, 0.0);
			
		end
	end
)