ITEM_TYPE_WEAPON = 1
ITEM_TYPE_APPAREL = 2
ITEM_TYPE_SHIELD = 3
ITEM_TYPE_ARROW = 4

local _R = debug.getregistry()
local meta = {}
_R.Item = meta
local methods = {}
meta.__index = methods
function meta:__tostring()
	return "Item [" .. tostring(self:GetID()) .. "] [" .. tostring(self:GetAmount()) .. "]"
end
methods.MetaName = "Item"
function _R.Item.Create(itemData,itemID,am,cnd)
	local t = {}
	setmetatable(t,meta)
	t.m_id = itemID
	t.m_amount = am || 1
	t.m_cnds = {}
	t.m_itemData = itemData
	local data = itemData[itemID]
	t.m_itemData = data
	t.m_itemType = data.itemType
	if(t:HasCondition()) then
		cnd = cnd || 100
		for i = 1,am do
			table.insert(t.m_cnds,cnd)
		end
	end
	return t
end

function methods:GetType() return self.m_itemType end
function methods:GetData() return self.m_itemData end
function methods:GetID() return self.m_id end
function methods:GetAmount() return self.m_amount end
function methods:GetConditions() return self.m_cnds end

function methods:HasCondition()
	local type = self:GetType()
	return type == ITEM_TYPE_WEAPON || type == ITEM_TYPE_APPAREL || type == ITEM_TYPE_SHIELD
end

function methods:Add(am,cnd)
	if(!self:HasCondition()) then
		self.m_amount = self.m_amount +am
		return
	end
	for i = 1,am do
		table.insert(self.m_cnds,cnd)
	end
end