---@type QuestieTooltips
local QuestieTooltips = QuestieLoader:ImportModule("QuestieTooltips");
local _QuestieTooltips = QuestieTooltips.private

---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

--- COMPATIBILITY ---
local UnitGUID = QuestieCompat.UnitGUID

local lastGuid

function _QuestieTooltips:AddUnitDataToTooltip()
    if (self.IsForbidden and self:IsForbidden()) or (not Questie.db.profile.enableTooltips) then
        return
    end

    local name, unitToken = self:GetUnit();
    if not unitToken then return end
    local guid = UnitGUID(unitToken);
    if (not guid) then
        guid = UnitGUID("mouseover");
    end

    local type, _, _, _, _, npcId, _ = strsplit("-", guid or "");

    if name and (type == "Creature" or type == "Vehicle") and (
        name ~= QuestieTooltips.lastGametooltipUnit or
        (not QuestieTooltips.lastGametooltipCount) or
        _QuestieTooltips:CountTooltip() < QuestieTooltips.lastGametooltipCount or
        QuestieTooltips.lastGametooltipType ~= "monster" or
        lastGuid ~= guid
    ) then
        QuestieTooltips.lastGametooltipUnit = name
        local tooltipData = QuestieTooltips:GetTooltip("m_" .. npcId);
        if tooltipData then
            if Questie.db.profile.enableTooltipsNPCID == true then
                GameTooltip:AddDoubleLine("NPC ID", "|cFFFFFFFF" .. npcId .. "|r")
            end
            for _, v in pairs (tooltipData) do
                GameTooltip:AddLine(v)
            end
        end
        QuestieTooltips.lastGametooltipCount = _QuestieTooltips:CountTooltip()
    end
    lastGuid = guid;
    QuestieTooltips.lastGametooltipType = "monster";
end

local lastItemId = 0;
function _QuestieTooltips:AddItemDataToTooltip()
    if (self.IsForbidden and self:IsForbidden()) or (not Questie.db.profile.enableTooltips) then
        return
    end

    local name, link = self:GetItem()
    local itemId
    if link then
        itemId = select(3, string.match(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?"))
    end
    if name and itemId and (
        name ~= QuestieTooltips.lastGametooltipItem or
        (not QuestieTooltips.lastGametooltipCount) or
        _QuestieTooltips:CountTooltip() < QuestieTooltips.lastGametooltipCount or
        QuestieTooltips.lastGametooltipType ~= "item" or
        lastItemId ~= itemId or
        QuestieTooltips.lastFrameName ~= self:GetName()
    ) then
        QuestieTooltips.lastGametooltipItem = name
        local tooltipData = QuestieTooltips:GetTooltip("i_" .. (itemId or 0));
        if tooltipData then
            if Questie.db.profile.enableTooltipsItemID == true then
                GameTooltip:AddDoubleLine("Item ID", "|cFFFFFFFF" .. itemId .. "|r")
            end
            for _, v in pairs (tooltipData) do
                self:AddLine(v)
            end
        end
        QuestieTooltips.lastGametooltipCount = _QuestieTooltips:CountTooltip()
    end
    lastItemId = itemId;
    QuestieTooltips.lastGametooltipType = "item";
    QuestieTooltips.lastFrameName = self:GetName();
end

function _QuestieTooltips:AddObjectDataToTooltip(name)
    if (not Questie.db.profile.enableTooltips) then
        return
    end
    if name then
        local titleAdded = false
        local lookup = l10n.objectNameLookup[name] or {}
        local count = table.getn(lookup)

        if Questie.db.profile.enableTooltipsObjectID == true and count ~= 0 then
            if count == 1 then
                GameTooltip:AddDoubleLine("Object ID", "|cFFFFFFFF" .. lookup[1] .. "|r")
            else
                GameTooltip:AddDoubleLine("Object ID", "|cFFFFFFFF" .. lookup[1] .. " (" .. count .. ")|r")
            end
        end

        local alreadyAddedObjectiveLines = {}
        for _, gameObjectId in pairs(lookup) do
            local tooltipData = QuestieTooltips:GetTooltip("o_" .. gameObjectId);

            if type(gameObjectId) == "number" and tooltipData then
                if (not titleAdded) then
                    GameTooltip:AddLine(tooltipData[1])
                    titleAdded = true
                end

                if tooltipData[2] then
                    -- Quest has objectives
                    for index, line in pairs (tooltipData) do
                        if index > 1 and (not alreadyAddedObjectiveLines[line]) then -- skip the first entry, it's the title
                            local _, _, acquired, needed = string.find(line, "(%d+)/(%d+)")
                            -- We need "tonumber", because acquired can contain parts of the color string
                            if acquired and tonumber(acquired) == tonumber(needed) then
                                -- We don't want to show completed objectives on game objects
                                break;
                            end
                            alreadyAddedObjectiveLines[line] = true
                            GameTooltip:AddLine(line)
                        end
                    end
                end
            end
        end
        GameTooltip:Show()
    end
    QuestieTooltips.lastGametooltipType = "object";
end

function _QuestieTooltips:CountTooltip()
    local tooltipCount = 0
    for i = 1, GameTooltip:NumLines() do
        local frame = _G["GameTooltipTextLeft"..i]
        if frame and frame:GetText() then
            tooltipCount = tooltipCount + 1
        else
            return tooltipCount
        end
    end
    return tooltipCount
end
