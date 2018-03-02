include("meta_item.lua")
local _R = debug.getregistry()
local meta = {}
_R.Inventory = meta
local methods = {}
meta.__index = methods
function meta:__tostring()
	local str = "Inventory [" .. tostring(self:GetItemCount()) .. "]"
	return str
end
methods.MetaName = "Inventory"
function _R.Inventory.Create(items)
	local t = {}
	setmetatable(t,meta)
	t.m_itemData = items
	t.m_items = {}
	t.m_numItems = 0
	return t
end

function methods:GetItemCount() return self.m_numItems end

function methods:GetItemData() return self.m_itemData end

function methods:GetItems() return self.m_items end

function methods:GetItem(itemID) return self:GetItems()[itemID] end

function methods:AddItem(itemID,am,cnd)
	local data = self:GetItemData()
	if(!data[itemID]) then return end
	am = am || 1
	self.m_numItems = self.m_numItems +am
	local items = self:GetItems()
	local item = items[itemID]
	if(item) then item:Add(am,cnd); return item end
	items[itemID] = _R.Item.Create(data,itemID,am,cnd)
	return items[itemID]
end

function methods:HasItem(itemID)
	local items = self:GetItems()
	return items[itemID] && true || false
end