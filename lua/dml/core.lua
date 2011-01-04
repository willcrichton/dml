/*	
	 _|_|_|    _|      _|  _|        
	 _|    _|  _|_|  _|_|  _|        
	 _|    _|  _|  _|  _|  _|        
	 _|    _|  _|      _|  _|        
	 _|_|_|    _|      _|  _|_|_|_|  
	 
	 Welcome to DML, or Derma Markup Language. DML is like HTML and XML, except specific for Derma in Garry's Mod.
	 This is developed by Entoros (with the help of others of course).
	 
	 -- Q&A --
	 Q: I'm confused... how do I start?
	 A: See the "help.lua" file in the lua/autorun folder. It will give you a run through of how DML works.
	 
	 Q: Where's the documentation?
	 A: All tags are documented in their respective files (look in the lua/autorun/elements directory). There is also a short description below.
	 
	 Q: Where can I ask you questions?
	 A: Check out the DML thread in the Lua Releases section on Facepunch.
	 
	 Currently available tags:
		avatar -- Display a player's Steam avatar (AvatarImage).
		box -- An item in a <combobox>.
		button -- Clickable text element (DButton).
		column -- Column name of a DListView.
		combobox -- Selectable list of text. (DComboBox)
		frame -- Usually your main container for all items (DFrame).
		iframe -- An HTML display (HTML).
		img -- Displays materials (DImage).
		imgbutton -- Displays materials clickably (DImageButton).
		label -- Shows text (DLabel).
		listitem -- Child of a DPanelList. 
		listline -- Container for row text in a DListView.
		lua -- Runs a Lua script.
		marquee -- IE5 YEEHAWW
		numslider -- User can select numbers on a number line (DNumSlider).
		option -- Child of a <select>.
		panel -- Container for objects, similar to HTML <div> (DPanel).
		panellist -- Holds items, uses <listitem> for top-level child.
		row -- A single row of text in a <listline>.
		select -- Has options to choose from (DMultiChoice).
		sheet -- Allows tabbed pages (DPropertySheet).
		spawnicon -- Displays a model (SpawnIcon).
		style -- Emulates CSS. Still a WIP.
		sysbutton -- A button, except has little icons.
		tab -- A single tab of a <sheet>.
*/

/*
	Known issues:
		1. panels won't draw text below children
		2. DPanelList children won't display correctly
*/

DML = { Elements = {} };

function DML.Register( key, value )
	DML.Elements[key] = value;
end

local dir = "dml/elements/";
include("dml/meta.lua");

for _,f in pairs(file.FindInLua( dir .. "*.lua")) do
	include( dir .. f );
end


function DML.New( tree )
	local DMLReader = {
		Tree = tree or {},
		Total = 0
	}
	
	setmetatable(DMLReader,DML.meta);		
	
	DML.CurrentDML = DMLReader;
	return DMLReader;
end