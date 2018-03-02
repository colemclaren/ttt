-- Generated from: glib/lua/glib/unicode/unicode.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/unicode/unicode.lua
-- Timestamp:      2016-02-22 19:22:23
CAC.Unicode = CAC.Unicode or {}
CAC.Unicode.Characters  = {}
local characterNames     = {}
local decompositionMap   = {}
local lowercaseMap       = {}
local uppercaseMap       = {}
local titlecaseMap       = {}
local transliterationMap = {}

function CAC.Unicode.AddTransliteration (character, transliteration)
	if not transliterationMap [character] then
		transliterationMap [character] = {}
	end
	table.insert (transliterationMap [character], transliteration)
end

function CAC.Unicode.CharacterHasDecomposition (...)
	return decompositionMap [CAC.UTF8.NextChar (...)] ~= nil
end

function CAC.Unicode.CharacterHasTransliteration (...)
	return transliterationMap [CAC.UTF8.NextChar (...)] ~= nil
end

function CAC.Unicode.CodePointHasDecomposition (codePoint)
	return decompositionMap [CAC.UTF8.Char (codePoint)] ~= nil
end

function CAC.Unicode.CodePointHasTransliteration (codePoint)
	return transliterationMap [CAC.UTF8.Char (codePoint)] ~= nil
end

function CAC.Unicode.DecomposeCharacter (...)
	local char = CAC.UTF8.NextChar (...)
	local decomposed = decompositionMap [char]
	if not decomposed then return char end
	
	local recursiveDecomposition = ""
	for c in CAC.UTF8.Iterator (decomposed) do
		recursiveDecomposition = recursiveDecomposition .. CAC.Unicode.DecomposeCharacter (c)
	end
	return recursiveDecomposition
end

function CAC.Unicode.DecomposeCodePoint (codePoint)
	return CAC.Unicode.DecomposeCharacter (CAC.UTF8.Char (codePoint))
end

function CAC.Unicode.GetCharacterCategory (...)
	local codePoint = CAC.UTF8.Byte (...)
	return CAC.Unicode.GetCodePointCategory (codePoint)
end

function CAC.Unicode.GetCharacterName (...)
	local codePoint = CAC.UTF8.Byte (...)
	if characterNames [codePoint] then
		return characterNames [codePoint]
	end
	if codePoint < 0x010000 then
		return string.format ("CHARACTER 0x%04x", codePoint)
	else
		return string.format ("CHARACTER 0x%06x", codePoint)
	end
end

function CAC.Unicode.GetCharacterNameTable ()
	return characterNames
end

function CAC.Unicode.GetCodePointCategory (codePoint)
	CAC.Error ("CAC.Unicode.GetCodePointCategory : Did unicodecategorytable.lua fail to load?")
end

function CAC.Unicode.GetCodePointName (codePoint)
	if characterNames [codePoint] then
		return characterNames [codePoint]
	end
	if codePoint < 0x010000 then
		return string.format ("CHARACTER 0x%04x", codePoint)
	else
		return string.format ("CHARACTER 0x%06x", codePoint)
	end
end

function CAC.Unicode.GetDecompositionMap ()
	return decompositionMap
end

function CAC.Unicode.GetTransliterationTable ()
	return transliterationMap
end

function CAC.Unicode.IsCharacterNamed (...)
	local codePoint = CAC.UTF8.Byte (...)
	return characterNames [codePoint] and true or false
end

function CAC.Unicode.IsCodePointNamed (codePoint)
	return characterNames [codePoint] and true or false
end

local combiningCategories =
{
	[CAC.UnicodeCategory.NonSpacingMark]       = true,
	[CAC.UnicodeCategory.SpacingCombiningMark] = true,
	[CAC.UnicodeCategory.EnclosingMark]        = true
}

function CAC.Unicode.IsCombiningCategory (unicodeCategory)
	return combiningCategories [unicodeCategory] or false
end

function CAC.Unicode.IsCombiningCharacter (...)
	return combiningCategories [CAC.Unicode.GetCharacterCategory (...)] or false
end

function CAC.Unicode.IsCombiningCodePoint (codePoint)
	return combiningCategories [CAC.Unicode.GetCodePointCategory (codePoint)] or false
end

function CAC.Unicode.IsControl (...)
	return CAC.Unicode.GetCharacterCategory (...) == CAC.UnicodeCategory.Control
end

function CAC.Unicode.IsControlCategory (unicodeCategory)
	return unicodeCategory == CAC.UnicodeCategory.Control
end

function CAC.Unicode.IsControlCodePoint (codePoint)
	return CAC.Unicode.GetCodePointCategory (codePoint) == CAC.UnicodeCategory.Control
end

function CAC.Unicode.IsDigit (...)
	return CAC.Unicode.GetCharacterCategory (...) == CAC.UnicodeCategory.DecimalDigitNumber
end

function CAC.Unicode.IsDigitCodePoint (codePoint)
	return CAC.Unicode.GetCodePointCategory (codePoint) == CAC.UnicodeCategory.DecimalDigitNumber
end

local letterCategories =
{
	[CAC.UnicodeCategory.UppercaseLetter] = true,
	[CAC.UnicodeCategory.LowercaseLetter] = true,
	[CAC.UnicodeCategory.TitlecaseLetter] = true,
	[CAC.UnicodeCategory.ModifierLetter ] = true,
	[CAC.UnicodeCategory.OtherLetter    ] = true
}
function CAC.Unicode.IsLetter (...)
	return letterCategories [CAC.Unicode.GetCharacterCategory (...)] or false
end

function CAC.Unicode.IsLetterCategory (unicodeCategory)
	return letterCategories [unicodeCategory] or false
end

function CAC.Unicode.IsLetterCodePoint (codePoint)
	return letterCategories [CAC.Unicode.GetCodePointCategory (codePoint)] or false
end

function CAC.Unicode.IsLetterOrDigit (...)
	local unicodeCategory = CAC.Unicode.GetCharacterCategory (...)
	return letterCategories [unicodeCategory] or unicodeCategory == CAC.UnicodeCategory.DecimalDigitNumber or false
end

function CAC.Unicode.IsLetterOrDigitCategory (unicodeCategory)
	return letterCategories [unicodeCategory] or unicodeCategory == CAC.UnicodeCategory.DecimalDigitNumber or false
end

function CAC.Unicode.IsLetterOrDigitCodePoint (codePoint)
	local unicodeCategory = CAC.Unicode.GetCodePointCategory (codePoint)
	return letterCategories [unicodeCategory] or unicodeCategory == CAC.UnicodeCategory.DecimalDigitNumber or false
end

function CAC.Unicode.IsLower (...)
	return CAC.Unicode.GetCharacterCategory (...) == CAC.UnicodeCategory.LowercaseLetter
end

function CAC.Unicode.IsLowerCodePoint (codePoint)
	return CAC.Unicode.GetCodePointCategory (codePoint) == CAC.UnicodeCategory.LowercaseLetter
end

local numberCategories =
{
	[CAC.UnicodeCategory.DecimalDigitNumber] = true,
	[CAC.UnicodeCategory.LetterNumber      ] = true,
	[CAC.UnicodeCategory.OtherNumber       ] = true
}
function CAC.Unicode.IsNumber (...)
	return numberCategories [CAC.Unicode.GetCharacterCategory (...)] or false
end

function CAC.Unicode.IsNumberCategory (unicodeCategory)
	return numberCategories [unicodeCategory] or false
end

function CAC.Unicode.IsNumberCodePoint (codePoint)
	return numberCategories [CAC.Unicode.GetCodePointCategory (codePoint)] or false
end

local punctuationCategories =
{
	[CAC.UnicodeCategory.ConnectorPunctuation   ] = true,
	[CAC.UnicodeCategory.DashPunctuation        ] = true,
	[CAC.UnicodeCategory.OpenPunctuation        ] = true,
	[CAC.UnicodeCategory.ClosePunctuation       ] = true,
	[CAC.UnicodeCategory.InitialQuotePunctuation] = true,
	[CAC.UnicodeCategory.FinalQuotePunctuation  ] = true,
	[CAC.UnicodeCategory.OtherPunctuation       ] = true
}
function CAC.Unicode.IsPunctuation (...)
	return punctuationCategories [CAC.Unicode.GetCharacterCategory (...)] or false
end

function CAC.Unicode.IsPunctuationCategory (unicodeCategory)
	return punctuationCategories [unicodeCategory] or false
end

local separatorCategories =
{
	[CAC.UnicodeCategory.SpaceSeparator    ] = true,
	[CAC.UnicodeCategory.LineSeparator     ] = true,
	[CAC.UnicodeCategory.ParagraphSeparator] = true
}
function CAC.Unicode.IsSeparator (...)
	return separatorCategories [CAC.Unicode.GetCharacterCategory (...)] or false
end

function CAC.Unicode.IsSeparatorCategory (unicodeCategory)
	return separatorCategories [unicodeCategory] or false
end

function CAC.Unicode.IsSeparatorCodePoint (codePoint)
	return separatorCategories [CAC.Unicode.GetCodePointCategory (codePoint)] or false
end

local symbolCategories =
{
	[CAC.UnicodeCategory.MathSymbol    ] = true,
	[CAC.UnicodeCategory.CurrencySymbol] = true,
	[CAC.UnicodeCategory.ModifierSymbol] = true,
	[CAC.UnicodeCategory.OtherSymbol   ] = true
}
function CAC.Unicode.IsSymbol (...)
	return symbolCategories [CAC.Unicode.GetCharacterCategory (...)] or false
end

function CAC.Unicode.IsSymbolCategory (unicodeCategory)
	return symbolCategories [unicodeCategory] or false
end

function CAC.Unicode.IsSymbolCodePoint (codePoint)
	return symbolCategories [CAC.Unicode.GetCodePointCategory (codePoint)] or false
end

function CAC.Unicode.IsUpper (...)
	return CAC.Unicode.GetCharacterCategory (...) == CAC.UnicodeCategory.UppercaseLetter
end

function CAC.Unicode.IsUpperCodePoint (codePoint)
	return CAC.Unicode.GetCodePointCategory (codePoint) == CAC.UnicodeCategory.UppercaseLetter
end

local whitespaceCategories =
{
	[CAC.UnicodeCategory.SpaceSeparator    ] = true,
	[CAC.UnicodeCategory.LineSeparator     ] = true,
	[CAC.UnicodeCategory.ParagraphSeparator] = true
}
local whitespaceCodePoints =
{
	[0x0009] = true,
	[0x000A] = true,
	[0x000B] = true,
	[0x000C] = true,
	[0x000D] = true,
	[0x0085] = true,
	[0x00A0] = true
}
function CAC.Unicode.IsWhitespace (...)
	local codePoint = CAC.UTF8.Byte (...)
	return whitespaceCodePoints [codePoint] or whitespaceCategories [CAC.Unicode.GetCodePointCategory (codePoint)] or false
end

function CAC.Unicode.IsWhitespaceCodePoint (codePoint)
	return whitespaceCodePoints [codePoint] or whitespaceCategories [CAC.Unicode.GetCodePointCategory (codePoint)] or false
end

function CAC.Unicode.ToLower (...)
	local char = CAC.UTF8.NextChar (...)
	return lowercaseMap [char] or char
end

function CAC.Unicode.ToLowerCodePoint (codePoint)
	local char = CAC.UTF8.Char (codePoint)
	return lowercaseMap [char] or char
end

function CAC.Unicode.ToTitle (...)
	local char = CAC.UTF8.NextChar (...)
	return titlecaseMap [char] or char
end

function CAC.Unicode.ToTitleCodePoint (codePoint)
	local char = CAC.UTF8.Char (codePoint)
	return titlecaseMap [char] or char
end

function CAC.Unicode.ToUpper (str, offset)
	local char = CAC.UTF8.NextChar (str, offset)
	return uppercaseMap [char] or char
end

function CAC.Unicode.ToUpperCodePoint (codePoint)
	local char = CAC.UTF8.Char (codePoint)
	return uppercaseMap [char] or char
end

-- unicodedata.txt parser
CAC.Unicode.DataLines = nil
CAC.Unicode.StartTime = SysTime ()

local function ParseUnicodeData (unicodeData)
	CAC.Unicode.DataLines = string.Split (string.Trim (unicodeData), "\n")
	local dataLines = CAC.Unicode.DataLines
	local i = 1
	local lastCodePoint = 0
	timer.Create ("CAC.Unicode.ParseData", 0.001, 0,
		function ()
			local startTime = SysTime ()
			while SysTime () - startTime < 0.005 do
				--  1. Code point
				--  2. Character name
				--  3. Generate category
				--  4. Canonical combining classes
				--  5. Bidirectional category
				--  6. Character decomposition mapping
				--  7. Decimal digit value
				--  8. Digit value
				--  9. Numeric value
				-- 10. Mirrored
				-- 11. Unicode 1.0 name
				-- 12. ISO 10646 comment field
				-- 13. Uppercase mapping
				-- 14. Lowercase mapping
				-- 15. Titlecase mapping
				
				local line = dataLines [i]
				line = string.gsub (line, "#.*$", "")
				line = string.Trim (line)
				
				if line ~= "" then
					local bits = string.Split (line, ";")
					local codePoint = tonumber ("0x" .. (bits [1] or "0")) or 0
					
					lastCodePoint = codePoint
					
					characterNames [codePoint] = bits [2]
					
					-- Decomposition
					if bits [6] and bits [6] ~= "" then
						local decompositionBits = string.Split (bits [6], " ")
						local decomposition = ""
						for i = 1, #decompositionBits do
							local codePoint = tonumber ("0x" .. decompositionBits [i])
							if codePoint then
								decomposition = decomposition .. CAC.UTF8.Char (codePoint)
							end
						end
						decompositionMap [CAC.UTF8.Char (codePoint)] = decomposition
					end
					
					-- Uppercase
					if bits [13] and bits [13] ~= "" then
						if bits [13]:find (" ") then print (bits [13]) end
						uppercaseMap [CAC.UTF8.Char (codePoint)] = CAC.UTF8.Char (tonumber ("0x" .. bits [13]))
					end
					
					-- Lowercase
					if bits [14] and bits [14] ~= "" then
						if bits [14]:find (" ") then print (bits [14]) end
						lowercaseMap [CAC.UTF8.Char (codePoint)] = CAC.UTF8.Char (tonumber ("0x" .. bits [14]))
					end
					
					-- Titlecase
					if bits [15] and bits [15] ~= "" then
						if bits [15]:find (" ") then print (bits [15]) end
						titlecaseMap [CAC.UTF8.Char (codePoint)] = CAC.UTF8.Char (tonumber ("0x" .. bits [15]))
					end
				end
				
				i = i + 1
				if i > #dataLines then
					timer.Destroy ("CAC.Unicode.ParseData")
					CAC.Unicode.DataLines = nil
					
					CAC.Unicode.EndTime   = SysTime ()
					CAC.Unicode.DeltaTime = CAC.Unicode.EndTime - CAC.Unicode.StartTime
					
					break
				end
			end
		end
	)
end

CAC.Resources.RegisterFile ("UnicodeData", "UnicodeData", "data/cac_unicodedata.txt")

timer.Simple (1,
	function ()
		CAC.Resources.Get ("UnicodeData", "UnicodeData",
			function (success, data)
				if not success then return end
				ParseUnicodeData (data)
			end
		)
	end
)

CAC.Unicode.Characters.CombiningDotAbove               = CAC.UTF8.Char (0x0307)
CAC.Unicode.Characters.CombiningDiaeresis              = CAC.UTF8.Char (0x0308)
CAC.Unicode.Characters.EnQuad                          = CAC.UTF8.Char (0x2000)
CAC.Unicode.Characters.EmQuad                          = CAC.UTF8.Char (0x2001)
CAC.Unicode.Characters.EnSpace                         = CAC.UTF8.Char (0x2002)
CAC.Unicode.Characters.EmSpace                         = CAC.UTF8.Char (0x2003)
CAC.Unicode.Characters.ThreePerEmSpace                 = CAC.UTF8.Char (0x2004)
CAC.Unicode.Characters.FourPerEmSpace                  = CAC.UTF8.Char (0x2005)
CAC.Unicode.Characters.SixPerEmSpace                   = CAC.UTF8.Char (0x2006)
CAC.Unicode.Characters.FigureSpace                     = CAC.UTF8.Char (0x2007)
CAC.Unicode.Characters.PunctuationSpace                = CAC.UTF8.Char (0x2008)
CAC.Unicode.Characters.ThinSpace                       = CAC.UTF8.Char (0x2009)
CAC.Unicode.Characters.HairSpace                       = CAC.UTF8.Char (0x200A)
CAC.Unicode.Characters.ZeroWidthSpace                  = CAC.UTF8.Char (0x200B)
CAC.Unicode.Characters.ZeroWidthNonJoiner              = CAC.UTF8.Char (0x200C)
CAC.Unicode.Characters.ZeroWidthJoiner                 = CAC.UTF8.Char (0x200D)
CAC.Unicode.Characters.LeftToRightMark                 = CAC.UTF8.Char (0x200E)
CAC.Unicode.Characters.RightToLeftMark                 = CAC.UTF8.Char (0x200F)
CAC.Unicode.Characters.LineSeparator                   = CAC.UTF8.Char (0x2028)
CAC.Unicode.Characters.ParagraphSeparator              = CAC.UTF8.Char (0x2029)
CAC.Unicode.Characters.LeftToRightEmbedding            = CAC.UTF8.Char (0x202A)
CAC.Unicode.Characters.RightToLeftEmbedding            = CAC.UTF8.Char (0x202B)
CAC.Unicode.Characters.PopDirectionalFormatting        = CAC.UTF8.Char (0x202C)
CAC.Unicode.Characters.LeftToRightOverride             = CAC.UTF8.Char (0x202D)
CAC.Unicode.Characters.RightToLeftOverride             = CAC.UTF8.Char (0x202E)
CAC.Unicode.Characters.NarrowNoBreakSpace              = CAC.UTF8.Char (0x202F)
CAC.Unicode.Characters.WordJoiner                      = CAC.UTF8.Char (0x2060)
CAC.Unicode.Characters.InhibitSymmetricSwapping        = CAC.UTF8.Char (0x206A)
CAC.Unicode.Characters.ActivateSymmetricSwapping       = CAC.UTF8.Char (0x206B)
CAC.Unicode.Characters.InhibitArabicFormShaping        = CAC.UTF8.Char (0x206C)
CAC.Unicode.Characters.ActivateArabicFormShaping       = CAC.UTF8.Char (0x206D)
CAC.Unicode.Characters.NationalDigitShapes             = CAC.UTF8.Char (0x206E)
CAC.Unicode.Characters.NominalDigitShapes              = CAC.UTF8.Char (0x206F)
CAC.Unicode.Characters.ByteOrderMark                   = CAC.UTF8.Char (0xFEFF)
CAC.Unicode.Characters.ZeroWidthNoBreakSpace           = CAC.UTF8.Char (0xFEFF)
CAC.Unicode.Characters.InterlinearAnnotationAnchor     = CAC.UTF8.Char (0xFFF9)
CAC.Unicode.Characters.InterlinearAnnotationSeparator  = CAC.UTF8.Char (0xFFFA)
CAC.Unicode.Characters.InterlinearAnnotationTerminator = CAC.UTF8.Char (0xFFFB)