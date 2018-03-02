--[[
This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. 
To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ 
or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.
]]
--Thank you!
-- Ported by Python1320 for use in Garry's Mod Lua Environment. Original code by by Paul Chakravarti ( http://www.lua.org/copyright.html )


local strchar=string.char
local strfind=string.find
local gsub=string.gsub
local strsub=string.sub
local strlen=string.len
local tinsert=table.insert
local strlower=string.lower
local tremove=table.remove
local format=string.format
local getn=function(x) return #x end
local pairs=pairs
local type=type
local error=error
local Msg=Msg
local tonumber=tonumber

-- Helper function for teh lazy
function XMLToTable(xml)
	local h = gxml.simpleTreeHandler()
    local x = gxml.xmlParser(h)
    x:parse(xml)
	return h.root
end

module("gxml")

xmlParser = function(handler)

    local obj = {}

    -- Public attributes

    obj.options = { stripWS = 1,
                    expandEntities = 1,
                    errorHandler = function(err,pos)
                                       error(format("%s [char=%d]\n",
                                               err or "Parse Error",pos))
                                   end,
                  }

    -- Public methods

    obj.parse = function(self,string)
        local match,endmatch,pos = 0,0,1
        local text,endt1,endt2,tagstr,tagname,attrs,starttext,endtext
        local errstart,errend,extstart,extend
        while match do
            -- Get next tag (first pass - fix exceptions below)
            match,endmatch,text,endt1,tagstr,endt2 = strfind(string,self._XML,pos)
            if not match then
                if strfind(string,self._WS,pos) then
                    -- No more text - check document complete
                    if getn(self._stack) ~= 0 then
                        self:_err(self._errstr.incompleteXmlErr,pos)
                    else
                        break
                    end
                else
                    -- Unparsable text
                    self:_err(self._errstr.xmlErr,pos)
                end
            end
            -- Handle leading text
            starttext = match
            endtext = match + strlen(text) - 1
            match = match + strlen(text)
            text = self:_parseEntities(self:_stripWS(text))
            if text ~= "" and self._handler.text then
                self._handler:text(text,nil,match,endtext)
            end
            -- Test for tag type
            if strfind(strsub(tagstr,1,5),"?xml%s") then
                -- XML Declaration
                match,endmatch,text = strfind(string,self._PI,pos)
                if not match then
                    self:_err(self._errstr.declErr,pos)
                end
                if match ~= 1 then
                    -- Must be at start of doc if present
                    self:_err(self._errstr.declStartErr,pos)
                end
                tagname,attrs = self:_parseTag(text)
                -- TODO: Check attributes are valid
                -- Check for version (mandatory)
                if attrs.version == nil then
                    self:_err(self._errstr.declAttrErr,pos)
                end
                if self._handler.decl then
                    self._handler:decl(tagname,attrs,match,endmatch)
                end
            elseif strsub(tagstr,1,1) == "?" then
                -- Processing Instruction
                match,endmatch,text = strfind(string,self._PI,pos)
                if not match then
                    self:_err(self._errstr.piErr,pos)
                end
                if self._handler.pi then
                    -- Parse PI attributes & text
                    tagname,attrs = self:_parseTag(text)
                    local pi = strsub(text,strlen(tagname)+1)
                    if pi ~= "" then
                        if attrs then
                            attrs._text = pi
                        else
                            attrs = { _text = pi }
                        end
                    end
                    self._handler:pi(tagname,attrs,match,endmatch)
                end
            elseif strsub(tagstr,1,3) == "!--" then
                -- Comment
                match,endmatch,text = strfind(string,self._COMMENT,pos)
                if not match then
                    self:_err(self._errstr.commentErr,pos)
                end
                if self._handler.comment then
                    text = self:_parseEntities(self:_stripWS(text))
                    self._handler:comment(text,next,match,endmatch)
                end
            elseif strsub(tagstr,1,8) == "!DOCTYPE" then
                -- DTD
                match,endmatch,attrs = self:_parseDTD(string,pos)
                if not match then
                    self:_err(self._errstr.dtdErr,pos)
                end
                if self._handler.dtd then
                    self._handler:dtd(attrs._root,attrs,match,endmatch)
                end
            elseif strsub(tagstr,1,8) == "![CDATA[" then
                -- CDATA
                match,endmatch,text = strfind(string,self._CDATA,pos)
                if not match then
                    self:_err(self._errstr.cdataErr,pos)
                end
                if self._handler.cdata then
                    self._handler:cdata(text,nil,match,endmatch)
                end
            else
                -- Normal tag

                -- Need theck for embedded '>' in attribute value and extend
                -- match recursively if necessary eg. <tag attr="123>456">

                while 1 do
                    errstart,errend = strfind(tagstr,self._ATTRERR1)
                    if errend == nil then
                        errstart,errend = strfind(tagstr,self._ATTRERR2)
                        if errend == nil then
                            break
                        end
                    end
                    extstart,extend,endt2 = strfind(string,self._TAGEXT,endmatch+1)
                    tagstr = tagstr .. strsub(string,endmatch,extend-1)
                    if not match then
                        self:_err(self._errstr.xmlErr,pos)
                    end
                    endmatch = extend
                end

                -- Extract tagname/attrs

                tagname,attrs = self:_parseTag(tagstr)

                if (endt1=="/") then
                    -- End tag
                    if self._handler.endtag then
                        if attrs then
                            -- Shouldnt have any attributes in endtag
                            self:_err(format("%s (/%s)",
                                             self._errstr.endTagErr,
                                             tagname)
                                        ,pos)
                        end
                        if tremove(self._stack) ~= tagname then
                            self:_err(format("%s (/%s)",
                                             self._errstr.unmatchedTagErr,
                                             tagname)
                                        ,pos)
                        end
                        self._handler:endtag(tagname,nil,match,endmatch)
                    end
                else
                    -- Start Tag
                    tinsert(self._stack,tagname)
                    if self._handler.starttag then
                        self._handler:starttag(tagname,attrs,match,endmatch)
                    end
                    -- Self-Closing Tag
                    if (endt2=="/") then
                        tremove(self._stack)
                        if self._handler.endtag then
                            self._handler:endtag(tagname,nil,match,endmatch)
                        end
                    end
                end
            end
            pos = endmatch + 1
        end
    end

    -- Private attrobures/functions

    obj._handler    = handler
    obj._stack      = {}

    obj._XML        = '^([^<]*)<(%/?)([^>]-)(%/?)>'
    obj._ATTR1      = '([%w-:_]+)%s*=%s*"(.-)"'
    obj._ATTR2      = '([%w-:_]+)%s*=%s*\'(.-)\''
    obj._CDATA      = '<%!%[CDATA%[(.-)%]%]>'
    obj._PI         = '<%?(.-)%?>'
    obj._COMMENT    = '<!%-%-(.-)%-%->'
    obj._TAG        = '^(.-)%s.*'
    obj._LEADINGWS  = '^%s+'
    obj._TRAILINGWS = '%s+$'
    obj._WS         = '^%s*$'
    obj._DTD1       = '<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+["\'](.-)["\']%s*(%b[])%s*>'
    obj._DTD2       = '<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+["\'](.-)["\']%s+["\'](.-)["\']%s*(%b[])%s*>'
    obj._DTD3       = '<!DOCTYPE%s+(.-)%s*(%b[])%s*>'
    obj._DTD4       = '<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+["\'](.-)["\']%s*>'
    obj._DTD5       = '<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+["\'](.-)["\']%s+["\'](.-)["\']%s*>'

    obj._ATTRERR1   = '=%s*"[^"]*$'
    obj._ATTRERR2   = '=%s*\'[^\']*$'
    obj._TAGEXT     = '(%/?)>'

    obj._ENTITIES = { ["&lt;"] = "<",
                      ["&gt;"] = ">",
                      ["&amp;"] = "&",
                      ["&quot;"] = '"',
                      ["&apos;"] = "'",
                      ["&#(%d+);"] = function (x)
                                        local d = tonumber(x)
                                        if d >= 0 and d < 256 then
                                            return strchar(d)
                                        else
                                            return "&#"..d..";"
                                        end
                                     end,
                      ["&#x(%x+);"] = function (x)
                                        local d = tonumber(x,16)
                                        if d >= 0 and d < 256 then
                                            return strchar(d)
                                        else
                                            return "&#x"..x..";"
                                        end
                                      end,
                    }

    obj._err = function(self,err,pos)
                   if self.options.errorHandler then
                       self.options.errorHandler(err,pos)
                   end
               end

    obj._errstr = { xmlErr = "Error Parsing XML",
                    declErr = "Error Parsing XMLDecl",
                    declStartErr = "XMLDecl not at start of document",
                    declAttrErr = "Invalid XMLDecl attributes",
                    piErr = "Error Parsing Processing Instruction",
                    commentErr = "Error Parsing Comment",
                    cdataErr = "Error Parsing CDATA",
                    dtdErr = "Error Parsing DTD",
                    endTagErr = "End Tag Attributes Invalid",
                    unmatchedTagErr = "Unbalanced Tag",
                    incompleteXmlErr = "Incomplete XML Document",
                  }

    obj._stripWS = function(self,s)
        if self.options.stripWS then
            s = gsub(s,'^%s+','')
            s = gsub(s,'%s+$','')
        end
        return s
    end

    obj._parseEntities = function(self,s)
        if self.options.expandEntities then
            for k,v in pairs(self._ENTITIES) do
                s = gsub(s,k,v)
            end
        end
        return s
    end

    obj._parseDTD = function(self,s,pos)
        -- match,endmatch,root,type,name,uri,internal
        local m,e,r,t,n,u,i
        m,e,r,t,u,i = strfind(s,self._DTD1,pos)
        if m then
            return m,e,{_root=r,_type=t,_uri=u,_internal=i}
        end
        m,e,r,t,n,u,i = strfind(s,self._DTD2,pos)
        if m then
            return m,e,{_root=r,_type=t,_name=n,_uri=u,_internal=i}
        end
        m,e,r,i = strfind(s,self._DTD3,pos)
        if m then
            return m,e,{_root=r,_internal=i}
        end
        m,e,r,t,u = strfind(s,self._DTD4,pos)
        if m then
            return m,e,{_root=r,_type=t,_uri=u}
        end
        m,e,r,t,n,u = strfind(s,self._DTD5,pos)
        if m then
            return m,e,{_root=r,_type=t,_name=n,_uri=u}
        end
        return nil
    end

    obj._parseTag = function(self,s)
        local attrs = {}
        local tagname = gsub(s,self._TAG,'%1')
        gsub(s,self._ATTR1,function (k,v)
                                attrs[strlower(k)]=self:_parseEntities(v)
                                attrs._ = 1
                           end)
        gsub(s,self._ATTR2,function (k,v)
                                attrs[strlower(k)]=self:_parseEntities(v)
                                attrs._ = 1
                           end)
        if attrs._ then
            attrs._ = nil
        else
            attrs = nil
        end
        return tagname,attrs
    end

    return obj

end




function showTable(t)
    -- Convenience function for printHandler
    -- (Does not support recursive tables)
    local sep = ''
    local res = ''
    if type(t) ~= 'table' then
        return t
    end
    for k,v in pairs(t) do
        if type(v) == 'table' then
            v = showTable(v)
        end
        res = res .. sep .. format("%s=%s",k,v)
        sep = ','
    end
    res = '{'..res..'}'
    return res
end

--
-- printHandler - generate simple event trace
--

printHandler = function()
    local obj = {}
    obj.starttag = function(self,t,a,s,e)
        Msg("Start    : "..t.."\n")
        if a then
            for k,v in pairs(a) do
                Msg(format(" + %s='%s'\n",k,v))
            end
        end
    end
    obj.endtag = function(self,t,s,e)
        Msg("End      : "..t.."\n")
    end
    obj.text = function(self,t,s,e)
        Msg("Text     : "..t.."\n")
    end
    obj.cdata = function(self,t,s,e)
        Msg("CDATA    : "..t.."\n")
    end
    obj.comment = function(self,t,s,e)
        Msg("Comment  : "..t.."\n")
    end
    obj.dtd = function(self,t,a,s,e)
        Msg("DTD      : "..t.."\n")
        if a then
            for k,v in pairs(a) do
                Msg(format(" + %s='%s'\n",k,v))
            end
        end
    end
    obj.pi = function(self,t,a,s,e)
        Msg("PI       : "..t.."\n")
        if a then
            for k,v in pairs(a) do
                Msg(format(" + %s='%s'\n",k,v))
            end
        end
    end
    obj.decl = function(self,t,a,s,e)
        Msg("XML Decl : "..t.."\n")
        if a then
            for k,v in pairs(a) do
                Msg(format(" + %s='%s'\n",k,v))
            end
        end
    end
    return obj
end

--
-- simpleTreeHandler
--

function simpleTreeHandler()

    local obj = {}
    obj.root = {}
    obj.stack = {obj.root;n=1}
    obj.options = {noreduce = {}}

    obj.reduce = function(self,node,key,parent)
        -- Recursively remove redundant vectors for nodes
        -- with single child elements
        for k,v in pairs(node) do
            if type(v) == 'table' then
                self:reduce(v,k,node)
            end
        end
        if getn(node) == 1 and not self.options.noreduce[key] and
            node._attr == nil then
            parent[key] = node[1]
        else
            node.n = nil
        end
    end

    obj.starttag = function(self,t,a)
        local node = {_attr=a}
        local current = self.stack[getn(self.stack)]
        if current[t] then
            tinsert(current[t],node)
        else
            current[t] = {node;n=1}
        end
        tinsert(self.stack,node)
    end

    obj.endtag = function(self,t,s)
        local current = self.stack[getn(self.stack)]
        local prev = self.stack[getn(self.stack)-1]
        if not prev[t] then
            error("XML Error - Unmatched Tag ["..s..":"..t.."]\n")
        end
        if prev == self.root then
            -- Once parsing complete recursively reduce tree
            self:reduce(prev,nil,nil)
        end
        tremove(self.stack)
    end

    obj.text = function(self,t)
        local current = self.stack[getn(self.stack)]
        tinsert(current,t)
    end

    obj.cdata = obj.text

    return obj
end

--
-- domHandler
--

function domHandler()
    local obj = {}
    obj.options = {commentNode=1,piNode=1,dtdNode=1,declNode=1}
    obj.root = { _children = {n=0}, _type = "ROOT" }
    obj.current = obj.root
    obj.starttag = function(self,t,a)
            local node = { _type = 'ELEMENT',
                           _name = t,
                           _attr = a,
                           _parent = self.current,
                           _children = {n=0} }
            tinsert(self.current._children,node)
            self.current = node
    end
    obj.endtag = function(self,t,s)
            if t ~= self.current._name then
                error("XML Error - Unmatched Tag ["..s..":"..t.."]\n")
            end
            self.current = self.current._parent
    end
    obj.text = function(self,t)
            local node = { _type = "TEXT",
                           _parent = self.current,
                           _text = t }
            tinsert(self.current._children,node)
    end
    obj.comment = function(self,t)
            if self.options.commentNode then
                local node = { _type = "COMMENT",
                               _parent = self.current,
                               _text = t }
                tinsert(self.current._children,node)
            end
    end
    obj.pi = function(self,t,a)
            if self.options.piNode then
                local node = { _type = "PI",
                               _name = t,
                               _attr = a,
                               _parent = self.current }
                tinsert(self.current._children,node)
            end
    end
    obj.decl = function(self,t,a)
            if self.options.declNode then
                local node = { _type = "DECL",
                               _name = t,
                               _attr = a,
                               _parent = self.current }
                tinsert(self.current._children,node)
            end
    end
    obj.dtd = function(self,t,a)
            if self.options.dtdNode then
                local node = { _type = "DTD",
                               _name = t,
                               _attr = a,
                               _parent = self.current }
                tinsert(self.current._children,node)
            end
    end
    obj.cdata = obj.text
    return obj
end


local displayvalue=
  function (s)
    if not s or type(s)=='function' or type(s)=='userdata' then
      s=tostring(s)
    elseif type(s)~='number' then
      s=gsub(format('%q',s),'^"([^"\']*)"$',"'%1'")
    end
    return s
  end
local askeystr=
  function (u,s)
    if type(u)=='string' and strfind(u,'^[%w_]+$') then return s..u end
    return '['..displayvalue(u)..']'
  end
local horizvec=
  function (x,n)
    local o,e='',''
    for i=1,getn(x) do
      if type(x[i])=='table' then return end
      o=o..e..displayvalue(x[i])
      if strlen(o)>n then return end
      e=','
    end
    return '('..o..')'
  end
local horizmap=
  function (x,n)
    local o,e='',''
    for k,v in pairs(x) do
      if type(v)=='table' then return end
      o=o..e..askeystr(k,'')..'='..displayvalue(v)
      if strlen(o)>n then return end
      e=','
    end
    return '{'..o..'}'
  end
function pretty(p,x,h,q)
  if not p then p,x='globals',globals() end
  if type(x)=='table' then
    if not h then h={} end
    if h[x] then
      x=h[x]
    else
      if not q then q=p end
      h[x]=q
      local s={}
      for k,v in pairs(x) do tinsert(s,k) end
      if getn(s)>0 then
        local n=75-strlen(p)
        local f=getn(s)==getn(x) and horizvec(x,n)
        if not f then f=horizmap(x,n) end
        if not f then
          sort(s,function (a,b)
                   if tag(a)~=tag(b) then a,b=tag(b),tag(a) end
                   return a<b
                 end)
          for i=1,getn(s) do
            if s[i] then
              local u=askeystr(s[i],'.')
              pretty(p..u,x[s[i]],h,q..u)
              p=strrep(' ',strlen(p))
            end
          end
          return
        end
        x=f
      else
        x='{}'
      end
    end
  else
    x=displayvalue(x)
  end
  print(p..' = '..x)
end