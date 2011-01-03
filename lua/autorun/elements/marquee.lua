/*---------------------------------------------------------
   Name: marquee
   Desc: Do I really need to say anything?
   Attributes:
		font: the font to display
		speed: the speed at which the text moves (a multipler, so default 1)
   Example:
		<marquee speed="4">Wheeeeee</marquee>
---------------------------------------------------------*/
local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	surface.SetFont(attr.font or "default");
	local w,h = surface.GetTextSize(content.top);
	local p = vgui.Create("DPanel",parent);
	p:SetPos(attr.x or 0,attr.y or 0);
	p:SetSize(attr.width or 100,h);
	p.MarqueeX = -w;
	function p:Paint()
		draw.DrawText(content.top,attr.font or "default",(self.MarqueeX * 0.3 * (attr.speed or 1))%(attr.width and attr.width + w or 100 + w) - w,0,attr.color and class:HexToColor(attr.color) or color_black,0);
	end
	function p:Think()
		self.MarqueeX = self.MarqueeX + 1;
	end
	
	class:HookEvents(element,p,attr);
	return p;
end

DML.Register("marquee",createElement);