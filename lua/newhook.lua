if (SERVER) then AddCSLuaFile() end

local event_table = {}

local function GetTable()
    local out = {}
    for event, hooklist in pairs(event_table) do
        out[event] = {}
        ::startloop::
            out[event][hooklist[2]] = hooklist[4]
            hooklist = hooklist[3]
        if (hooklist) then
            goto startloop
        end
    end
    return out
end

local function Remove(event, name)
    if (not name) then
        return
    end

    local hook = event_table[event]
    if (not hook) then
        return
    end

    local found = false

    local event_start = hook
    ::startloop::
        if (hook[2] == name) then

            if (hook == event_start) then
                event_table[event] = hook[3]
            end

            local last, next = hook[5], hook[3]
            if (last) then
                last[3] = hook[3]
            end
            if (next) then
                next[5] = hook[5]
            end
            found = true
            goto breakloop
        end
        hook = hook[3]
    if (hook) then
        goto startloop
    end
    ::breakloop::

    if (not found) then
        return
    end

    local start = event_table[event]
    if (not start) then
        return
    end
end

local function Add(event, name, fn, priority)
    assert(event ~= nil, "bad argument #1 to 'Add' (value expected)")
    if (not name or not fn) then
        return
    end
    local real_fn = fn
    if (type(name) ~= "string") then
        fn = function(...)
            if (IsValid(name)) then
                local a, b, c, d, e, f = real_fn(name, ...)
                if (a ~= nil) then
                    return a, b, c, d, e, f
                end
                return
            end

            Remove(event, name)
        end
    end

    local hook = event_table[event]

    local new_hook
    local found = false

    if (hook) then
        ::startloop::
            if (hook[2] == name) then
                new_hook = hook
                found = true
                goto breakloop
            end
            hook = hook[3]
        if (hook) then
            goto startloop
        end
    end
    ::breakloop::

    if (not priority) then
        priority = 0
    end

    if (found) then
        new_hook[1] = fn
        new_hook[4] = real_fn
        if (new_hook[6] == priority) then
            return
        end

        -- WARNING: UNDEFINED BEHAVIOR WARNING doing this inside another hook with earlier priority than the hook running WILL run the hook again
        Remove(event, name)
        new_hook[6] = priority
        new_hook[3]     = nil
        new_hook[5]     = nil
    else
        new_hook = {
            fn,
            name,
            nil,
            real_fn,
            nil,
            priority
        }
    end

    -- find link in hook list to add to

    hook = event_table[event]
    local event_start = hook

    if (hook) then
        local lasthook
        ::startloop2::
            if (hook[6] <= priority) then
                if (lasthook) then
                    lasthook[3] = new_hook
                end
                hook[5] = new_hook
                new_hook[3] = hook
                new_hook[5] = lasthook
                if (event_start ~= hook) then
                    return
                end
                goto breakloop2
            end
            lasthook = hook
            hook = hook[3]
        if (hook) then
            goto startloop2
        else
            -- NOT SUITABLE IN TABLE, update at end
            lasthook[3] = new_hook
            return
        end
    end
    ::breakloop2::

    event_table[event] = new_hook
end

local function Call(event, gm, ...)
    -- TODO: hooks
    local hook = event_table[event]

    if (hook) then
        ::startloop::
            local a, b, c, d, e, f = hook[1](...)
            if (a ~= nil) then
                return a, b, c, d, e, f
            end

            hook = hook[3]
        if (hook) then
            goto startloop
        end
    end

    if (gm) then
        local fn = gm[event]
        if (fn) then
            return fn(gm, ...)
        end
    end
end

local gmod = gmod

local function Run(event, ...)
    return Call(event, gmod and gmod.GetGamemode() or nil, ...)
end

return {
    Remove = Remove,
    GetTable = GetTable,
    Add = Add,
    Call = Call,
    Run = Run,
    Priority = {
        NO_RETURN = math.huge -- not enforced, just should be followed
    }
}