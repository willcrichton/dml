/*---------------------------------------------------------
   Name: listview
   Desc: A DListView. Useful for organizing text.
   Attributes:
   Example:
		<listview>
			<column>Col 1</column>
			<column>Col 2</column>
			<listline>
				<row>Row 1, Col 1</row>
				<row>Row 1, Col 2</row>
			</listline>
		</listview>
---------------------------------------------------------*/
local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local p = vgui.Create("DListView",parent);
	class:SetSizePos(p,attr);
	
	class:HookEvents(element,p,attr);
	return p;
end

DML.Register("listview",createElement);