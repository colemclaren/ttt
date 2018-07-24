SNAPPER_SENDING = false

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
function util.Base64Decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
    end))
end

function net.SendChunk(id, data, ply, callback, max, rate)
	max = max or (2^16-2^10)-1
	rate = rate or 1/4

	assert(not SNAPPER_SENDING)
	SNAPPER_SENDING = true

	local chunk_count = math.ceil(string.len(data) / max)

	net.Start(id)
	net.WriteInt(chunk_count, 32)
	if ply and SERVER then
		net.Send(ply)
	elseif SERVER then
		net.Broadcast()
	elseif CLIENT then
		net.SendToServer()
	end

	for i = 1, chunk_count do
		local delay = rate * ( i - 1 )

		timer.Simple(delay, function()
			local chunk = string.sub(data, ( i - 1 ) * max + 1, i * max)
			local chunk_len = string.len(chunk)

			net.Start(id)
			net.WriteData(chunk, chunk_len)
			net.WriteBit(i == chunk_count)

			if ply and SERVER then
				net.Send(ply)
			elseif SERVER then
				net.Broadcast()
			elseif CLIENT then
				net.SendToServer()
			end

			if callback then
				callback(chunk_count, i)
			end

			if i == chunk_count then
				SNAPPER_SENDING = false
			end
		end)
	end
end

function net.ReceiveChunk(id, func, callback)
	local chunks = chunks or {}
	local counted = false
	local count

	net.Receive(id, function(len, server)
		if not counted then
			count = net.ReadInt(32)
			if count then
				counted = true
				return
			end
		end

		local chunk = net.ReadData(( len - 1 ) / 8)
		local last_chunk = net.ReadBit() == 1

		if callback then
			callback(count, #chunks+1)
		end

		table.insert(chunks, chunk)

		if last_chunk then
			local data = table.concat(chunks)
			func(data, server)

			chunks = {}
			counted = false
			count = nil
		end
	end)
end