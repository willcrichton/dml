/*---------------------------------------------------------
   Name: sheet
   Desc: A DPropertySheet. Useful for display content in
		multiple tabs.
   Attributes:
   Example:
		<sheet>
			<tab title="Tab 1"></tab>
			<tab title="Tab 2"></tab>
		</sheet>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local prop = vgui.Create("DPropertySheet",parent);
	class:SetSizePos(prop,attr);
	
	class:HookEvents(element,prop,attr);
	return prop;
end

DML.Register("sheet",createElement);