local E = FindMetaTable "Entity"

local function NetworkVar(self, type, idx, name, ext)
    if (not self.NetworkedVars_) then
        self.NetworkedVars_ = {}
    end
    if (not self.NetworkedVars_[type]) then
        self.NetworkedVars_[type] = {}
    end

    local index = self.NetworkedVars_[type]
    
    idx = index[name]

    if (not idx) then
        index[name] = #index
        table.insert(index, name)
        idx = index[name]
    end

    E.NetworkVar = nil
    self:NetworkVar(type, idx, name, ext)
    E.NetworkVar = NetworkVar
end

E.NetworkVar = NetworkVar