/*---------------------------------------------------------
   Name: modelpanel
   Desc: A DModelPanel. Displays models.
   Attributes:
		model: The path to the model to display.
		campos: Vector of the camera position.
		lookat: Vector of where the camera looks.
		anim: The animation to play.
   Example:
		<modelpanel model="models/breen.mdl" lookat="0, 0, 20"></modelpanel>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes, element.content;
	local mdl = vgui.Create("DModelPanel",parent);
	class:SetSizePos(mdl,attr);
	mdl:SetModel(attr.model or "models/error.mdl");
	mdl:SetCamPos( attr.campos and class:StringToVector(attr.campos) or Vector(50,50,80) );
	mdl:SetLookAt( attr.lookat and class:StringToVector(attr.lookat) or Vector(0,0,40) );
	if attr.anim then
		mdl:SetAnimated(true);
		mdl.Entity:ResetSequence(mdl.Entity:LookupSequence(attr.anim or "walk_all"));
	end
	
	class:HookEvents(element,mdl,attr);
	return mdl;
end

DML.Register("modelpanel",createElement);