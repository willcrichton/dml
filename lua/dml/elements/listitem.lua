/*---------------------------------------------------------
   Name: listitem
   Desc: A DPanel, a child of DPanelList
   Attributes:
   Example:
		<listitem>
			<label>Here is content</label>
		</listitem>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local p = vgui.Create("DPanel",parent);
	p:SetSize(attr.width or 100,attr.height or 100);
	parent:AddItem(p);
	
	class:HookEvents(element,p,attr);
	return p;
end

DML.Register("listitem",createElement);