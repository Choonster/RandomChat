local M = {}

---------------------
-- START OF CONFIG --
---------------------

-- The message groups to choose random messages from.
-- Each group has a unique name after M. This name can contain underscores, digits and uppercase letters. Names are used in the slash commands.
-- The group starts at the opening brace { and ends at the closing brace }. Between these are the messages for the group, each on a new line.
-- Each message must be wrapped in 'single quotes', "double quotes" or [[double square brackets]] and have a comma or semicolon after the closing quote/bracket.
-- To use an apostrophe in a 'single-quoted string' or a quotation mark in a "double quoted string", you need to put a backslash in front of it.
-- Use square brackets if you want a string that contains backslashes or newlines.
-- You can put a double dash -- in front of a line to comment it out, causing the interpreter to ignore it (excluding it from the group).

M.EXAMPLE_GROUP = {	
	"Hello!",
	[[ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut]],
	[[commodo accumsan nulla, non tincidunt ligula ornare vitae. Vivamus eget quam sed sapien gravida mattis. Sed porta luctus cursus. Curabitur id ipsum tortor. Ut mollis bibendum leo. Etiam bibendum, nibh sit amet eleifend mattis, est magna mattis sapien,]],
	[[eget pretium odio libero non neque. Proin scelerisque, urna vitae sollicitudin viverra, odio felis bibendum magna, eu hendrerit lacus metus non massa. Vestibulum ut est eget urna fringilla porta nec eu dui. Duis id lorem lorem, non lacinia justo. Sed]],
	[[sollicitudin ornare ipsum. Maecenas pharetra venenatis semper. Donec non tortor non dolor dapibus scelerisque et nec mi. Morbi convallis quam non enim porttitor aliquet eu in eros. Integer pellentesque, neque non commodo ornare, metus sapien vehicula]],
	[[leo, quis condimentum nulla mi ac nisi. Nulla facilisi. Maecenas pretium, nisi non rutrum rutrum, sem arcu porta odio, luctus pretium eros est sed risus. Praesent porta felis vel quam sodales porta. Pellentesque habitant morbi tristique senectus et netus]],
	[[et malesuada fames ac turpis egestas. Etiam fringilla gravida dolor, nec euismod sapien porta vitae. Vestibulum non lorem velit, nec consequat metus. Curabitur quis gravida ante. Pellentesque eget fringilla dui. Donec molestie, neque id condimentum]],
	[[consectetur, est nulla auctor sapien, ac pretium lacus erat et neque. Cras a condimentum sapien. Vestibulum ac vehicula magna. Nunc orci massa, pulvinar non faucibus adipiscing, cursus ut erat. Donec molestie, ligula vitae varius pulvinar, mauris metus]],
	[[gravida urna, vel pretium elit neque eu nisl. Fusce imperdiet, quam ac imperdiet venenatis, justo quam luctus enim, a molestie diam ipsum sed purus. Nulla facilisi.]],
}


M.GROUP_TWO = {
	"This is a message in a second group",
	"This message is also in the second group!",
	[[as is this one]],
	'and this one',
}

-------------------
-- END OF CONFIG --
-------------------

local _, ns = ...
ns.MESSAGES = M