Wishlist = {}

Wishlist.i10n = {}

Wishlist.UserData = { -- user wishlist
	items = {
        Mainhand = {7080},
        Offhand = {8088},
        SpecialWeapon = {33974},
        Gloves = {}
    }
}

Wishlist.Items = {
    Gloves = {
        34370,
        34366,
        34372,
        34406
    }
}

Wishlist.SlotInfo = {
    WishlistMainhand = "Mainhand",
    WishlistOffhand = "Offhand",
    WishlistSpecialWeapon = "SpecialWeapon",
    WishlistGloves = "Gloves",
}


SLASH_RELOADUI1 = "/rl" -- Fast reload command

SLASH_FRAMESTK1 = "/fs" -- Fast frame stck command
SlashCmdList.FRAMESTK = function()
    LoadAddOn('Blizzard_DebugTools')
    FrameStackTooltip_Toggle()
end

-- To be able to use the left and right arrows in the edit box
for i = 1, NUM_CHAT_WINDOWS do
    _G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
end
-------------------------------------------------------------------------------------------------------

local loader = CreateFrame("Frame", nil, self);
loader:RegisterEvent("PLAYER_ENTERING_WORLD")
loader:SetScript("OnEvent", WishlistInitialization);


-- local UIConfig = CreateFrame("Frame", "Wishlist_MainFrame", UIParent, "BasicFrameTemplateWithInset")

function Wishlist.WishlistInitialization()
    print("Setting up locale")
    local gameLocale = GetLocale();
    Wishlist.i10n.SetLocale(gameLocale);
end

-- UIConfig.Title = UIConfig:CreateFontString(nil, "Wishlist_MainFrame_Title", "GameFontHighlight")
-- UIConfig.Title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0)
--UIConfig.Title:SetText("Wishlist")
-- UIConfig:SetSize(300,300)
--UIConfig:SetPoint("CENTER", UIParent, "CENTER") -- point, relativeFrame, relativePoint, xOffset, yOffset
-- UIConfig:SetMovable(true);
-- UIConfig:EnableMouse(true);
-- UIConfig:RegisterForDrag("LeftButton");
-- UIConfig:SetScript("OnDragStart", UIConfig.StartMoving);
-- UIConfig:SetScript("OnDragStop", UIConfig.StopMovingOrSizing);
--UIConfig:RegisterEvent("CHAT_MSG_LOOT");
--UIConfig:SetScript("OnEvent", WhisedItemLootedHandler);

-- Function that print on the chat when an item from the wished list is looted
local function WhisedItemLootedHandler(self, event, chatMsg, ...) 
    local itemLootedId = string.match(chatMsg, "|Hitem:([0-9]*):");
    print(itemLootedId);
    for _,value in ipairs(Wishlist.UserData.items) do
        if (tostring(value) == itemLootedId) then
            print("Item in the wishlist looted");
        end
    end
end