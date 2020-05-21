util.AddNetworkString "Moat.Typing"

local typing_net_cd = .5 -- 1 sec net cooldown
local typing_net = {}
function typing_net_spam(ply, msg)
	if (not typing_net[ply]) then
		typing_net[ply] = {}
		return false
	end

	if (not typing_net[ply][msg]) then
		typing_net[ply][msg] = CurTime() + typing_net_cd
		return false
	end

	if (typing_net[ply][msg] and typing_net[ply][msg] > CurTime()) then
		return true
	end

	typing_net[ply][msg] = CurTime() + typing_net_cd

	return false
end

net.Receive("Moat.Typing", function(_, pl)
	if (typing_net_spam(pl, "Moat.Typing")) then return end

	local is = net.ReadBool()

	if (not is and pl.StartedTyping) then
		pl.StartedTyping = nil

		net.Start "Moat.Typing"
			net.WritePlayer(pl)
			net.WriteBool(false)
		net.Broadcast()
	elseif (not pl.StartedTyping) then
		pl.StartedTyping = CurTime()

		net.Start "Moat.Typing"
			net.WritePlayer(pl)
			net.WriteBool(true)
		net.Broadcast()
	else
		if (not pl.StartedTyping or (pl.StartedTyping and CurTime() - pl.StartedTyping >= 1)) then
			net.Start "Moat.Typing"
				net.WritePlayer(pl)
				net.WriteBool(true)
			net.Broadcast()
		end

		pl.StartedTyping = CurTime()
	end
end)

local bON = include '_bon.lua'

local bait = {
	'please stop swearing {target}.',
	'no swearing in public chat {target}! I\'ve reported you!',
	'reported {target} for swearing!',
	'{target} reported!',
	'{target}, reported for swearing',
	'If my mouth was as filthy as {target}\'s I\'d be a sailor.',
	'Do you talk to your mother that way, {target}?',
	'I reported {target}... gosh stop cussing...',
	'This isn\'t the army, {target}, watch your language.',
	'We are lucky the FCC doesn\'t regulate Garry\'s Mod, or else we would be in trouble with {target}\'s potty mouth.',
	'I voted for Sarah Palin in 2008 so I would not have to hear garbage like {target} just said.',
	'Enabling the profanity filter does not give you free reign to speak with crude language {target}.',
	'That language is not acceptable in my kitchen, {target}! - Chef Gordon Ramsay ',
	'AFK a second, I need to put on my sunglasses, the swear word that {target} just said blinded me.',
	'Oh look at {target} using those big swear words again, if you keep it up, you might be able to wear big boy underwear soon!',
	'HEY EVERYONE LOOK! {target} is trying to mimic the big boys! Go and play, {target}, the sandbox is lonely without you!',
	'Player {target} has been reported for his/her vulgar language.',
	'I know {target} is trying to be a big boy gamer with that language, but they\'re just a fake gamer. Don\'t be fooled. Reported!',
	'Don\'t say words like that, {target}.  There are children playing.',
	'republican dps, looking for group that doesn\'t swear like {target}, send me a pst',
	'I reported you for swearing {target}.',
	'Yo man I\'m really happy for you and I\'m gonna let you finish, but {target} has one of the biggest pottymouths of all time... Of all time!',
	'Rita died in dexter cause {target} still cusses like a child, how many more victims does he need to claim?', 
	'It\'s bad enough that you\'re playing Wildstar, do you have to make yourself look like more of a nerd by swearing {target}?',
	'watch your mouth {target}...',
	'{target}, swearing is for nerds!',
	'{target} I love you, but I can\'t be with someone who still swears like a 12 year old...',
	'What the fudge did you just swear {target}, you little n00b? I\'ll have you know I\'m a rank 1 challenger Traitor and have done raids on every 10 man planetary content. I also partner with reckful and have reflexes like fatal1ty. You are nothing to me but just an abusive pottymouth. I will pwn the fudge out of you with Arcane Pears the likes of which has never been seen before on innocent motel AND canyon, mark my frickin words.',
	'Hey {target}, I heard swearing is cool',
	'\'Now listen here {target}. What I\'m sayin\' to you is the honest truth. stop swearing you\'ll be safe.\' -Applejack',
	'Hey {target}, chill out with the swearing.',
	'Where\'d you learn how to swear like that, {target}? I thought I raised you better than that, kiddo.',
	'{target}\'s relentless swearing habits is almost as bad as the American patriarchy keeping the individual non-cis and womyn at the bottom.',
	'<Reddit Gamer Girls>, the number 1 all female sponsored raiding guild does not approve {target}\'s use of bad words. Please refrain from doing so, thank you.',
	'\'I have never wished to cater to potty mouthes like {target}; for what I know they do not approve, and what they approve I do not know.\' -Epicurus',
	'beiber is waaaaaaayyyyyyy cuiter then {target} lol and he dosnt swear, loser ;P',
	'{target}, All the swearers and cursers will look up and shout \'Save us!\'... and I\'ll look down and whisper \'No.\'',
	'{target}\'s swearing has been holding back good players longer than this misogynistic country has been holding back strong womyn.',
	'9/11 was an inside job but it was not nearly as bad as the terror caused by {target}\'s swearing.',
	'waterboarding isn\'t torture, but {target}\'s potty mouth sure is',
	'Oh dear what can I do, {target} swore and I\'m feeling blue',
	'I-it\'s not like I need your swearing or anything {target}-sama...',
	'Razer sponsored me because I don\'t swear {target}, why do you feel the need to do it?',
	'lady gaga might have a bad romance but {target} has a really bad mouth!!',
	'\'Suffer {target}, as your pathetic potty mouth betrays you!\' -Deathwing',
	'Genesis 1:31: And God saw every thing that he had made, and, behold, it was very good. Except for {target}\'s dirty mouth.',
	'\"Put away from you crooked speech, and put devious talk far from you {target}.\" -Proverbs 4:24',
	'Please no swearing {target}.',
	'{target}\'s sharp tongue will be cut out like Robb Stark\'s unborn child on his wedding night.',
	'\'heh... expeliarmous of {target}\'s bad mouth\' - potter 2002',
	'Do you kiss your mother with that mouth {target}?',
	'i think {target} is a pretty cool guy, eh swears and doesnt afraid of anything...',
	'I\'m on remote chat at the club and even I\'m offended by {target}\'s swearing',
	'Hey {target}, stop fucking swearing!',
	'\'Oh! It\'s my tail! It\'s my tail! It\'s a-twitch a-twitchin\'! And {target}, you know what that means! The twitchin\' means my Pinkie Sense is telling me your swearing is dumb!\' -Pinkie Pie',
	'{target}\'s potty mouth is almost as shocking as the time Ned Stark was beheaded for treason against the king.',
	'{target} \'s words are giving me a crushing headache like Oberyn Martell often gets.',
	'Excuse me {target}, was you sayin\' somethin\'? Uh uh, you can\'t tell me nothin\'',
	'Hey {target}, real men don\'t swear.',
	'{target} keeps it 300, like the Romans. 300 swearwords, where\'s\' the Trojans?',
	'Please no swearing.',
	'Can you please stop swearing {target}?',
	'\"{target}, you\'re a wizard so do me a favor and wizz those words away\" -Hagrid',
	'The plan was to drink until the pain over, but what\'s worse: {target}\'s swearing or the hangover?',
	'{target} was a fookin\' legend in Gin Alley, but here he\'s just another brick in the wall.',
	'-6 x 6 x 6 = 0, and swearing + bad at this game + 12 = {target}.'
}
-- 	
local strs = string.Trim(file.Read("banned_words_list.txt", "DATA"))
mylist = bON.deserialize(strs)
replacements = {}

function combinations(s1, s2, key)
	if (s2:len() > 0) then
		local c = s2:sub(1, 1)
		local l = c:lower()
		local u = c:upper()
		if l == u then
			combinations(s1 .. c, s2:sub(2), key)
		else
			combinations(s1 .. l, s2:sub(2), key)
			combinations(s1 .. u, s2:sub(2), key)
		end
	else
		replacements[s1] = replacements[key]
	end
end

function FamilyFriendly(str, pl)
	local baited

	if (pl and IsValid(pl)) then
		-- if (pl:GetInfo('moat_safety') ~= "1") then return str end
		baited = string.gsub(bait[math.random(1, #bait)], '{target}', pl:Nick())
	end

	local lower = str:gsub('​', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub('⠀', '')

	if (not replacements['xxx']) then
		mylist = bON.deserialize(string.Trim(file.Read("banned_words_list.txt", "DATA")))
		replacements = {}
		for k, v in ipairs(mylist) do
			if (not v.safe or (v.safe and istable(v.safe) and not v.safe[1])) then
				replacements[v.bad] = string.rep('*', string.len(v.bad))
			else
				replacements[v.bad] = v.safe
			end

			-- combinations("", v.bad, v.bad)
		end
	end

	local swore = 0
	local new = string.gsub(lower, '%w+', function(s)
		local l = string.lower(s)

		if (replacements[l]) then
			swore = swore + 1
		end

		return istable(replacements[l]) and replacements[l][math.random(1, #replacements[l])] or replacements[l] or s
	end)

	if (swore == 0 and baited) then
		local warn = string.lower(new)
		for k, v in ipairs(mylist) do
			if (not v.bad) then continue end
			if (v.bad and #v.bad <= 3) then continue end
			if (v.bad and string.find(warn, v.bad)) then
				return baited
			end
		end
	end

	return swore > 0 and new or str
end


function LoadFilter()
	local strs = string.Trim(file.Read("banned_words_list.txt", "DATA"))
	mylist = bON.deserialize(strs)
	replacements = {}
	for k, v in ipairs(mylist) do
		if (not v.safe or (v.safe and istable(v.safe) and not v.safe[1])) then
			replacements[v.bad] = string.rep('*', string.len(v.bad))
		else
			replacements[v.bad] = v.safe
		end

		-- combinations("", v.bad, v.bad)
	end
end

local str = FamilyFriendly("fuck me")
if (str == "fuck me") then
	local strs = string.Trim(file.Read("banned_words_list.txt", "DATA"))
	mylist = bON.deserialize(strs)
	replacements = {}
	for k, v in ipairs(mylist) do
		if (not v.safe or (v.safe and istable(v.safe) and not v.safe[1])) then
			replacements[v.bad] = string.rep('*', string.len(v.bad))
		else
			replacements[v.bad] = v.safe
		end

		-- combinations("", v.bad, v.bad)
	end
end

-- http.Fetch('https://raw.githubusercontent.com/RobertJGabriel/Google-profanity-words/master/list.txt', function(b)
-- 	local words = string.Explode('\n', b)
-- 	PrintTable(words)

-- 	banned_words = banned_words or {}
-- 	for k, v in ipairs(words) do
-- 		http.Fetch('http://api.datamuse.com/sug?s=' .. string.TrimRight(v, 's') .. '&max=1000', function(b)
-- 			local word, sug = util.JSONToTable(b), 0
-- 			local me = table.insert(banned_words, {bad = v, safe = {}})

-- 			sug = sug + 1

-- 			if (word and word[sug] and word[sug].word) then
-- 				table.sort(word, function(a, b) return (a['score'] and a.score or -10000) >(b['score'] and b.score or -10000) end)
-- 				http.Fetch('http://api.datamuse.com/words?rel_nry=' .. word[sug].word .. '&max=1000', function(nry)
-- 					local rel_nry = util.JSONToTable(nry)
-- 					if (rel_nry and rel_nry[1] and rel_nry[1].word) then
-- 						table.sort(rel_nry, function(a, b) return (a['score'] and a.score or -10000) >(b['score'] and b.score or -10000) end)
-- 						table.sort(rel_nry, function(a, b) return (a['numSyllables'] and a.numSyllables or 0) > (b['numSyllables'] and b.numSyllables or 0) end)

-- 						for i = 1, 50 do
-- 							if (rel_nry[i] and rel_nry[i].word and (#rel_nry[i].word > 4) and not table.HasValue(banned_words[me].safe, rel_nry[i].word) and not table.HasValue(words, rel_nry[i].word)) then 
-- 								table.insert(banned_words[me].safe, rel_nry[i].word)
-- 							end
-- 						end
-- 					end

-- 					http.Fetch('http://api.datamuse.com/words?rel_rhy=' .. word[sug].word .. '&max=1000', function(rhy)
-- 						local rel_rhy = util.JSONToTable(rhy)
-- 						if (rel_rhy and rel_rhy[1] and rel_rhy[1].word) then
-- 							table.sort(rel_rhy, function(a, b) return (a['score'] and a.score or -10000) >(b['score'] and b.score or -10000) end)
-- 							table.sort(rel_rhy, function(a, b) return (a['numSyllables'] and a.numSyllables or 0) > (b['numSyllables'] and b.numSyllables or 0) end)

-- 							for i = 1, 50 do
-- 								if (rel_rhy[i] and rel_rhy[i].word and (#rel_rhy[i].word > 4) and not table.HasValue(banned_words[me].safe, rel_rhy[i].word) and not table.HasValue(words, rel_rhy[i].word)) then 
-- 									table.insert(banned_words[me].safe, rel_rhy[i].word)
-- 								end
-- 							end
-- 						end

-- 						print(me, #banned_words[me])
-- 						PrintTable(banned_words[me])

-- 						lua_run local bON = include 'plugins/moat/modules/chat/_bon.lua' file.Write("replaced_words.txt", bON.serialize(banned_words))
-- 					end)
-- 				end)
-- 			end
-- 		end)
-- 	end
-- end)