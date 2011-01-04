/*---------------------------------------------------------
   Name: sysbutton
   Desc: The DSysButton element. Used for clicking purposes (no text).
   Attributes:
		type: The type of button to be. See 
			http://wiki.garrysmod.com/?title=DSysButton.SetType 
			for full list.
   Example:
		<sysbutton type="tick"></sysbutton>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local btn = vgui.Create("DSysButton",parent);
	class:SetSizePos(btn,attr,{width=20,height=20});
	btn:SetType(attr.type or "close");

	class:HookEvents(element,btn,attr);
	return btn;
end

DML.Register("sysbutton",createElement);