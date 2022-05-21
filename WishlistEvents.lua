function WishlistMainFrame_OnLoad(self)
    self.Title = self:CreateFontString(nil, "MainFrameTitle", "GameFontHighlight");
    self.Title:SetPoint("LEFT", self.TitleBg, "LEFT", 5, 0);
    self.Title:SetText(Wishlist.locale["MAIN_FRAME_TITLE"]);
end

function WishlistItemSlotButton_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
    local _, itemLink = GetItemInfo(self:GetID())
    -- We set the hyper link for the specified item
	if (not itemLink) then
        -- Change to a localized error
        GameTooltip:SetText(Wishlist.locale["INVALID_ITEM_ERROR"]);
    else
        GameTooltip:SetHyperlink(itemLink)
    end
    CursorUpdate(self);
end

function WishlistItemSlotButton_OnLoad(self)
    local name = Wishlist.SlotInfo[self:GetName()];
    local itemId = Wishlist.UserData.items[name][1];
    print("entra en la carga de datos de ", name, " con id ", itemId);
    local _, _, _, _, itemTexture = GetItemInfoInstant(itemId);
    self:SetID(itemId);
	if ( not itemTexture ) then
	    itemTexture = self.backgroundTextureName;
	end
    SetItemButtonTexture(self, itemTexture);
    SetItemButtonCount(self, 0);

	if ( GameTooltip:IsOwned(self) ) then
		GameTooltip:Hide();
	end
end

function WishlistItemSlotButton_OnMouseDown(self)
    local slot = Wishlist.SlotInfo[self:GetName()];
    --Wishlist.Frames.NewWishedItemlist = CreateFrame("Frame", "NewWishedItemList", WishlistMainFrame, "NewWishedItemList")

end
