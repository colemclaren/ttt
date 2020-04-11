local ORM = include "mysql/sql_mysqloo.lua"

function mlogs:LastInsertID()
    return "LAST_INSERT_ID()" --mlogs.sql:Function("LAST_INSERT_ID")
end

function mlogs:qf(str, ...)
	local args = {n = select("#", ...), ...}
	return self.sql:CreateQuery(str, unpack(args, 1, args.n))
end

function mlogs:query(str, succ, err)
	str = str:Replace("{database}", self.Database)

    mlogs.sql:Query(str, succ, err or function(q, er)
		mlogs:Print("Query Error: " .. tostring(er) .. " | With Query: " .. tostring(str))
    end)
end

function mlogs:q(str, ...)
    local args = {n = select("#", ...), ...}
    local succ, err = isfunction(args[args.n]), isfunction(args[args.n - 1])
	if (succ) then
		succ, err = err and args[args.n - 1] or args[args.n], err and args[args.n] or nil
		args.n = args.n - (err and 2 or 1)
	end

	str = self.sql:CreateQuery(str, unpack(args, 1, args.n))
    self:query(str, succ, err)
end

function mlogs:qq(str, succ, err)
	self:query(str, false, false)
end

hook("SQLConnected", function(db)
	mlogs.sql = ORM(db)
	hook.Run("mlogs.sql", mlogs)
	mlogs:Print "established connection to sql"
end)







/*
wip schema layout


DROP TABLE IF EXISTS moat_logs.mlogs_players;
CREATE TABLE moat_logs.mlogs_players (
    pid int unsigned not null AUTO_INCREMENT,
	steam_id bigint unsigned not null unique,
	name varchar(32) not null,
    PRIMARY KEY (pid)
);

DROP TABLE IF EXISTS moat_logs.mlogs_servers;
CREATE TABLE moat_logs.mlogs_servers (
    sid tinyint unsigned not null AUTO_INCREMENT,
	serverip varchar(21) not null unique,
	hostname varchar(255) not null,
    PRIMARY KEY (sid)
);

DROP TABLE IF EXISTS moat_logs.mlogs_maps;
CREATE TABLE moat_logs.mlogs_maps (
	mid smallint unsigned not null AUTO_INCREMENT,
	map varchar(50) not null unique,
	PRIMARY KEY (mid)
);

DROP TABLE IF EXISTS moat_logs.mlogs_weapons;
CREATE TABLE moat_logs.mlogs_weapons (
    wid smallint unsigned not null AUTO_INCREMENT,
	class varchar(32) not null unique,
	name varchar(255) default null,
    PRIMARY KEY (wid)
);

DROP TABLE IF EXISTS moat_logs.mlogs_hooks;
CREATE TABLE moat_logs.mlogs_hooks (
	hid tinyint unsigned not null AUTO_INCREMENT,
	hook_name varchar(32) not null unique,
	hook_type varchar(6) not null,
	hook_display varchar(255) not null,
	hook_keys tinyint unsigned not null,
	PRIMARY KEY(hid)
);

DROP TABLE IF EXISTS moat_logs.mlogs_hooks_info;
CREATE TABLE moat_logs.mlogs_hooks_info (
	hooks_id tinyint unsigned not null,
	hooks_key tinyint not null,
	key_default varchar(255) not null,
	CONSTRAINT FOREIGN KEY (hooks_id) REFERENCES moat_logs.mlogs_hooks(hid) ON DELETE CASCADE,
	PRIMARY KEY (hooks_id, hooks_key), INDEX(hooks_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_rounds;
CREATE TABLE moat_logs.mlogs_rounds (
    rid bigint unsigned not null AUTO_INCREMENT,
    server_id tinyint unsigned not null,
    round smallint unsigned not null,
	length int unsigned not null,
	outcome tinyint unsigned not null,
	map_id smallint unsigned not null,
    date timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT FOREIGN KEY (server_id) REFERENCES moat_logs.mlogs_servers(sid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (map_id) REFERENCES moat_logs.mlogs_maps(mid) ON DELETE CASCADE,
    PRIMARY KEY (rid), INDEX(server_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_events;
CREATE TABLE moat_logs.mlogs_events (
	eid bigint unsigned not null AUTO_INCREMENT,
    round_id bigint unsigned not null,
	round_time int unsigned not null,
	hook_id tinyint unsigned not null,
	CONSTRAINT FOREIGN KEY (round_id) REFERENCES moat_logs.mlogs_rounds(rid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (hook_id) REFERENCES moat_logs.mlogs_hooks(hid) ON DELETE CASCADE,
	PRIMARY KEY (eid), INDEX(round_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_events_damage;
CREATE TABLE moat_logs.mlogs_events_damage (
	events_id bigint unsigned not null,
	attacker_id int unsigned not null,
	victim_id int unsigned not null,
	weapon_id smallint unsigned not null,
	damage smallint unsigned not null,
	CONSTRAINT FOREIGN KEY (events_id) REFERENCES moat_logs.mlogs_events(eid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (attacker_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (victim_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (weapon_id) REFERENCES moat_logs.mlogs_weapons(wid) ON DELETE CASCADE,
	PRIMARY KEY (events_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_events_shots;
CREATE TABLE moat_logs.mlogs_events_shots (
	events_id bigint unsigned not null,
	player_id int unsigned not null,
	weapon_id smallint unsigned not null,
	possibly_at varbinary(32) default null,
	witness_ids varbinary(32) default null,
	CONSTRAINT FOREIGN KEY (events_id) REFERENCES moat_logs.mlogs_events(eid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (player_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (weapon_id) REFERENCES moat_logs.mlogs_weapons(wid) ON DELETE CASCADE,
	PRIMARY KEY (events_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_events_player;
CREATE TABLE moat_logs.mlogs_events_player (
	events_id bigint unsigned not null,
	player_id int unsigned not null,
	player_val varchar(255) default null,
	CONSTRAINT FOREIGN KEY (events_id) REFERENCES moat_logs.mlogs_events(eid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (player_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	PRIMARY KEY (events_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_events_players;
CREATE TABLE moat_logs.mlogs_events_players (
	events_id bigint unsigned not null,
	player_id1 int unsigned not null,
	player_id2 int unsigned not null,
	player_val1 varchar(255) default null,
	player_val2 varchar(255) default null,
	CONSTRAINT FOREIGN KEY (events_id) REFERENCES moat_logs.mlogs_events(eid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (player_id1) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (player_id2) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	PRIMARY KEY (events_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_events_other;
CREATE TABLE moat_logs.mlogs_events_other (
	events_id bigint unsigned not null,
	event_key tinyint unsigned not null,
	event_val varchar(255) not null,
	CONSTRAINT FOREIGN KEY (events_id) REFERENCES moat_logs.mlogs_events(eid) ON DELETE CASCADE,
	PRIMARY KEY (events_id, event_key), INDEX(events_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_events_witness;
CREATE TABLE moat_logs.mlogs_events_witness (
	events_id bigint unsigned not null,
	player_ids varbinary(32) not null,
	CONSTRAINT FOREIGN KEY (events_id) REFERENCES moat_logs.mlogs_events(eid) ON DELETE CASCADE,
    PRIMARY KEY (events_id)
);


DROP TABLE IF EXISTS moat_logs.mlogs_event;
CREATE TABLE moat_logs.mlogs_event (
	eid bigint unsigned not null AUTO_INCREMENT,
    round_id bigint unsigned not null,
	round_time int unsigned not null,
	hook_id tinyint unsigned not null,
	player_id1 int unsigned default null,
	player_id2 int unsigned default null,
	weapon_id1 smallint unsigned default null,
	weapon_id2 smallint unsigned default null,
	num_info int unsigned default null,
	str_info varchar(255) default null,
	CONSTRAINT FOREIGN KEY (round_id) REFERENCES moat_logs.mlogs_rounds(rid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (hook_id) REFERENCES moat_logs.mlogs_hooks(hid) ON DELETE CASCADE,
	FOREIGN KEY (player_id1) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	FOREIGN KEY (player_id2) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	FOREIGN KEY (weapon_id1) REFERENCES moat_logs.mlogs_weapons(wid) ON DELETE CASCADE,
	FOREIGN KEY (weapon_id2) REFERENCES moat_logs.mlogs_weapons(wid) ON DELETE CASCADE,
	PRIMARY KEY (eid), INDEX(round_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_event;
CREATE TABLE moat_logs.mlogs_event (
	eid bigint unsigned not null AUTO_INCREMENT,
    round_id bigint unsigned not null,
	round_time int unsigned not null,
	event_id tinyint unsigned not null,
	player_id1 int unsigned default null,
	player_id2 int unsigned default null,
	weapon_id smallint unsigned default null,
	num_info int unsigned default null,
	str_info varchar(255) default null,
	CONSTRAINT FOREIGN KEY (round_id) REFERENCES moat_logs.mlogs_rounds(rid) ON DELETE CASCADE,
	FOREIGN KEY (player_id1) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	FOREIGN KEY (player_id2) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	FOREIGN KEY (weapon_id) REFERENCES moat_logs.mlogs_weapons(wid) ON DELETE CASCADE,
	PRIMARY KEY (eid), INDEX(round_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_event_witness;
CREATE TABLE moat_logs.mlogs_event_witness (
	event_id bigint unsigned not null,
	player_id int unsigned not null,
	CONSTRAINT FOREIGN KEY (event_id) REFERENCES moat_logs.mlogs_event(eid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (player_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	PRIMARY KEY(event_id, player_id), INDEX(event_id)
);



DROP TABLE IF EXISTS moat_logs.mlogs_roles;
CREATE TABLE moat_logs.mlogs_roles (
	round_id bigint unsigned not null,
	player_id int unsigned not null,
	role tinyint unsigned not null,
	CONSTRAINT FOREIGN KEY (round_id) REFERENCES moat_logs.mlogs_rounds(rid) ON DELETE CASCADE,
	PRIMARY KEY (round_id, player_id), INDEX(round_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_reports;
CREATE TABLE moat_logs.mlogs_reports (
	report_id int unsigned not null AUTO_INCREMENT,
	status tinyint unsigned not null,
	round_id bigint unsigned not null,
	victim_id int unsigned not null,
	victim_msg varchar(255) not null,
	player_id int unsigned not null,
	player_msg varchar(255) default null,
	staff_id int unsigned default null,
	staff_msg varchar(255) default null,
	chat_id int unsigned default null,
	date_created timestamp DEFAULT CURRENT_TIMESTAMP,
	date_updated timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT FOREIGN KEY (round_id) REFERENCES moat_logs.mlogs_rounds(rid),
	CONSTRAINT FOREIGN KEY (victim_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (player_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (staff_id) REFERENCES moat_logs.mlogs_players(pid),
    PRIMARY KEY (report_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_reports_active;
CREATE TABLE moat_logs.mlogs_reports_active (
	report int unsigned not null,
	CONSTRAINT FOREIGN KEY (report) REFERENCES moat_logs.mlogs_reports(report_id) ON DELETE CASCADE,
	PRIMARY KEY (report)
);

DROP TABLE IF EXISTS moat_logs.mlogs_reports_chats;
CREATE TABLE moat_logs.mlogs_reports_chats (
	chat_id int unsigned not null AUTO_INCREMENT,
	report int unsigned not null,
	CONSTRAINT FOREIGN KEY (report) REFERENCES moat_logs.mlogs_reports(report_id) ON DELETE CASCADE,
	PRIMARY KEY (chat_id)
);

DROP TABLE IF EXISTS moat_logs.mlogs_reports_chatlogs;
CREATE TABLE moat_logs.mlogs_reports_chatlogs (
	chat int unsigned not null,
	sender_id int unsigned not null,
	sender_msg varchar(255) not null,
	time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FOREIGN KEY (chat) REFERENCES moat_logs.mlogs_reports_chats(chat_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS moat_logs.mlogs_autoslays;
CREATE TABLE moat_logs.mlogs_autoslays (
	slay_id int unsigned not null AUTO_INCREMENT,
	player_id int unsigned not null,
	staff_id int unsigned not null,
	amount tinyint unsigned not null,
	served tinyint unsigned not null,
	reason varchar(255) not null,
	date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FOREIGN KEY (player_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (staff_id) REFERENCES moat_logs.mlogs_players(pid) ON DELETE CASCADE,
    PRIMARY KEY (slay_id), INDEX(player_id)
);

*/

/*
wip procedures


DROP PROCEDURE IF EXISTS moat_logs.GetPlayerInfo;
DELIMITER $$
CREATE PROCEDURE moat_logs.GetPlayerInfo(in steamid64 bigint, in nick varchar(32)) 
BEGIN
	UPDATE moat_logs.mlogs_players SET name = nick WHERE steam_id = steamid64;
	if (ROW_COUNT() = 0) then
		INSERT IGNORE INTO moat_logs.mlogs_players (steam_id, name) VALUES (steamid64, nick) ON DUPLICATE KEY UPDATE name = VALUES(name);
	end if;

	SELECT p.pid as player_id, s.slay_id, s.staff_id, si.name as staff_name, CAST(si.steam_id AS char) as staff_steamid, s.amount, s.served, s.reason, UNIX_TIMESTAMP(s.date) as slay_date
	FROM moat_logs.mlogs_players as p 
    	LEFT JOIN moat_logs.mlogs_autoslays as s
        	ON s.player_id = p.pid AND amount > served 
    	LEFT JOIN moat_logs.mlogs_players as si
        	ON si.pid = s.staff_id 
    	WHERE p.steam_id = steamid64 GROUP BY slay_id;
END; $$
DELIMITER ;

DROP PROCEDURE IF EXISTS moat_logs.GetAutoSlays;
DELIMITER $$
CREATE PROCEDURE moat_logs.GetAutoSlays(in playerid int) 
BEGIN
	SELECT s.slay_id, s.player_id, pi.name as player_name, s.staff_id, si.name as staff_name, CAST(si.steam_id AS char) as staff_steamid, s.amount, s.served, s.reason, UNIX_TIMESTAMP(s.date) as slay_date
	FROM moat_logs.mlogs_autoslays as s 
    	LEFT JOIN moat_logs.mlogs_players as pi 
        	ON s.player_id = pi.pid AND amount > served 
    	LEFT JOIN moat_logs.mlogs_players as si 
        	ON s.staff_id = si.pid 
    	WHERE s.player_id = playerid GROUP BY slay_id;
END; $$
DELIMITER ;


*/