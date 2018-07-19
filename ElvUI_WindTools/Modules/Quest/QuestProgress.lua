-- 原作：SimpleObjectiveProgress
-- 原作者：MMOSimca (https://wow.curseforge.com/projects/simpleobjectiveprogress)
-- 修改：houshuu
-------------------
-- 主要修改条目：
-- 模块化

local E, L, V, P, G = unpack(ElvUI);
local SimpleObjectiveProgress = E:NewModule('SimpleObjectiveProgress', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');
-- Localized function references
local LOP = _G.LibStub("LibObjectiveProgress-1.0")

P["WindTools"]["Quest Progress"] = {
    ["enabled"] = true,
}

-- OnTooltipSetUnit hook function
local function SimpleObjectiveProgressCore(self)
    if not self or not self.NumLines or self:NumLines() == 0 then return end

    local name, unit = self:GetUnit()
    if not unit then return end

    local GUID = UnitGUID(unit)
    if not GUID or GUID == "" then return end

    local npcID = select(6, ("-"):split(GUID))
    if not npcID or npcID == "" then return end

    local weightsTable = LOP:GetNPCWeightByCurrentQuests(tonumber(npcID))
    if not weightsTable then return end

    for questID, npcWeight in next, weightsTable do
        local questTitle = C_TaskQuest.GetQuestInfoByQuestID(questID)
        for j = 1, self:NumLines() do
            if _G["GameTooltipTextLeft" .. j] and _G["GameTooltipTextLeft" .. j]:GetText() == questTitle then
                _G["GameTooltipTextLeft" .. j]:SetText(_G["GameTooltipTextLeft" .. j]:GetText() .. " - " .. tostring(math.floor((npcWeight * 100) + 0.5) / 100) .. "%")
            end
        end
    end
end

-- Set our hook function
function SimpleObjectiveProgress:Initialize()
    if E.db.WindTools["Quest Progress"]["enable"] then return end
    GameTooltip:HookScript("OnTooltipSetUnit", SimpleObjectiveProgressCore)
end
E:RegisterModule(SimpleObjectiveProgress:GetName())