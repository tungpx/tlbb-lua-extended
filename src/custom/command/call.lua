--
-- Powered by IntelliJ IDEA
-- Author: sou
-- Created date: 2014/01/22 8:14 PM
-- © 2014 ShareSRC Group
--

dofile("C:/LuaScripts/util/StringUtils.lua")

function Command_call(arguments)
    --PushDebugMessage("Command 'call' loaded")
	
	local cmd = arguments
	
	if StringUtils.endWith(")", cmd) == false then cmd = cmd.."()" end
	local func = _G[cmd]
	if func == nil then func = loadstring("return "..cmd) end
	if func == nil then
		PushDebugMessage("[ERROR] Function '"..cmd.."' not found")
	else
		--local info = debug.getinfo(func)
		--local strInfo = ""
		--for name, value in pairs(info) do
			--if name ~= "source" and name ~= "short_src" then
				--strInfo = strInfo..name.."= "..tostring(value).."; "
			--end
		--end
		--PushDebugMessage(cmd..": "..strInfo)
	
		local status, result = pcall(func)
		if status == false then
			PushDebugMessage("[ERROR] Failed to call function: "..cmd)
			PushDebugMessage(tostring(result))
		else
			PushDebugMessage(cmd.."#45 ".."("..type(result)..") "..tostring(result))
		end
	end
end

