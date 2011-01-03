if CLIENT then

	/*
		 _|_|_|    _|      _|  _|        
		 _|    _|  _|_|  _|_|  _|        
		 _|    _|  _|  _|  _|  _|        
		 _|    _|  _|      _|  _|        
		 _|_|_|    _|      _|  _|_|_|_|  
		 
		 Welcome to DML, or Derma Markup Language. DML is like HTML and XML, except specific for Derma in Garry's Mod.
		 This is developed by Entoros (with the help of others of course). Check Facepunch for help.
		 
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
	
	function DML.New( tree )
		local DMLObject = {
			Tree = tree or {},
			Total = 0
		}
			
		function DMLObject:Read(mkup)
			mkup = mkup:gsub("[\t]","");
			local hierarchy = {};
			self.ID = 0;
			for node,content in mkup:gmatch("(<.->)([^<>]*)") do
				node = node:gsub("\n","");
				//content = content:gsub("\n","");
				local element = { children = {}, attributes = {} };
				element.code = node:match("[^<>]+");
				element.name = element.code:match(".[^%s]+");
				if element.name:sub(1,1) == "/" then
					table.remove(hierarchy,#hierarchy);
					if content != "" then 
						local curNode = self:FindNode(hierarchy);
						curNode.content[self.ID - 1] = content;
					end
				else
					for k,v in element.code:gmatch("([%w_]+)%s*=%s*\"(.[^\"]*)\"") do
						element.attributes[k] = v;
					end
					
					element.id = self.ID;
					element.content = { top = content};
					
					if not self.Tree.name then
						self.Tree = element;
					else
						local curNode = self:FindNode(hierarchy);
						curNode.children[self.ID] = element;
					end
					
					table.insert(hierarchy,self.ID);

					self.ID = self.ID + 1;
					self.Total = self.Total + 1
					
				end
			end	
		end
		
		function DMLObject:FindNode(hierarchy)
			local t = self.Tree;
			for _,id in pairs(hierarchy) do
				t = t and t.children[id] or self.Tree
			end
			return t;
		end
		
		function DMLObject:FindByID(id,t)
			local t = t or self.Tree;
			if t.id == id then return t; end
			for _,v in pairs(t.children) do
				if v.id == id then return v;
				else return self:FindByID(id,v); end
			end
		end
		
		function DMLObject:FindNodeParent(id,t)
			local t = t or self.Tree;
			if id == self.Tree.id then return nil end;
			for _,child in pairs(t.children) do
				if child.id == id then return t;
				else return self:FindNodeParent(id,child); end
			end
		end
		
		function DMLObject:GetAll(t)
			local t = t or self.Tree;
			local collector = collector or {};
			table.insert(collector,t.object)
			for _,v in pairs(t.children) do
				local all = self:GetAllObjects(v)
				table.Add(collector,all);
			end
			
			return collector;
		end
		
		function DMLObject:Open(t,parent)
			local t = t or self.Tree;
			t.object = self:CreateElement(t,parent);
			if t.children then
				for i = 1, self.ID do
					if t.children[i] then self:Open(t.children[i],t.object); end
				end
			end
		end
		
		function DMLObject:CreateElement(element,parent)
			if DML.Elements[element.name] then 
				return DML.Elements[element.name](self,parent,element); 
			else
				ErrorNoHalt("DML Error: element '" .. element.name .. "' #" .. element.id .. " could not be created.\n");
			end
		end
		
		/* Utility functions */
		
		function DMLObject:HexToColor(hex)
			hex = hex and string.lower(hex) or "FFFFFF";
			local rgb = { string.sub(hex,1,2), string.sub(hex,3,4), string.sub(hex,5,6) }
			local hexvalues = { a = 10, b = 11, c = 12, d = 13, e = 14, f = 15 };
			for k,v in pairs(rgb) do
				local first,second = v:sub(1,1), v:sub(2,2);
				rgb[k] = 16 * ( first > "9" and hexvalues[first] or tonumber(first) ) + ( second > "9" and hexvalues[second] or tonumber(second) );
			end
			return Color(unpack(rgb));
		end
		
		function DMLObject:StringToVector(str)
			local pos = string.Explode(",",str:gsub("%s",""));
			return Vector( tonumber(pos[1]), tonumber(pos[2]), tonumber(pos[3]) );
		end
		
		function DMLObject:SetSizePos(obj,attr,defaults)
			defaults = defaults or {};
			obj:SetPos( attr.x or (defaults.x or 0), attr.y or (defaults.y or 0) );
			obj:SetSize( attr.width or (defaults.width or 100), attr.height or (defaults.height or 100) );
		end
		
		function DMLObject:HookEvents(ele,obj,attr)
			for k,v in pairs(attr) do
				if obj[k] and type(obj[k]) == "function" then 
					obj[k] = function(self)
						DML.This = self; 
						RunString(v); 
					end 
				end
			end
		end
		
		DML.CurrentDML = DMLObject;
		return DMLObject;
	end
	
	function DML.Init( dir )
		dir = dir or "autorun/elements/"
		for _,f in pairs(file.FindInLua( dir .. "*.lua")) do
			include( dir .. f);
		end
	end

	
	DML.Init();
	
	concommand.Add("dml_test",function()
		dml = DML.New();
		dml:Read([[
			<frame width="500" height="500" title="DML Test v2">
				<lua>
					function printText(str)
						LocalPlayer():ChatPrint(str);
					end
					function weaponGive(wpn)
						RunConsoleCommand("gm_giveswep",wpn);
					end
					function doPaint()
						local self = DML.This;
						draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),color_white)
					end
				</lua>
				<sheet x="10" y="30" width="480" height="460">
					<tab title="Admin" icon="gui/silkicons/user">
						<label shadow="1">Hello, Planet</label>
					</tab>
					<tab title="Weapons" icon="gui/silkicons/bomb">
						<panellist x="5" y="5" height="75" width="240">
							<listitem width="75" height="75">
								<spawnicon model="models/weapons/w_rif_ak47.mdl" onclick="weaponGive('weapon_ak47')"></spawnicon>
							</listitem>
							<listitem width="75" height="75">
								<spawnicon model="models/weapons/w_smg_tmp.mdl" onclick="weaponGive('weapon_tmp')"></spawnicon>
							</listitem>
							<listitem width="75" height="75">
								<spawnicon model="models/weapons/w_smg_mac10.mdl" onclick="weaponGive('weapon_mac10')"></spawnicon>
							</listitem>
						</panellist>
					</tab>
					<tab title="Browser" icon="gui/silkicons/wrench">
						<iframe controls="true" src="http://www.facepunch.com" x="0" y="0" width="470" height="435"></iframe>
					</tab>
					<tab title="Marquee">
						<marquee x="5" y="5" width="470" speed="20">Now we just need blink tags</marquee>
					</tab>
				</sheet>
			</frame>
		]]);
		dml:Open();
		
	end);
end