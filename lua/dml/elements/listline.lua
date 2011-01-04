/*---------------------------------------------------------
   Name: listline
   Desc: A wrapper for the items in a row of a DListView.
   Attributes:
   Example:
		<listline>
			<row>Row 1</row>
			<row>Row 2</row>
		</listline>
---------------------------------------------------------*/
local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local line = vgui.Create("DListView_Line",parent.pnlCanvas);
	table.insert(parent.Lines,line);
	line:SetListView(parent);
	local SortID = table.insert( parent.Sorted, line )
	if ( SortID % 2 == 1 ) then
		line:SetAltLine( true )
	end
	line.curCol = 1;
	
	class:HookEvents(element,line,attr);
	return line;
end

DML.Register("listline",createElement);