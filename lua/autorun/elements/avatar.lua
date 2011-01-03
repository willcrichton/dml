/*---------------------------------------------------------
   Name: avatar
   Desc: Display's a player Steam avatar.
   Attributes:
		playerid: The SteamID or UniqueID of the player to display.
   Example:
		<avatar playerid="STEAM_0:1:9656311"></avatar>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	local ava = vgui.Create("AvatarImage",parent);
	class:SetSizePos(ava,attr,{width=32,height=32});
	for _,pl in pairs(player.GetAll()) do
		if attr.playerid == pl:SteamID() or attr.playerid == pl:UniqueID() then ava:SetPlayer(pl) end
	end
	
	class:HookEvents(element,ava,attr);
	return ava;
end

DML.Register("avatar",createElement);