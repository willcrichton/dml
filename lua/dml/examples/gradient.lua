/* Lua stuff goes up here. In this instance, we create some nice paint functions for a pretty menu. */

GRADIENT_HORIZONTAL = 0;
GRADIENT_VERTICAL = 1;
function draw.LinearGradient(x,y,w,h,from,to,dir,res)
	dir = dir or GRADIENT_HORIZONTAL;
	if dir == GRADIENT_HORIZONTAL then res = (res and res <= w) and res or w;
	elseif dir == GRADIENT_VERTICAL then res = (res and res <= h) and res or h; end
	for i=1,res do
		surface.SetDrawColor(
			Lerp(i/res,from.r,to.r),
			Lerp(i/res,from.g,to.g),
			Lerp(i/res,from.b,to.b),
			Lerp(i/res,from.a,to.a)
		);
		if dir == GRADIENT_HORIZONTAL then surface.DrawRect(x + w * (i/res), y, w/res, h );
		elseif dir == GRADIENT_VERTICAL then surface.DrawRect(x, y + h * (i/res), w, h/res ); end
	end
end

function drawFrame()
	// DML.This is (currently) the universal reference to the current object to paint.
	local self = DML.This;
	draw.LinearGradient(0,0,self:GetWide(),20,Color(226,226,226),Color(213,213,213),GRADIENT_VERTICAL);
	draw.LinearGradient(0,20,self:GetWide(),2,Color(158,158,158),Color(230,230,230),GRADIENT_VERTICAL);
	draw.LinearGradient(0,22,self:GetWide(),self:GetTall()-22,Color(213,213,213),Color(190,190,190),GRADIENT_VERTICAL);
end

function drawPanel()
	local self = DML.This;
	draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(153,153,153));
	draw.RoundedBox(0,1,1,self:GetWide()-2,self:GetTall()-2,Color(230,230,230));
end

/* Here's where we start the actual DML. */

// This creates a new DMLReader.
local dml = DML.New();

local mkup = [[
	<frame width="300" height="300" title="DML Example" color="666666" Paint="drawFrame()">
		<panel x="10" y="30" width="280" height="260" Paint="drawPanel()">
			<numslider x="5" y="5" width="270" min="0" max="600" convar="sv_gravity" text="Gravity"></numslider>
			<combobox x="5" y="50" width="130" height="180">
]]
// You can indeed use Lua in your markup! It does get a bit messy though. It's not quite like PHP and HTML.
for _,v in pairs(player.GetAll()) do mkup = mkup .. "<box>" .. v:Nick() .. "</box>"; end
mkup = mkup .. [[
			</combobox>
			<button x="5" y="235" width="130">Slay</button>
			<listview x="140" y="50" width="135" height="200">
				<column>Name</column>
				<column>Frags</column>
]]
for _,v in pairs(player.GetAll()) do mkup = mkup .. "<listline><row>" .. v:Nick() .. "</row><row>" .. v:Frags() .. "</row></listline>"; end
mkup = mkup.. [[
			</listview>
		</panel>
	</frame>
]];

// This reads in the markup.
dml:Read(mkup);

// This runs the markup.
dml:Open();