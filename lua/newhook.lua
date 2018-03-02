if (SERVER) then
    AddCSLuaFile()
end

local function loadtable(size)
    local t = CompileString("return {"..("nil,"):rep(size - 1).."1}", "loadtable")()
    t[size] = nil
    return t
end

do -- do not use these, just for identification
    local i_fn_table = 1
    local i_id_table = 2
    local i_count    = 3
end

local internal_representation = {--[[
    HookName = {
        [i_fn_table] = {fn1, fn2, ...},
        [i_id_table] = {nil, nil, fn, nil, ...},
        [i_count]    = iter_count
    }
]]}
local external_representation = {}

local function GetTable()
    return external_representation
end

local function Remove(event, name)
    local external_event = external_representation[event]
    if (not external_event) then
        return
    end

    local fn = external_event[name]
    if (not fn) then
        return
    end
    
    external_event[name] = nil

    local internal_event = internal_representation[event]

    local fn_table = internal_event[1 --[[i_fn_table]]]
    local id_table = internal_event[2 --[[i_id_table]]]
    local count    = internal_event[3 --[[i_count]]   ]
    for fn_index = 1, count do
        local ind_fn = fn_table[fn_index]
        if (ind_fn == fn) then
            if (count == 1) then
                internal_representation[event] = nil
                return
            end
            -- remove if last 
            fn_table[fn_index] = nil
            id_table[fn_index] = nil

            for index = fn_index + 1, count do
                fn_table[index - 1] = fn_table[index]
                id_table[index - 1] = id_table[index]
            end
            internal_event[3 --[[i_count]]] = count - 1
            break
        end
    end

end

local function Add(event, name, fn)
    if (not event) then
        assert(false, "bad argument #1 to 'Add' (value expected)")
    end
    if (not name) then
        assert(false, "bad argument #2 to 'Add' (value expected)")
    end

    if (not fn) then
        Remove(event, name)
        return
    end

    -- external table update

    local external_event = external_representation[event]
    if (not external_event) then
        external_event = {}
        external_representation[event] = external_event
    end
    local old_fn = external_representation[event][name]
    external_representation[event][name] = fn
    

    -- internal table update
    local internal_event = internal_representation[event]
    if (old_fn) then
        -- replace the old function with the new, if multiple hooks with same function it won't matter
        local fn_table = internal_event[1 --[[i_fn_table]]]
        for i = 1, #fn_table do
            if (fn_table[i] == old_fn) then
                fn_table[i] = fn
                break
            end
        end
    elseif (internal_event) then
        -- update

        local count = internal_event[3 --[[i_count]]]
        local fn_table = loadtable(count + 1)
        local id_table = loadtable(count + 1)
        for i = 1, count do
            fn_table[i] = internal_event[1 --[[i_fn_table]]][i]
            id_table[i] = internal_event[2 --[[i_id_table]]][i]
        end
        fn_table[count + 1] = fn
        id_table[count + 1] = type(name) ~= "string" and name or nil
        internal_event[1 --[[i_fn_table]]] = fn_table
        internal_event[2 --[[i_id_table]]] = id_table
        internal_event[3 --[[i_count]]   ] = count + 1
    else 
        -- create
        internal_event = {
            -- i_fn_table
            { fn },
            -- i_id_table
            { 1 }, -- we update this later
            -- i_count
            1
        }
        -- set to 
        internal_event[2 --[[ i_id_table ]]][1] = type(name) ~= "string" and name or nil
        internal_representation[event] = internal_event
    end
end

local function Call(event, gm, ...) -- as long as we pass these through select or directly to the end of a function everything will be ok
    local internal_event = internal_representation[event]

    if (internal_event) then
        -- TODO: return support

        local fn_table = internal_event[1 --[[i_fn_table]]]
        local id_table = internal_event[2 --[[i_id_table]]]
        local offset = 0
        for i = 1, internal_event[3 --[[i_count]]] do
            i = i + offset
            local id = id_table[i]
            if (not id) then
                local a, b, c, d, e, f = fn_table[i](...)
                if (a ~= nil) then
                    return a, b, c, d, e, f
                end
                continue -- this is faster, trust me
            end
            if (IsValid(id)) then
                local a, b, c, d, e, f = fn_table[i](id, ...)
                if (a ~= nil) then
                    return a, b, c, d, e, f
                end
                continue
            end

            Remove(event, id)
            offset = offset - 1
        end
    end

    if (not gm) then
        return
    end

    local fn = gm[event]
    if (not fn) then
        return
    end

    return fn(gm, ...)

end

local function Run(event, ...)
    return Call(event, gmod and gmod.GetGamemode() or nil, ...)
end

return {
    Remove = Remove,
    GetTable = GetTable,
    Add = Add,
    Call = Call,
    Run = Run
}