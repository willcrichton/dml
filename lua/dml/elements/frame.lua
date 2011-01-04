/*---------------------------------------------------------
   Name: frame
   Desc: The DFrame element, generally the root of your DML.
   Attributes:
		title: Title to display at upper left, default "Untitled Frame"
		draggable: Whether the frame can be dragged around the screen.
		blur: Whether the screen behind the DFrame blurs.
		showclose: Whether to show the close button in the top right.
   Example:
		<frame title="My DML Frame"></frame>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content
	local f = vgui.Create("DFrame",parent);
	f:SetSize(attr.width or 100,attr.height or 100);
	if attr.x and attr.y then f:SetPos(attr.x,attr.y)
	else f:Center(); end
	f:SetTitle(attr.title or "Untitled Frame");
	if attr.color then f.lblTitle:SetColor( class:HexToColor( attr.color ) ); end
	f.lblTitle:SetExpensiveShadow( 1, Color( 0, 0, 0, 20 ) )
	f:SetDraggable( attr.draggable and tobool(attr.draggable) or true );
	f:SetBackgroundBlur( attr.blur and tobool(attr.blur) or false );
	f:ShowCloseButton( attr.showclose and tobool(attr.showclose) or true );
	f:MakePopup();
	
	class:HookEvents(element,f,attr);
	return f;
end

DML.Register("frame",createElement);