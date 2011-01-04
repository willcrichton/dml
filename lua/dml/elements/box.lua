/*---------------------------------------------------------
   Name: box
   Desc: A child of a DComboBox. Contains text.
   Attributes:
		selected: Whether the box should be selected on start.
   Example:
		<box>Text!</box>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes, element.content;
	local item = parent:AddItem(content.top);
	if attr.selected and tobool(attr.selected) then item:SetSelected(true) end
	return item;
end

DML.Register("box",createElement);