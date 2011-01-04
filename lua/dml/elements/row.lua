/*---------------------------------------------------------
   Name: row
   Desc: A row of a DListView.
   Attributes:
   Example:
		<listline>
			<row>Row 1, Col 1</row>
			<row>Row 1, Col 2</row>
		</listline>
---------------------------------------------------------*/
local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	parent:SetColumnText(parent.curCol,content.top);
	parent.curCol = parent.curCol + 1;
	return nil;
end

DML.Register("row",createElement);