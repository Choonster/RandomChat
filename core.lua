-- The list of messages to send.
-- Each message must be wrapped in 'single quotes', "double quotes" or [[double square brackets]] and have a comma or semicolon after the closing quote/bracket.
-- Use square brackets if you want a string that contains backslashes or newlines.
local MESSAGES = {
	-- Put your messages below this line
	
	"Hello!",
	[[ Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut]],
	[[commodo accumsan nulla, non tincidunt ligula ornare vitae. Vivamus eget quam sed sapien gravida mattis. Sed porta luctus cursus. Curabitur id ipsum tortor. Ut mollis bibendum leo. Etiam bibendum, nibh sit amet eleifend mattis, est magna mattis sapien,]],
	[[eget pretium odio libero non neque. Proin scelerisque, urna vitae sollicitudin viverra, odio felis bibendum magna, eu hendrerit lacus metus non massa. Vestibulum ut est eget urna fringilla porta nec eu dui. Duis id lorem lorem, non lacinia justo. Sed]],
	[[sollicitudin ornare ipsum. Maecenas pharetra venenatis semper. Donec non tortor non dolor dapibus scelerisque et nec mi. Morbi convallis quam non enim porttitor aliquet eu in eros. Integer pellentesque, neque non commodo ornare, metus sapien vehicula]],
	[[leo, quis condimentum nulla mi ac nisi. Nulla facilisi. Maecenas pretium, nisi non rutrum rutrum, sem arcu porta odio, luctus pretium eros est sed risus. Praesent porta felis vel quam sodales porta. Pellentesque habitant morbi tristique senectus et netus]],
	[[et malesuada fames ac turpis egestas. Etiam fringilla gravida dolor, nec euismod sapien porta vitae. Vestibulum non lorem velit, nec consequat metus. Curabitur quis gravida ante. Pellentesque eget fringilla dui. Donec molestie, neque id condimentum]],
	[[consectetur, est nulla auctor sapien, ac pretium lacus erat et neque. Cras a condimentum sapien. Vestibulum ac vehicula magna. Nunc orci massa, pulvinar non faucibus adipiscing, cursus ut erat. Donec molestie, ligula vitae varius pulvinar, mauris metus]],
	[[gravida urna, vel pretium elit neque eu nisl. Fusce imperdiet, quam ac imperdiet venenatis, justo quam luctus enim, a molestie diam ipsum sed purus. Nulla facilisi.]],
	
	
	-- Put all your messages above this line.
}

-- The maximum number of Battle.net conversations you want the AddOn to support
local MAX_BN_CONVERSATIONS = 10

-------------------
-- END OF CONFIG --
-------------------

local numMessages = #MESSAGES

if numMessages <= 0 then
	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", function(self, event, ...)
		print("RandomChat: No messages were found. Add some at the top of core.lua.")
		self:UnregisterEvent(event)
	end)
	return
end

local function SendRandomMessage(chatType, target)
	local message = MESSAGES[random(numMessages)]
	if not message then return end
	
	SendChatMessage(message, chatType, nil, target)
end

local function SendRandomBNConversationMessage(target)
	local message = MESSAGES[random(numMessages)]
	if not message then return end
	
	BNSendConversationMessage(target, message)
end

local funcs = {}
local counts = {}

local overrides = {
	SMART_WHISPER = "WHISPER",
}

for slashCmd, chatType in pairs(hash_ChatTypeInfoList) do
	chatType = overrides[chatType] or chatType
	if ChatTypeInfo[chatType] then
		if not funcs[chatType] then
			funcs[chatType] = function(input, editBox)
				SendRandomMessage(chatType, input:trim())
			end
		end
		
		counts[chatType] = (counts[chatType] or 0) + 1
		
		SlashCmdList[chatType .. "_RANDOM"] = funcs[chatType]
		_G["SLASH_" .. chatType .. "_RANDOM" .. counts[chatType]] = slashCmd .. "random"
	end
end

for i = 1, MAX_WOW_CHAT_CHANNELS do
	funcs["CHANNEL" .. i] = function(input, editBox)
		SendRandomMessage("CHANNEL", i)
	end
	
	SlashCmdList["CHANNEL" .. i .. "_RANDOM"] = funcs["CHANNEL" .. i]
	_G["SLASH_CHANNEL" .. i .. "_RANDOM1"] = "/random" .. i
end

for i = 1, MAX_BN_CONVERSATIONS do
	funcs["BN_CONVERSATION" .. i] = function(input, editBox)
		SendRandomBNConversationMessage(i)
	end
	
	SlashCmdList["BN_CONVERSATION" .. i .. "_RANDOM"] = funcs["BN_CONVERSATION" .. i]
	_G["SLASH_BN_CONVERSATION" .. i .. "_RANDOM1"] = "/random" .. (i + MAX_WOW_CHAT_CHANNELS)
end