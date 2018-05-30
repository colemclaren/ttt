mlogs.net = mlogs.net or {}

if (CLIENT) then
	function mlogs.SendToServer(id, cb)
		net.Start(id)
		if (cb) then cb() end
		net.SendToServer()
	end

	return
end

function mlogs.net:Load(id)
	util.AddNetworkString(id)
end

function mlogs.Send(id, pl, cb)
	net.Start(id)
	if (cb) then cb() end
	net.Send(pl)
end

function mlogs.Broadcast(id, cb)
	net.Start(id)
	if (cb) then cb() end
	net.Broadcast()
end

-- credit meepen https://steamcommunity.com/profiles/76561198050165746
local interval = engine.TickInterval()
local max_per_interval = 30000 * interval
function mlogs.BreakableMessage(data, i)
    i = i or 1
    local datas = data.datas

	if (not datas[i]) then return data.callback() end
	if (not data.checkfn(datas[i])) then i = i + 1 return BreakableMessage(data, i) end

    data.startfn(i)
        while (datas[i]) do
			if (not checkfn(datas[i])) then i = i + 1 continue end
            net.WriteBool(true)
            data.writefn(i, datas[i])
            i = i + 1
            if (net.BytesWritten() >= max_per_interval) then
                break
            end
        end
        net.WriteBool(false)
    data.endfn()

    if (datas[i]) then
        timer.Simple(0, function()
            return BreakableMessage(data, i)
        end)
    else
        return data.callback()
    end
end


/*
wip schema layout

CREATE TABLE IF NOT EXISTS mlogs_autoslays (
	slayid int unsigned not null AUTO_INCREMENT unique,
	playerid int unsigned not null,
	staffid int unsigned not null,
	amount smallint unsigned not null,
	served smallint unsigned not null,
	reason varchar(200) not null,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FOREIGN KEY (playerid) REFERENCES mlogs_players(id) ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS mlogs_players (
    id int unsigned not null AUTO_INCREMENT unique,
	steam_id bigint(17) not null,
	nick varchar(32) not null,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS mlogs_servers (
    id int unsigned not null AUTO_INCREMENT unique,
	serverip varchar(21) not null,
	hostname varchar(255) not null,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS mlogs_weapons (
    id int unsigned not null AUTO_INCREMENT unique,
	classname varchar(255) not null,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS mlogs_rounds (
    id int unsigned not null AUTO_INCREMENT unique,
    serverid tinyint unsigned not null,
    round tinyint unsigned not null,
	map varchar(255) unsigned not null,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

*/