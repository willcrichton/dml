/*---------------------------------------------------------
   Name: combobox
   Desc: A DComboBox. Useful for allowing the user to options.
   Attributes:
		multiple: true/false, determines if user can select 
				  multiple boxes at once
   Example:
		<combobox>
			<box>Text</box>
			<box>More Text</box>
		</combobox>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes, element.content;
	local c = vgui.Create("DComboBox",parent);
	class:SetSizePos(c,attr);
	c:SetMultiple(attr.multiple and tobool(attr.multiple) or false);
	
	class:HookEvents(element,c,attr);
	return c;
end

DML.Register("combobox",createElement);