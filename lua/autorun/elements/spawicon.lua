/*---------------------------------------------------------
   Name: spawnicon
   Desc: A clickable square with a model on it. Seen
		prominently in the spawnmenu.
   Attributes:
		size: the icon size (all icons are square)
		model: the model to display
		tooltip: the text displayed on hover
   Example:
		<spawnicon size="32" model="models/error.mdl"></spawnicon>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local spwn = vgui.Create("SpawnIcon",parent);
	spwn:SetPos(attr.x or 0, attr.y or 0);
	spwn:SetIconSize(attr.size or 75);
	spwn:SetModel(attr.model or "models/error.mdl");
	if attr.tooltip then spwn:SetToolTip(attr.tooltip) end
	
	class:HookEvents(element,spwn,attr);
	return spwn;
end

DML.Register("spawnicon",createElement);