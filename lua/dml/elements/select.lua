/*---------------------------------------------------------
   Name: select
   Desc: A DMultiChoice. Functions like HTML's select.
   Attributes:
		convar: The convar to be set by the options.
   Example:
		<select>
			<option>Choice #1</option>
			<option>Choice #2</option>
		</select>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local m = vgui.Create("DMultiChoice",parent);
	class:SetSizePos(m,attr,{height=20});
	if attr.convar then m:SetConVar(attr.convar) end
	
	class:HookEvents(element,m,attr);
	return m;
end

DML.Register("select",createElement);