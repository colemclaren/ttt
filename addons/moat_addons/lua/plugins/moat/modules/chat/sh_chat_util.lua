BANNED_WORD = BANNED_WORD or {List = {}, Raw = {}}
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

function BannedWordList(data)
	if (not data) then return end
	if (type(data) == "string" and (string.match(data, ".txt$") or string.match(data, "^data/"))) then
		return BannedWordList(file.Read(string.TrimLeft(data, 'data/'), "DATA"))
	end

	BANNED_WORD.Raw = bON(data)

	for k, v in ipairs(BANNED_WORD.Raw) do
		if (not v.bad) then continue end

		if (not v.safe or (v.safe and istable(v.safe) and not v.safe[1])) then
			BANNED_WORD.List[v.bad] = string.rep('*', string.len(v.bad))
		else
			BANNED_WORD.List[v.bad] = v.safe
		end
	end
end

if (SERVER) then
	util.AddNetworkString("moat_chat_msg")

	local pl = FindMetaTable("Player")

	function pl:MoatChat(str)
		net.Start("moat_chat_msg")
		net.WriteString(str)
		net.Send(self)
	end
else
	net.Receive("moat_chat_msg", function(l)
		local str = net.ReadString()

		chat.AddText(Material("icon16/information.png"), Color(255, 0, 0), str)
	end)

	local safety = CreateClientConVar("moat_safety", 1, true, true)
	function FamilyFriendly(str, pl)
		local baited

		if (safety:GetInt() <= 0) then
			return str
		end

		if (IsValid(LocalPlayer()) and pl and IsValid(pl)) then
			baited = string.gsub(bait[math.random(1, #bait)], '{target}', pl:Nick())
		end

		local lower = str:gsub('​', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub(' ', ''):gsub('⠀', '')

		local swore = 0
		local new = string.gsub(lower, '%w+', function(s)
			local l = string.lower(s)

			if (BANNED_WORD.List[l]) then
				swore = swore + 1
			end

			return istable(BANNED_WORD.List[l]) and BANNED_WORD.List[l][math.random(1, #BANNED_WORD.List[l])] or BANNED_WORD.List[l] or s
		end)

		if (baited) then
			local warn, found = string.lower(new)
			for k, v in ipairs(BANNED_WORD.Raw) do
				if (not v.bad) then continue end
				if (v.bad and #v.bad <= 3) then continue end
				if (v.bad and string.find(warn, v.bad)) then
					found = v.bad
					break
				end
			end

			if (found) then
				return false, str
			end
		end

		return swore > 0 and new or str
	end

	hook("HTTPLoaded", function()
		local data = cdn.Data("https://static.moat.gg/ttt/banned_words.txt", BannedWordList)
		if (data) then
			BannedWordList(data)
		end
	end)
end