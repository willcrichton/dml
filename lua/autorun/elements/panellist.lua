/*---------------------------------------------------------
   Name: panellist
   Desc: A DPanelList. Useful for keeping objects organized, 
		particular when dealing with more than just text.
   Attributes:
   Example:
		<panellist>
			<listitem></listitem>
		</panellist>
---------------------------------------------------------*/
local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local p = vgui.Create("DPanelList",parent);
	class:SetSizePos(p,attr);
	
	class:HookEvents(element,p,attr);
	return p;
end

DML.Register("panellist",createElement);