local function load()
    local db = MINVENTORY_MYSQL

    function moat_add_saved_item(sid,item)
        print(sid,item)
        local q = db:query("INSERT INTO `moat_itemqueue` (steamid, item) VALUES ('" .. sid .. "','" .. MINVENTORY_MYSQL:escape(item) .. "');")
        q:start()  
    end

    function moat_give_saved_item(ply,item)
        ply:m_AddInventoryItem(item)
        m_SaveInventory(ply)
        m_SendInventoryToPlayer(ply)
    end

    function moat_give_saved_credits(ply,num)
        ply:m_GiveIC(num)
    end

    local function moat_check_saved_items(ply)
        local q = MINVENTORY_MYSQL:query("SELECT * FROM `moat_itemqueue` WHERE steamid = '" .. ply:SteamID64() .. "';")
        function q:onSuccess(data)
            if (not data[1]) then return end

            local sid = ply:SteamID()
            for i = 1, #data do
                timer.Create("moat_give_item_to" .. sid .. data[i].id,5,0,function()
                    if not IsValid(ply) then timer.Remove("moat_give_item_to" .. sid .. data[i].id) return end
                    local ply_inv = table.Copy(MOAT_INVS[ply])

                    if (not ply_inv or (ply_inv and not ply_inv["slot1"])) then
                        return
                    end

                    if (tonumber(data[i].item)) then
                        moat_give_saved_credits(ply, tonumber(data[i].item))
                    else
                        moat_give_saved_item(ply, util.JSONToTable(data[i].item))
                    end

                    local d = db:query("DELETE FROM moat_itemqueue WHERE id = " .. data[i].id .. ";")
                    d:start()
                    timer.Remove("moat_give_item_to" .. sid .. data[i].id)
                end)
            end
        end
        q:start()
    end

    hook.Add("PlayerInitialSpawn", "moat_check_for_saved_items",function(ply)
        timer.Simple(15, function()
            if (IsValid(ply)) then moat_check_saved_items(ply) end 
        end)
    end)

    concommand.Add("moat_send_item",function(ply,cmd,args)
        if (not moat.isdev(ply)) then return end
        
        if (not args[1] or not args[2] or not args[3]) or args[4] then 
            ply:ChatPrint('Invalid arguments: "[type=slot/ic]" "slot_num/ic_amount" "[steamid]"')
            return 
        end

        local slot_type = args[1]

        if (args[1] ~= "slot" and args[1] ~= "ic") then
            ply:ChatPrint("Invalid argument #1: Must be either 'slot' or 'ic'")
            return
        end

        local item_slot = tonumber(args[2])

        local steamid = args[3]

        if steamid:match("STEAM_") then
            steamid = util.SteamIDTo64(steamid)
        end

        if (slot_type == "slot") then
            if item_slot > ply:GetMaxSlots() then
                return
            end

            local ply_inv = table.Copy(MOAT_INVS[ply])

            if (not ply_inv or (ply_inv and not ply_inv["slot1"])) then
                m_LoadInventoryForPlayer(ply)
                return
            end

            local item = util.TableToJSON(ply_inv["slot" .. item_slot])
            if not item then
                ply:ChatPrint("Item doesn't exist or error.")
                return
            end

            moat_add_saved_item(steamid,item)
            m_RemoveInventoryItem(ply,item_slot,MOAT_INVS[ply]["slot" .. item_slot].c,1)
            ply:ChatPrint("Done.")
        elseif (slot_type == "ic") then
            if (not ply:m_HasIC(item_slot)) then 
                ply:ChatPrint("You don't have enough IC to send that amount.")
                return
            end

            ply:m_TakeIC(item_slot)
            moat_add_saved_item(steamid, tostring(item_slot))
            ply:ChatPrint("Done.")
        end
    end)
end


local function c()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end

if MINVENTORY_MYSQL then
    if c() then
        load()
    end
end

hook.Add("InitPostEntity","ItemGive",function()
    if not c() then 
        timer.Create("CheckItemGive",1,0,function()
            if c() then
                load()
                timer.Destroy("CheckItemGive")
            end
        end)
    else
        load()
    end

end)