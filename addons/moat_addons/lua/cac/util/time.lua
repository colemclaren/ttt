local timeUnits =
{
	{ Singular = "U-235 half-life", Plural = "U-235 half-lives", Duration = 60 * 60 * 24 * 365 * 703800000 },
	{ Singular = "year",            Plural = "years",            Duration = 60 * 60 * 24 * 365             },
	{ Singular = "day",             Plural = "days",             Duration = 60 * 60 * 24                   },
	{ Singular = "hour",            Plural = "hours",            Duration = 60 * 60                        },
	{ Singular = "minute",          Plural = "minutes",          Duration = 60                             },
	{ Singular = "second",          Plural = "seconds",          Duration = 1                              },
	{ Singular = "millisecond",     Plural = "milliseconds",     Duration = 1e-3                           },
	{ Singular = "microsecond",     Plural = "microseconds",     Duration = 1e-6                           },
	{ Singular = "nanosecond",      Plural = "nanoseconds",      Duration = 1e-9                           },
	{ Singular = "picosecond",      Plural = "picoseconds",      Duration = 1e-12                          }
}

function CAC.FormatDurationVerbose (duration)
	if duration == math.huge then
		return "forever"
	elseif duration == 0 then
		return "0 seconds"
	end
	
	local durationParts = {}
	
	for _, timeUnitData in ipairs (timeUnits) do
		local units = math.floor (duration / timeUnitData.Duration)
		
		if units > 0 then
			durationParts [#durationParts + 1] = tostring (units) .. " " .. (units == 1 and timeUnitData.Singular or timeUnitData.Plural)
			duration = duration - units * timeUnitData.Duration
		end
	end
	
	if #durationParts == 1 then
		return durationParts [1]
	end
	
	local lastPart = durationParts [#durationParts]
	durationParts [#durationParts] = nil
	
	return table.concat (durationParts, ", ") .. " and " .. lastPart
end

function CAC.FormatBanDuration (duration)
	if duration > 24 * 60 * 60 then
		local days = duration / 24 / 60 / 60
		return string.format ("%.3g day%s",    days,    days    == 1 and "" or "s")
	elseif duration > 60 * 60 then
		local hours = duration / 60 / 60
		return string.format ("%.3g hour%s",   hours,   hours   == 1 and "" or "s")
	elseif duration > 60 then
		local minutes = duration / 60
		return string.format ("%.3g minute%s", minutes, minutes == 1 and "" or "s")
	else
		local seconds = duration
		return string.format ("%.3g second%s", seconds, seconds == 1 and "" or "s")
	end
end

function CAC.FormatTimeRemaining (timeRemaining)
	return string.format ("%02d:%02d.%1d",
		math.floor (timeRemaining / 60),
		math.floor (timeRemaining % 60),
		math.floor ((timeRemaining % 1) * 10)
	)
end

function CAC.FormatTimestamp (timestamp)
	return os.date ("%H:%M:%S %A %d %B %Y", timestamp)
end

function CAC.FormatDate (timestamp)
	return os.date ("%A %d %B %Y", timestamp)
end

function CAC.FormatTime (timestamp)
	return os.date ("%H:%M:%S", timestamp)
end

function CAC.FormatTimestampRelative (timestamp)
	local dt = os.time () - timestamp
	
	if dt > 365 * 24 * 60 * 60 then
		local years = math.floor (dt / 365 / 24 / 60 / 60)
		return string.format ("%d year%s ago", years, years == 1 and "" or "s")
	elseif dt > 30.5 * 24 * 60 * 60 then
		local months = math.floor (dt / 30.5 / 24 / 60 / 60)
		return string.format ("%d month%s ago", months, months == 1 and "" or "s")
	elseif dt > 24 * 60 * 60 then
		local days = math.floor (dt / 24 / 60 / 60)
		return string.format ("%d day%s ago", days, days == 1 and "" or "s")
	elseif dt > 60 * 60 then
		local hours = math.floor (dt / 60 / 60)
		return string.format ("%d hour%s ago", hours, hours == 1 and "" or "s")
	elseif dt > 60 then
		local minutes = math.floor (dt / 60)
		return string.format ("%d minute%s ago", minutes, minutes == 1 and "" or "s")
	else
		local seconds = math.floor (dt)
		return string.format ("%d second%s ago", seconds, seconds == 1 and "" or "s")
	end
end