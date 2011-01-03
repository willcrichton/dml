/*---------------------------------------------------------
   Name: iframe
   Desc: The HTML element. Opens webpages.
   Attributes:
		src: The URL of the webpage to open.
		color: The color of the image.
   Example:
		<img src="console/gmod_logo"></img>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local img = vgui.Create("DImage",parent);
	class:SetSizePos(img,attr);
	img:SetImage(attr.src or "VGUI/swepicon");
	img:SetImageColor(attr.color and class:HexToColor(attr.color) or color_white);
	class:HookEvents(element,img,attr);
	return img;
end

DML.Register("img",createElement);