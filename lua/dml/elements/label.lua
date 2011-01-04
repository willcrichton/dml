/*---------------------------------------------------------
   Name: label
   Desc: The DLabel element. Displays text.
   Attributes:
		font: The font to display (default is "default")
		color: The color of the text to display
		wrap: Whether the text should wrap (otherwise it's clipped off the end)
		shadow: Whether to draw text shadow.
   Example:
		<label font="ScoreboardText" color="FFFFFF">Text!</label>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content
	local lbl = Label(content.top,parent);
	lbl:SetPos(attr.x or 0,attr.y or 0);
	lbl:SetTextColor( attr.color and class:HexToColor(attr.color) or color_black );
	lbl:SetFont(attr.font or "default");
	lbl:SetWrap(attr.wrap and tobool(attr.wrap) or false);
	lbl:SetExpensiveShadow(attr.shadow and tobool(attr.shadow) or false);
	surface.SetFont(attr.font or "default");
	local w,h = surface.GetTextSize(content.top);
	lbl:SetSize(w,h);
	
	class:HookEvents(element,lbl,attr);
	return lbl;
end

DML.Register("label",createElement);