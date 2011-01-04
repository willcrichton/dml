AddCSLuaFile("dml/meta.lua");
local dir = "dml/elements/";

for _,f in pairs(file.FindInLua( dir .. "*.lua")) do
	AddCSLuaFile( dir .. f );
end
IncludeClientFile("dml/core.lua");
