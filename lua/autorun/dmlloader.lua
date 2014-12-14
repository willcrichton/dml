AddCSLuaFile("dml/meta.lua");
AddCSLuaFile("dml/core.lua");
local dir = "dml/elements/";

for _,f in pairs(file.Find( dir.."*", "LUA")) do
    AddCSLuaFile( dir .. f );
    include( dir .. f ); 
end

include("dml/core.lua");
