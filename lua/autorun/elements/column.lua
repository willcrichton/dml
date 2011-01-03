/*---------------------------------------------------------
   Name: column
   Desc: A column of a DListView.
   Attributes:
   Example:
		<column>Column Text</column>		
---------------------------------------------------------*/
local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	parent:AddColumn(content.top);
	return nil;
end

DML.Register("column",createElement);