util.AddNetworkString "Moat.Typing"

net.Receive("Moat.Typing", function(_, pl)
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
	"please stop swearing " .. "{player}" .. ".",
	"no swearing in public chat " .. "{player}" .. "! I've reported you!",
	"reported " .. "{player}" .. " for swearing!",
	"{player}" .. " reported!",
	"{player}" .. ", reported for swearing",
	"If my mouth was as filthy as " .. "{player}" .. "'s I'd be a sailor.",
	"Do you talk to your mother that way, " .. "{player}" .. "?",
	"I reported " .."{player}".. "... gosh stop cussing...",
	"This isn't the army, " .. "{player}" .. ", watch your language.",
	"We are lucky the FCC doesn't regulate WoW, or else we would be in trouble with " .. "{player}" .. "'s potty mouth.",
	"I voted for Sarah Palin in 2008 so I would not have to hear garbage like " .. "{player}" .. " just said.",
	"Enabling the profanity filter does not give you free reign to speak with crude language " .. "{player}" .. ".",
	"That language is not acceptable in my kitchen, " .. "{player}" .. "! - Chef Gordon Ramsay ",
	"AFK a second, I need to put on my sunglasses, the swear word that " .. "{player}" .. " just said blinded me.",
	"Oh look at " .. "{player}" .. " using those big swear words again, if you keep it up, you might be able to wear big boy underwear soon!",
	"HEY EVERYONE LOOK! " .. "{player}" .. " is trying to mimic the big boys! Go and play, " .. "{player}" .. ", the sandbox is lonely without you!",
	"Player " .. "{player}" .. " has been reported for his/her vulgar language.",
	"I know " .. "{player}" .. " is trying to be a big boy gamer with that language, but they're just a fake gamer. Don't be fooled. Reported!",
	"Don't say words like that, " .. "{player}" .. ".  There are children playing.",
	"republican dps, looking for group that doesn't swear like " .. "{player}" .. ", send me a pst",
	"I reported you for swearing " .. "{player}" .. ".",
	"Yo man I'm really happy for you and I'm gonna let you finish, but ".. "{player}" .. " has one of the biggest pottymouths of all time... Of all time!",
	"Rita died in dexter cause " .. "{player}" .. " still cusses like a child, how many more victims does he need to claim?", 
	"It's bad enough that you're playing Wildstar, do you have to make yourself look like more of a nerd by swearing " .. "{player}" .. "?",
	"watch your mouth " .. "{player}" .. "...",
	"{player}" .. ", swearing is for nerds!",
	"" .. "{player}" .. " I love you, but I can't be with someone who still swears like a 12 year old...",
	"What the fudge did you just swear " .. "{player}" .. ", you little n00b? I'll have you know I'm a rank 1 challenger PVPer and have done raids on every 10 man heroic content. I also partner with reckful and have reflexes like fatal1ty. You are nothing to me but just an abusive pottymouth. I will pwn the fudge out of you with Arcane Missiles the likes of which has never been seen before on Azeroth AND Outland, mark my frickin words.",
	"Hey " .. "{player}" .. ", I heard swearing is cool",
	"'Now listen here " .. "{player}" .. ". What I'm sayin' to you is the honest truth. stop swearing you'll be safe.' -Applejack",
	"Hey " .. "{player}" .. ", chill out with the swearing.",
	"Where'd you learn how to swear like that, " .. "{player}" .. "? I thought I raised you better than that, kiddo.",
	"" .. "{player}" .. "'s relentless swearing habits is almost as bad as the American patriarchy keeping the individual non-cis and womyn at the bottom.",
	"<Reddit Gamer Girls>, the number 1 all female sponsored raiding guild does not approve " .. "{player}" .. "'s use of bad words. Please refrain from doing so, thank you.",
	"'I have never wished to cater to potty mouthes like " .. "{player}" .. "; for what I know they do not approve, and what they approve I do not know.' -Epicurus",
	"beiber is waaaaaaayyyyyyy cuiter then " .. "{player}" .. " lol and he dosnt swear, loser ;P",
	"" .. "{player}" .. ", All the swearers and cursers will look up and shout 'Save us!'... and I'll look down and whisper 'No.'",
	"" .. "{player}" .. "'s swearing has been holding back good players longer than this misogynistic country has been holding back strong womyn.",
	"9/11 was an inside job but it was not nearly as bad as the terror caused by " .. "{player}" .. "'s swearing.",
	"waterboarding isn't torture, but " .. "{player}" .. "'s potty mouth sure is",
	"Oh dear what can I do, " .. "{player}" .. " swore and I'm feeling blue",
	"I-it's not like I need your swearing or anything " .. "{player}" .."-sama...",
	"Razer sponsored me because I don\'t swear " .. "{player}" .. ", why do you feel the need to do it?",
	"lady gaga might have a bad romance but " .. "{player}" .. " has a really bad mouth!!",
	"'Suffer " .. "{player}" .. ", as your pathetic potty mouth betrays you!' -Deathwing",
	"Genesis 1:31: And God saw every thing that he had made, and, behold, it was very good. Except for " .. "{player}" .. "'s dirty mouth.",
	"\"Put away from you crooked speech, and put devious talk far from you " .. "{player}" .. ".\" -Proverbs 4:24",
	"Please no swearing " .. "{player}" .. ".",
	"{player}" .."'s sharp tongue will be cut out like Robb Stark's unborn child on his wedding night.",
	"'heh... expeliarmous of " .. "{player}" .. "'s bad mouth' - potter 2002",
	"Do you kiss your mother with that mouth " .."{player}".."?",
	"i think " .. "{player}" .. " is a pretty cool guy, eh swears and doesnt afraid of anything...",
	"I'm on remote chat at the club and even I'm offended by " .. "{player}" .. "'s swearing",
	"Hey " .. "{player}" .. ", stop fucking swearing!",
	"'Oh! It's my tail! It's my tail! It's a-twitch a-twitchin'! And " .. "{player}" .. ", you know what that means! The twitchin' means my Pinkie Sense is telling me your swearing is dumb!' -Pinkie Pie",
	"{player}" .."'s potty mouth is almost as shocking as the time Ned Stark was beheaded for treason against the king.",
	"{player}" .. " 's words are giving me a crushing headache like Oberyn Martell often gets.",
	"Excuse me ".. "{player}" ..", was you sayin' somethin'? Uh uh, you can't tell me nothin'",
	"Hey " .. "{player}" .. ", real men don't swear.",
	"{player}" .. " keeps it 300, like the Romans. 300 swearwords, where\'s' the Trojans?",
	"Please no swearing.",
	"Can you please stop swearing " .. "{player}" .. "?",
	"\"" .. "{player}" .. ", you\'re a wizard so do me a favor and wizz those words away\" -Hagrid",
	"The plan was to drink until the pain over, but what's worse: ".. "{player}" .."\'s swearing or the hangover?",
	"{player}" .. " was a fookin' legend in Gin Alley, but here he's just another brick in the wall.",
	"-6 x 6 x 6 = 0, and swearing + bad at this game + 12 = " .. "{player}" .. "."
}

local strs = file.Read("banned_words_list.txt", "DATA")
mylist = bON.deserialize(strs)
replacements = {}

function FamilyFriendly(str, pl)
	local haystack, baited = string.lower(string.gsub(str, '%W', ''))
	if (not replacements['xxx']) then
		mylist = bON.deserialize(file.Read("banned_words_list.txt", "DATA"))
		for k, v in ipairs(mylist) do
			if (not next(v.safe)) then
				replacements[v.bad] = string.rep('❤︎', string.len(v.bad))
			else
				replacements[v.bad] = v.safe
			end
		end
	end

	if (pl and IsValid(pl)) then
		baited = bait[math.random(1, #bait)]:gsub('{player}', pl:Nick())
	end

	local safe, swore = string.gsub(str, '%w+', function(s)
		return replacements[s] and replacements[s][math.random(1, #replacements[s])] or replacements[s]
	end)

	return safe
end

function LoadFilter()
	print "yup"

	local strs = string.Trim(file.Read("banned_words_list.txt", "DATA"))
	mylist = bON.deserialize(strs)
	replacements = {}
	for k, v in ipairs(mylist) do
		if (not v.safe) then
			replacements[v.bad] = string.rep('❤︎', string.len(v.bad))
		else
			replacements[v.bad] = v.safe
		end
	end
end

local str = FamilyFriendly("fuck me")
if (str == "fuck me") then
	print "yup"

	local strs = string.Trim(file.Read("banned_words_list.txt", "DATA"))
	mylist = bON.deserialize(strs)
	replacements = {}
	for k, v in ipairs(mylist) do
		if (not next(v.safe)) then
			replacements[v.bad] = string.rep('❤︎', string.len(v.bad))
		else
			replacements[v.bad] = v.safe
		end
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

-- 						file.Write("banned_words_list.txt", bON.serialize(banned_words))
-- 					end)
-- 				end)
-- 			end
-- 		end)
-- 	end
-- end)