-- The maximum number of Battle.net conversations you want the AddOn to support
local MAX_BN_CONVERSATIONS = 10

-------------------
-- END OF CONFIG --
-------------------

local random = math.random

local addon, ns = ...
local MESSAGES = ns.MESSAGES

local function GetRandomMessage(input, targeted)
	local target, groupName;
	if targeted then -- This is for a targeted chatType, the target will be the first "word" of the input
		target, groupName = input:match("^(%S+)%s*(.*)$")
		target = tonumber(target) or target
	else
		groupName = input
	end
	
	groupName = groupName:upper()
	local group = MESSAGES[groupName]
	
	if not group then
		print(("RandomChat: Invalid group name %q."):format(groupName or ""))
		return nil, nil
	end
	
	local numMessages = #group
	if numMessages == 0 then
		print(("RandomChat: Group %q appears to be empty."):format(groupName or ""))
		return nil, nil
	end
	
	local message = group[random(numMessages)]
	
	return message, target
end

local function SendRandomMessage(chatType, input, targeted)
	local message, target = GetRandomMessage(input, targeted)
	if not message then return end
	
	SendChatMessage(message, chatType, nil, target)
end

local function SendRandomChannelMessage(channel, input)
	local message = GetRandomMessage(input, false)
	if not message then return end
	
	SendChatMessage(message, "CHANNEL", nil, channel)
end

local function SendRandomBNConversationMessage(index, input)
	local message = GetRandomMessage(input, false)
	if not message then return end
	
	BNSendConversationMessage(index, message)
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
			
			local isTargeted = chatType == "WHISPER" -- Of the normal chatTypes, only whisper requires the target to be specified in the input.
			funcs[chatType] = function(input, editBox)
				SendRandomMessage(chatType, input:trim(), isTargeted)
			end
		
		end
		
		counts[chatType] = (counts[chatType] or 0) + 1
		
		SlashCmdList[chatType .. "_RANDOM"] = funcs[chatType]
		_G["SLASH_" .. chatType .. "_RANDOM" .. counts[chatType]] = slashCmd .. "random"
	end
end

for i = 1, MAX_WOW_CHAT_CHANNELS do
	funcs["CHANNEL" .. i] = function(input, editBox)
		SendRandomChannelMessage(i, input:trim())
	end
	
	SlashCmdList["CHANNEL" .. i .. "_RANDOM"] = funcs["CHANNEL" .. i]
	_G["SLASH_CHANNEL" .. i .. "_RANDOM1"] = "/random" .. i
end

for i = 1, MAX_BN_CONVERSATIONS do
	funcs["BN_CONVERSATION" .. i] = function(input, editBox)
		SendRandomBNConversationMessage(i, input:trim())
	end
	
	SlashCmdList["BN_CONVERSATION" .. i .. "_RANDOM"] = funcs["BN_CONVERSATION" .. i]
	_G["SLASH_BN_CONVERSATION" .. i .. "_RANDOM1"] = "/random" .. (i + MAX_WOW_CHAT_CHANNELS)
end