/*---------------------------------------------------------
   Name: tab
   Desc: Contains a page of a <sheet>.
   Attributes:
		title: text on the tab
		icon: material of the icon on the tab
   Example:
		<sheet>
			<tab title="Tab 1"></tab>
			<tab title="Tab 2"></tab>
		</sheet>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local p = class:CreateElement({
		attributes = { width = parent:GetWide(), height=parent:GetTall()},
		content = content,
		name = "panel"
	},parent);
	parent:AddSheet(attr.title or "Untitled", p, attr.icon or "gui/silkicons/user", false, false );
	
	class:HookEvents(element,p,attr);
	return p;
end

DML.Register("tab",createElement);