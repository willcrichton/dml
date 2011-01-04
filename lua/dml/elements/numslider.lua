/*---------------------------------------------------------
   Name: numslider
   Desc: A DNumSlider. Allows the user to select a number on a line.
   Attributes:
		text: The text to display in the top left.
		min: Minimum value the slider can reach.
		max: Maximum value the slider can reach.
		decimals: The # of decimal places the slider can have (0 for integers)
		convar: The convar to change.
   Example:
		<numslider text="Test" min="0" max="600" convar="sv_gravity"></numslider>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes, element.content;
	local slider = vgui.Create("DNumSlider",parent);
	class:SetSizePos(slider,attr,{height=35});
	slider:SetText(attr.text or "");
	slider.Label:SetTextColor(attr.color and class:HexToColor(attr.color) or color_black);
	slider:SetMin(tonumber(attr.min) or 0);
	slider:SetMax(tonumber(attr.max) or 1);
	slider:SetDecimals(tonumber(attr.decimals) or 0);
	if attr.convar then slider:SetConVar(attr.convar) end

	class:HookEvents(element,slider,attr);
	return slider;
end

DML.Register("numslider",createElement);