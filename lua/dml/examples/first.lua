/*
	This is a simple DML.
	...Yep. Read the tutorial on the wiki if you're confused.
	http://wiki.garrysmod.com/?title=DML_Tutorial
*/

local dml = DML.New();
dml:Read([[
	<frame width="400" height="100" title="My First DML">
		<panel x="5" y="25" width="390" height="70">
			<label x="45" y="25" font="ScoreboardText" color="FF0000">You've successfully created your first DML!</label>
		</panel>
	</frame>
]]);
dml:Open();