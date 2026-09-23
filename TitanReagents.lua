-- TitanReagents.lua - By NeRgY

local ADDON_NAME, ns = ...
local L = ns.L

-- WoW: Forever removed several classic-era globals in favor of C_* namespaces
-- (unlike retail, which kept them as deprecated aliases). Fall back to the
-- namespaced version wherever it exists so the same code runs on both.
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
local GetSpellTexture = (C_Spell and C_Spell.GetSpellTexture) or GetSpellTexture
local GetItemInfo = (C_Item and C_Item.GetItemInfo) or GetItemInfo
local GetItemIcon = (C_Item and C_Item.GetItemIconByID) or GetItemIcon
local GetItemCount = (C_Item and C_Item.GetItemCount) or GetItemCount
local GetMerchantNumItems = (C_MerchantFrame and C_MerchantFrame.GetNumItems) or GetMerchantNumItems
local BuyMerchantItem = (C_MerchantFrame and C_MerchantFrame.PurchaseItem) or BuyMerchantItem

-- C_MerchantFrame.GetItemInfo() returns a table (with a .name field) instead of
-- the old GetMerchantItemInfo()'s multiple return values.
local function GetMerchantItemName(index)
    if C_MerchantFrame and C_MerchantFrame.GetItemInfo then
        local info = C_MerchantFrame.GetItemInfo(index)
        return info and info.name
    end
    return GetMerchantItemInfo(index)
end

local VERSION = GetAddOnMetadata(ADDON_NAME, "Version") or "1.0.0"

local Elib = LibStub and LibStub("Elib-4.0", true)
if not Elib then
    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000TitanReagents:|r Elib-4.0 library not found!")
    return
end

local Color = {}
Color.WHITE = "|cFFFFFFFF"
Color.GREEN = "|cFF3DDC53"
Color.YELLOW = "|cFFFFF244"
Color.GRAY = "|cFF888888"

-- Each ReagentDatabase.lua entry becomes its own Titan Panel plugin/segment
-- (same as TitanWeaponSkills' per-weapon-type plugins), hideable individually
-- via Titan's own right-click menu.
local AUTO_BUY_VARS = { "AutoBuy1Stack", "AutoBuy2Stack", "AutoBuy3Stack", "AutoBuy4Stack", "AutoBuy5Stack" }

-- Forces the client to request/cache item data for reagents we haven't seen yet.
local queryTooltip = CreateFrame("GameTooltip", "TitanReagentsQueryTooltip", nil, "GameTooltipTemplate")
queryTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

local function GetReagentName(group)
    local name = GetItemInfo(group.reagent)
    if not name then
        queryTooltip:SetHyperlink("item:" .. group.reagent)
    end
    return name
end

local function SetAutoBuy(id, activeVar)
    for _, var in ipairs(AUTO_BUY_VARS) do
        TitanSetVar(id, var, var == activeVar)
    end
    TitanSetVar(id, "AutoBuyNone", activeVar == nil)
    TitanSetVar(id, "AutoBuyCustom", false)
    TitanPanelButton_UpdateButton(id)
end

local function SetAutoBuyCustom(id, amount)
    for _, var in ipairs(AUTO_BUY_VARS) do
        TitanSetVar(id, var, false)
    end
    TitanSetVar(id, "AutoBuyNone", false)
    TitanSetVar(id, "AutoBuyCustom", true)
    TitanSetVar(id, "AutoBuyCustomAmount", amount)
    TitanPanelButton_UpdateButton(id)
end

-- Returns the desired total item count (not stacks) the player wants to keep in stock.
local function GetDesiredAmount(id, maxStack)
    if TitanGetVar(id, "AutoBuyCustom") then
        return TitanGetVar(id, "AutoBuyCustomAmount") or 0
    end

    for n, var in ipairs(AUTO_BUY_VARS) do
        if TitanGetVar(id, var) then
            return maxStack * n
        end
    end
    return 0
end

StaticPopupDialogs["TITANREAGENTS_CUSTOM_STACKS"] = {
    text = L["CUSTOM_STACKS_PROMPT"],
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = true,
    maxLetters = 5,
    OnAccept = function(self)
        local editBox = self.editBox or self.EditBox
        local value = tonumber(editBox and editBox:GetText())
        if value and value > 0 and self.data then
            SetAutoBuyCustom(self.data.id, math.floor(value))
        end
    end,
    EditBoxOnEnterPressed = function(self)
        self:GetParent().button1:Click()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function CountReagentInBags(itemID)
    local total = 0
    for bagID = 0, 4 do
        for slot = 1, C_Container.GetContainerNumSlots(bagID) do
            local info = C_Container.GetContainerItemInfo(bagID, slot)
            if info and info.itemID == itemID then
                total = total + (info.stackCount or 0)
            end
        end
    end
    return total
end

local function BuyFromVendor(itemName, purchaseCount, maxStackSize)
    for index = 1, GetMerchantNumItems() do
        local name = GetMerchantItemName(index)
        if name == itemName then
            -- Blizzard doesn't support buying multiple stacks in one API call.
            while (purchaseCount / maxStackSize) > 1 do
                BuyMerchantItem(index, maxStackSize)
                purchaseCount = purchaseCount - maxStackSize
            end
            if purchaseCount > 0 and purchaseCount <= maxStackSize then
                BuyMerchantItem(index, purchaseCount)
            end
            return
        end
    end
end

local function OnMerchantShow(id, group)
    local reagentName, _, _, _, _, _, _, maxStack = GetItemInfo(group.reagent)
    if not reagentName or not maxStack or maxStack == 0 then
        return
    end

    local desired = GetDesiredAmount(id, maxStack)
    if desired <= 0 then
        return
    end

    local have = CountReagentInBags(group.reagent)
    if have < desired then
        BuyFromVendor(reagentName, desired - have, maxStack)
    end
end

local function GetButtonText(self, id, group)
    local reagentName = GetReagentName(group)
    local label = reagentName or L["LOADING"]

    if self.registry then
        self.registry.tooltipTitle = label
        self.registry.menuText = Color.GREEN .. label .. "|r"

        local useSpellIcon = TitanGetVar(id, "ShowSpellIcon")
        local reagentIcon = (not useSpellIcon) and GetItemIcon(group.reagent)
        self.registry.icon = reagentIcon or GetSpellTexture(group.spells[1])
    end

    if not reagentName then
        return label .. ": ", ""
    end

    return reagentName .. ": ", Color.WHITE .. GetItemCount(group.reagent) .. "|r"
end

local function GetTooltipText(self, id, group)
    local reagentName = GetReagentName(group)
    local label = reagentName or L["LOADING"]

    if not reagentName then
        return label
    end

    return label .. "\n" .. Color.WHITE .. GetItemCount(group.reagent) .. "|r"
end

local function CreateReagentPlugin(id, group)
    local function Reload()
        TitanPanelButton_UpdateButton(id)
    end

    local menus = {
        { type = "toggle", text = L["SHOW_SPELL_ICON"], var = "ShowSpellIcon", def = false },
        { type = "toggle", text = L["AUTOBUY_1"], var = "AutoBuy1Stack", def = false, func = function() SetAutoBuy(id, "AutoBuy1Stack") end },
        { type = "toggle", text = L["AUTOBUY_2"], var = "AutoBuy2Stack", def = false, func = function() SetAutoBuy(id, "AutoBuy2Stack") end },
        { type = "toggle", text = L["AUTOBUY_3"], var = "AutoBuy3Stack", def = false, func = function() SetAutoBuy(id, "AutoBuy3Stack") end },
        { type = "toggle", text = L["AUTOBUY_4"], var = "AutoBuy4Stack", def = false, func = function() SetAutoBuy(id, "AutoBuy4Stack") end },
        { type = "toggle", text = L["AUTOBUY_5"], var = "AutoBuy5Stack", def = false, func = function() SetAutoBuy(id, "AutoBuy5Stack") end },
        {
            type = "button",
            text = L["AUTOBUY_CUSTOM"],
            func = function()
                local dialog = StaticPopup_Show("TITANREAGENTS_CUSTOM_STACKS")
                if dialog then
                    dialog.data = { id = id }
                    local current = TitanGetVar(id, "AutoBuyCustom") and TitanGetVar(id, "AutoBuyCustomAmount")
                    local editBox = dialog.editBox or dialog.EditBox
                    if current and editBox then
                        editBox:SetText(tostring(current))
                    end
                end
            end,
        },
        { type = "toggle", text = L["AUTOBUY_NONE"], var = "AutoBuyNone", def = true, func = function() SetAutoBuy(id, nil) end },
        { type = "rightSideToggle" },
    }

    Elib.Register({
        id = id,
        name = L["LOADING"],
        tooltip = L["LOADING"],
        icon = GetSpellTexture(group.spells[1]),
        -- Must be one of Titan's own fixed category keys (General/Combat/Information/
        -- Interface/Profession/Bars) - anything else and Titan silently drops the plugin
        -- from its "Plugins" menu, same as TitanWeaponSkills uses "Combat" literally.
        category = "Profession",
        version = VERSION,
        getButtonText = function(self) return GetButtonText(self, id, group) end,
        getTooltipText = function(self) return GetTooltipText(self, id, group) end,
        eventsTable = {
            PLAYER_LOGIN = Reload,
            PLAYER_ENTERING_WORLD = Reload,
            SPELLS_CHANGED = Reload,
            PLAYER_LEVEL_UP = Reload,
            BAG_UPDATE = Reload,
            MERCHANT_SHOW = function() OnMerchantShow(id, group) end,
        },
        menus = menus,
        savedVariables = {
            ShowSpellIcon = false,
            AutoBuy1Stack = false,
            AutoBuy2Stack = false,
            AutoBuy3Stack = false,
            AutoBuy4Stack = false,
            AutoBuy5Stack = false,
            AutoBuyCustom = false,
            AutoBuyCustomAmount = 1,
            AutoBuyNone = true,
        },
    })
end

local function Initialize()
    local _, classToken = UnitClass("player")
    if not classToken then
        return
    end

    local groups = ns.spells and ns.spells[classToken]
    if not groups then
        return
    end

    for i, group in ipairs(groups) do
        local id = "TITAN_REAGENT_" .. classToken .. i
        CreateReagentPlugin(id, group)
    end
end

-- Player info is available at load for character-specific addons; fall back if needed.
if UnitClass("player") then
    Initialize()
else
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_LOGIN")
    f:SetScript("OnEvent", function(self)
        self:UnregisterEvent("PLAYER_LOGIN")
        Initialize()
    end)
end
