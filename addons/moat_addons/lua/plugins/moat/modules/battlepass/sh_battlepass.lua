if not MOAT_BP then MOAT_BP = {} end
MOAT_BP.Examples = {}
MOAT_BP.tiers = {}
--xp_needed = 2000

local function add_tier_item( name, rarity, model, ID, effect)
    table.insert(MOAT_BP.tiers,{
        name = name,
        rarity = rarity,
        model = model,
        effect = effect or "",
        ID = ID
    })
end
--Custom itemids:
-- -1 = 5000 ic
-- -2 = 10000 ic


function MOAT_BP.AddExample(itemid,itemtbl)
    MOAT_BP.Examples[itemid] = itemtbl
end

if CLIENT then
    net.Receive("BP.ItemExample",function()
        MOAT_BP.AddExample(net.ReadInt(16),net.ReadTable())
    end)
end


add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 2

add_tier_item("Aperture Containment Model",5,"models/player/aphaztech.mdl",45,"")

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 12

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 22

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 32

add_tier_item("Veteran Soldier Model",5,"models/player/clopsy.mdl",46,"")

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 42

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 52

add_tier_item("Stormtrooper Model",5,"models/player/stormtrooper.mdl",53,"")

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 62

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 72

add_tier_item("Ash Ketchum Model",6,"models/player/red.mdl",50,"")

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 82

add_tier_item("10,000 Inventory Credits",5,"https://i.imgur.com/cGxlQEx.png",-2,"") -- Level 92

add_tier_item("Zelda Model",6,"models/player/zelda.mdl",49,"") -- SHould be last 10 since it's probably the best model

for i = #MOAT_BP.tiers + 1,100 do
    add_tier_item("Tiers so it doesnt error " .. i,math.random(4,9),"https://i.imgur.com/cGxlQEx.png",-2,"")
end


-- Default examples, save on networking
MOAT_BP.AddExample(45,{c="2418047474",u=45,item={Collection="Summer Climb Collection",Description="The Enrichment Center is committed to the well being of all participants.",ID=45,Kind="Model",Model="models/player/aphaztech.mdl",Name="Aperture Containment Model",Rarity=5}})
MOAT_BP.AddExample(46,{c="4212134612",u=46,item={Collection="Summer Climb Collection",Description="He's seen some stuff.",ID=46,Kind="Model",Model="models/player/clopsy.mdl",Name="Veteran Soldier Model",Rarity=5}})
MOAT_BP.AddExample(53,{c="1076176869",u=53,item={Collection="Summer Climb Collection",Description="Victory is written in the stars.",ID=53,Kind="Model",Model="models/player/stormtrooper.mdl",Name="Stormtrooper Model",Rarity=5}})
MOAT_BP.AddExample(50,{c="283382723",u=50,item={Collection="Summer Climb Collection",Description="Gotta catch em all.",ID=50,Kind="Model",Model="models/player/red.mdl",Name="Ash Ketchum Model",Rarity=6}})
MOAT_BP.AddExample(49,{c="2451093735",u=49,item={Collection="Summer Climb Collection",Description="It's dangerous to go alone! Take this... model.",ID=49,Kind="Model",Model="models/player/zelda.mdl",Name="Zelda Model",Rarity=6}})
