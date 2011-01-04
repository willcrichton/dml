local meta = {};
meta.__index = meta;

function meta:Read(mkup)
	mkup = mkup:gsub("[\t]","");
	local hierarchy = {};
	self.ID = 0;
	for node,content in mkup:gmatch("(<.->)([^<>]*)") do
		node = node:gsub("\n","");
		local element = { children = {}, attributes = {} };
		element.code = node:match("[^<>]+");
		element.name = element.code:match(".[^%s]+");
		if element.name:sub(1,1) == "/" then
			table.remove(hierarchy,#hierarchy);
			if content != "" then 
				local curNode = self:FindNode(hierarchy);
				curNode.content[self.ID - 1] = content;
			end
		else
			for k,v in element.code:gmatch("([%w_]+)%s*=%s*\"(.[^\"]*)\"") do
				element.attributes[k] = v;
			end
			
			element.id = self.ID;
			element.content = { top = content};
			
			if not self.Tree.name then
				self.Tree = element;
			else
				local curNode = self:FindNode(hierarchy);
				curNode.children[self.ID] = element;
			end
			
			table.insert(hierarchy,self.ID);

			self.ID = self.ID + 1;
			self.Total = self.Total + 1
			
		end
	end	
end

function meta:FindNode(hierarchy)
	local t = self.Tree;
	for _,id in pairs(hierarchy) do
		t = t and t.children[id] or self.Tree
	end
	return t;
end

function meta:FindByID(id,t)
	local t = t or self.Tree;
	if t.id == id then return t; end
	for _,v in pairs(t.children) do
		if v.id == id then return v;
		else return self:FindByID(id,v); end
	end
end

function meta:FindNodeParent(id,t)
	local t = t or self.Tree;
	if id == self.Tree.id then return nil end;
	for _,child in pairs(t.children) do
		if child.id == id then return t;
		else return self:FindNodeParent(id,child); end
	end
end

function meta:GetAll(t)
	local t = t or self.Tree;
	local collector = collector or {};
	table.insert(collector,t.object)
	for _,v in pairs(t.children) do
		local all = self:GetAll(v)
		table.Add(collector,all);
	end
	
	return collector;
end

function meta:Open(t,parent)
	local t = t or self.Tree;
	t.object = self:CreateElement(t,parent);
	if t.children then
		for i = 1, self.ID do
			if t.children[i] then self:Open(t.children[i],t.object); end
		end
	end
end

function meta:CreateElement(element,parent)
	if DML.Elements[element.name] then 
		return DML.Elements[element.name](self,parent,element); 
	else
		ErrorNoHalt("DML Error: element '" .. element.name .. "' #" .. element.id .. " could not be created.\n");
	end
end

/* Utility functions */

function meta:HexToColor(hex)
	hex = hex and string.lower(hex) or "FFFFFF";
	local rgb = { string.sub(hex,1,2), string.sub(hex,3,4), string.sub(hex,5,6) }
	local hexvalues = { a = 10, b = 11, c = 12, d = 13, e = 14, f = 15 };
	for k,v in pairs(rgb) do
		local first,second = v:sub(1,1), v:sub(2,2);
		rgb[k] = 16 * ( first > "9" and hexvalues[first] or tonumber(first) ) + ( second > "9" and hexvalues[second] or tonumber(second) );
	end
	return Color(unpack(rgb));
end

function meta:StringToVector(str)
	local pos = string.Explode(",",str:gsub("%s",""));
	return Vector( tonumber(pos[1]), tonumber(pos[2]), tonumber(pos[3]) );
end

function meta:SetSizePos(obj,attr,defaults)
	defaults = defaults or {};
	obj:SetPos( attr.x or (defaults.x or 0), attr.y or (defaults.y or 0) );
	obj:SetSize( attr.width or (defaults.width or 100), attr.height or (defaults.height or 100) );
end

function meta:HookEvents(ele,obj,attr)
	for k,v in pairs(attr) do
		if obj[k] and type(obj[k]) == "function" then 
			obj[k] = function(self)
				DML.This = self; 
				RunString(v); 
			end 
		end
	end
end

DML.meta = meta;