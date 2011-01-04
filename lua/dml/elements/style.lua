/*---------------------------------------------------------
   Name: style
   Desc: Emulates CSS. STILL A WORK IN PROGRESS, PAY NO HEED.
   Attributes:
		
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local mkup = element.content.top;
	mkup = mkup:gsub("%s","");
	local elements = class:GetAll();
	for selector, attributes in mkup:gmatch("(.+)({.-})") do
		local attr = {};
		for a in string.sub(attributes,2,-2):gmatch("[^;]+") do
			local key,val = a:match("(.+):(.+)");
			attr[key] = val;
		end
		for _,ele in pairs(elements) do
			if ele.name == selector then
				// do stuff here
			end
		end
	end
end

DML.Register("style",createElement);