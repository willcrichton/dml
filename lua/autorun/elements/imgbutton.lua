/*---------------------------------------------------------
   Name: imgbutton
   Desc: The DImageButton element. Like a DButton + DImage
   Attributes:
		src: The texture you want to display
   Example:
		<imgbutton src="console/gmod_logo" DoClick="luaFunc()"></imgbutton>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local btn = vgui.Create("DImageButton",parent);
	class:SetSizePos(btn,attr);
	btn:SetImage(attr.src or "VGUI/swepicon");
	
	class:HookEvents(element,btn,attr);
	return btn;
end

DML.Register("imgbutton",createElement);