/*---------------------------------------------------------
   Name: option
   Desc: Not really an object, just text in a DMultiChoice (<select> tag)
   Attributes:
   Example:
		<select>
			<option>Choice #1</option>
			<option>Choice #2</option>
		</select>
---------------------------------------------------------*/

local function createElement(class,parent,element)
	local attr,content = element.attributes,element.content;
	parent:AddChoice(content.top);
	return content.top;
end

DML.Register("option",createElement);