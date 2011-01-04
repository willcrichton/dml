/*---------------------------------------------------------
   Name: button
   Desc: The DButton element. Used for clicking purposes.
   Attributes:
   Example:
		<button DoClick="luaFunc()">Click Me</button>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local btn = vgui.Create("DButton",parent);
	btn:SetPos(attr.x or 0, attr.y or 0);
	surface.SetFont("default");
	local w,h = surface.GetTextSize(content.top);
	btn:SetSize(attr.width or w + 10,attr.height or h + 4);
	btn:SetText(content.top);

	class:HookEvents(element,btn,attr);
	return btn;
end

DML.Register("button",createElement);