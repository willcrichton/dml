/*---------------------------------------------------------
   Name: lua
   Desc: Similar to HTML's <script> tag. Runs Lua.
   Attributes:
   Example:
		<lua>
			function luaFunc() print('Hello, World'); end
		</lua>
---------------------------------------------------------*/
local function createElement(class,parent,element)
	RunString(element.content.top or "");
	return nil;
end

DML.Register("lua",createElement);