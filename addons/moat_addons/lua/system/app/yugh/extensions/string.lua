local str_table = string.ToTable
local str_gsub = string.gsub
local str_sub = string.sub
local str_find = string.find
local str_len = string.len
local to_str = tostring
local string_table = string
local STRING = getmetatable ""

-----------------------
-- Base Optimization --
-----------------------
/*
function string.Explode(sep, str, nopat)
	if (sep == "") then
		return str_table(str)
	end

	local c, t, n = 1, {}, 1

	for i = 1, str_len(str) do
		local s, e = str_find(str, sep, c, nopat or false)

		if (not s) then
			break
		end

		t[n] = str_sub(str, c, s - 1)
		n = n + 1

		c = e + 1
	end

	t[n] = str_sub(str, c)

	return t
end
*/
------------------------
-- Markdown Utilities --
------------------------

local NewLine = function(s, n) return (n and "" or "\n") .. s end
local EndLine = function(s) return s .. "\n" end
local SplitLine = function(s) return "\n" .. s .. "\n" end
local Line = "--------------------------------------------------"
local LineCode = "------------------------------"
local BoldLine = "=============================="
local md = {
	EndLine = EndLine,
	NewLine = NewLine,
	SplitLine = SplitLine,
	BoldLine = BoldLine,
	LineCode = LineCode,
	Line = Line
}

function md.Dot(str)
	return " • " .. str
end

function md.Pipe(str)
	return " | " .. str
end

function md.Bold(str)
	return "**" .. str .. "**"
end

function md.Italics(str)
	return "*" .. str .. "*"
end

function md.Underline(str)
	return "__" .. str .. "__"
end

function md.BoldItalics(str)
	return "***" .. str .. "***"
end
md.ItalicsBold = md.BoldItalics

function md.BoldUnderline(str)
	return "__**" .. str .. "**__"
end
md.UnderlineBold = md.BoldUnderline

function md.ItalicsUnderline(str)
	return "__*" .. str .. "*__"
end
md.UnderlineItalics = md.ItalicsUnderline

function md.Highlight(str)
	return "`" .. str .. "`"
end
md.Code = md.Highlight

function md.CodeBlock(str, lang)
	return "```" .. (lang or "") .. SplitLine(str) .. "```"
end
md.Block = md.CodeBlock

function md.WrapBold(str, n)
	return NewLine(BoldLine, n) .. NewLine(str) .. NewLine(BoldLine)
end

function md.WrapLine(str, n)
	return NewLine(Line, n) .. NewLine(str) .. NewLine(Line)
end

function md.WrapBoldLine(str, n)
	return NewLine(BoldLine, n) .. NewLine(str) .. NewLine(Line)
end

function md.WrapLineBold(str, n)
	return NewLine(Line, n) .. NewLine(str) .. NewLine(BoldLine)
end

function md.LineStart(str, n)
	return NewLine(Line, n) .. NewLine(str)
end

function md.BoldStart(str, n)
	return NewLine(BoldLine, n) .. NewLine(str)
end

function md.LineEnd(str, n)
	return NewLine(str, n) .. NewLine(Line)
end

function md.BoldEnd(str, n)
	return NewLine(str, n) .. NewLine(BoldLine)
end

-- hypothetically, you can use this yes
-- but you gotta be careful if the string is fukd u kno
for k, v in pairs(md) do
	string_table[k] = v
end

markdown = md
style = md

----------------------
-- String Utilities --
----------------------

local lower = {
	["a"] = true,
	["an"] = true,
	["the"] = true,
	["at"] = true,
	["by"] = true,
	["for"] = true,
	["in"] = true,
	["of"] = true,
	["on"] = true,
	["to"] = true,
	["up"] = true,
	["and"] = true,
	["as"] = true,
	["but"] = true,
	["or"] = true,
	["nor"] = true,
}

function string.Title(str, capitalize, punctuate)
	str = tostring(str) or ""

	local cap = capitalize or false
	return string.gsub(" " .. str, "(%W)(%l)([%w'%d]*)", function(_, letter, rest)

		if (_ == "'") then
			return false
		end

		if (lower[string(letter, rest)] and cap and not capitalize) then
			return false
		end

		rest = rest or ""
		cap = (not capitalize)
	
		return _ .. string.upper(letter) .. rest
	end):sub(2)
end

function string.Grammarfy(str, punctuate)
	str = tostring(str) or ""

	local mark = punctuate or false
	return string.gsub(" " .. str, "([%w])(%l)([%w'%d]*)([%p]*)", function(_, letter, rest, punctuation)
		rest = rest or ""

		if (_ == "'") then
			return false
		end

		if (lower[string(letter, rest)] and mark and not punctuate) then
			return false
		end

		mark = (not not punctuation)
		
		return _ .. letter .. rest .. punctuation
	end):sub(2) .. ((mark or punctuate) and "." or "")
end

function string_table.Extra(str, extra, split)
	str = str or ""
	extra = extra and " (" .. extra .. ")"

	if (split) then
		return str, extra
	end

	return str .. extra
end

function string_table.Create(...)
	return table.concat({...}, "")
end

function string.Friendly(number, thousands, millions)
	if (isnumber(number)) then
		number = string.format("%f", number)
		number = string.match(number, "^(.-)%.?0*$")
	end

	if (math.abs(tonumber(number)) < 1000) then
		return number
	elseif (math.abs(tonumber(number)) < 1000000) then
		return math.Round(tonumber(number) / 1000, 1) .. "K"
	else
		return math.Round(tonumber(number) / 1000000, 1) .. "M"
	end

	return number
end


------------------------
-- Create Our Methods --
------------------------

function STRING:__index(key)
	local val = string_table[key]
	if (val) then
		return val
	elseif (tonumber(key)) then
		return self:sub(key, key)
	else
		error("attempt to index a string value with bad key ('" .. tostring(key) .. "' is not part of the string library)", 2)
	end
end

string = setmetatable(string_table, {
	__call = function(self, ...)
		return self.Create(...)
	end
})