/*---------------------------------------------------------
   Name: panel
   Desc: A basic DPanel. Similar to HTML's div. Holds things.
   Attributes:
   Example:
		<panel>Text</panel>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content
	local p = vgui.Create("DPanel",parent);
	class:SetSizePos(p,attr);
	function p:PaintOver()
		draw.DrawText(content.top,attr.font or "Default",5,5,color_black,0)
		for k,text in pairs(content) do
			if k == "top" then continue; end
			/*local obj = class:FindByID(k).object;
			if obj then
				local x,y = obj:GetPos();
				draw.DrawText(text,"Default",5,y + obj:GetTall() + 5,color_black,0);
				obj:Remove();
			end*/
		end
	end
	
	class:HookEvents(element,p,attr);
	return p;
end

DML.Register("panel",createElement);