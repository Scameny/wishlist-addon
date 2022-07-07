local i10n = Wishlist.i10n;

function WishlistMainFrame_OnLoad(self)
    Wishlist.WishlistInitialization();
    self.Title = self:CreateFontString(nil, "MainFrameTitle", "GameFontHighlight");
    self.Title:SetPoint("LEFT", self.TitleBg, "LEFT", 5, 0);
    self.Title:SetText(i10n.GetText("MAIN_FRAME_TITLE"));
end

function WishlistItemSlotButton_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    local _, itemLink = GetItemInfo(self:GetID())
    -- We set the hyper link for the specified item
	if (not itemLink) then
        -- Empty slot tooltp
        GameTooltip:SetText(i10n.GetText("EMPTY_SLOT"));
    else
        GameTooltip:SetHyperlink(itemLink)
    end
    CursorUpdate(self);
end

function WishlistItemSlotButton_OnLoad(self)
    local name = Wishlist.SlotInfo[self:GetName()];
    local itemId = Wishlist.UserData.items[name][1];
    if (itemId) then
        local _, _, _, _, itemTexture = GetItemInfoInstant(itemId);
        self:SetID(itemId);
        if ( not itemTexture ) then
            itemTexture = self.backgroundTextureName;
        end
        SetItemButtonTexture(self, itemTexture);
        SetItemButtonCount(self, 0);
    end
    if ( GameTooltip:IsOwned(self) ) then
        GameTooltip:Hide();
    end
end

function WishlistItemSlotButton_OnMouseDown(self)
    local slot = Wishlist.SlotInfo[self:GetName()];
    WishlistItemSearchList:SetParent(self)
    if (not WishlistItemSearchList:IsVisible()) then
        WishlistItemSearchList:Show();
    end

end

local function IsEmpty(s)
    return s == nil or s == ''
end

function SearchItemsForOneSlot(self)
    local keywords = WishlistItemSearchBox:GetText()
    local slotName = Wishlist.SlotInfo[self:GetParent():GetParent():GetParent():GetName()];
    for i=0, 5, 1 do
        local itemId = Wishlist.Items[slotName][i]
        if (!itemId) then
            return
        end
        local itemToLoad = Item:CreateFromItemID(itemId);
        itemToLoad:ContinueOnItemLoad(function()
            if (IsEmpty(keywords) or string.find(itemToLoad:GetName(), keywords)) then
                local children = { WishlistItemSearchList:GetChildren() }
                local numChilds = WishlistItemSearchList:GetNumChildren();
                --local frame = CreateFrame("Frame", "WishlistSearchResultRow" .. tostring(index), WishlistItemSearchList, "WishlistNewItemRow")
                --frame:SetPoint("TOP", children[numChilds], "BOTTOM", 0, -3)
                --frame:SetText(itemToLoad:GetName())
                local item = frame:GetChildren();
                item:SetID(itemId);
                SetItemButtonTexture(item, itemToLoad:GetItemIcon());
                SetItemButtonCount(item, 0);
                if ( GameTooltip:IsOwned(item) ) then
                    GameTooltip:Hide();
                end
            end
        end)
    end
end

function WishlistSetWishedItemInSlot(self)
    local itemId = self:GetID();
    if (not itemId) then
        print("kowadunga")
    end
    local itemSlotFrame = self:GetParent():GetParent():GetParent();
    local slotName = Wishlist.SlotInfo[itemSlotFrame:GetName()];
    Wishlist.UserData.items[slotName][1] = itemId;
    WishlistItemSlotButton_OnLoad(itemSlotFrame);
end
