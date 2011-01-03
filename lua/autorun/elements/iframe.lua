/*---------------------------------------------------------
   Name: iframe
   Desc: The HTML element. Opens webpages.
   Attributes:
		src: The URL of the webpage to open.
		controls: Whether to use the DHTMLControls element (URL bar)
   Example:
		<iframe src="http://www.facepunch.com"></iframe>
---------------------------------------------------------*/
local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local html = vgui.Create("HTML",parent);
	class:SetSizePos(html,attr);
	html:OpenURL(attr.src);
	if attr.controls and tobool(attr.controls) then
		local control = vgui.Create("DHTMLControls",parent);
		control:SetHTML(html);
		control:SetSize(html:GetWide(),32);
		html:SetTall(html:GetTall() - 32);
		local x,y = html:GetPos();
		html:SetPos(x,y+32);
	end
	
	class:HookEvents(element,html,attr);
	return html;
end

DML.Register("iframe",createElement);