--
-- Powered by IntelliJ IDEA
-- Author: sou
-- Created date: 2014/01/22 8:52 AM
-- © 2014 ShareSRC Group
--

dofile("C:/LuaScripts/util/StringUtils.lua")

dofile("C:/LuaScripts/command/goto.lua")
dofile("C:/LuaScripts/command/autoatk.lua")
dofile("C:/LuaScripts/command/info.lua")
dofile("C:/LuaScripts/command/call.lua")

CommandController = {
    COMMAND_SIGN = "!";

    COMMANDS = {
        [1] = "goto",
        [2] = "autoatk",
        [3] = "info",
        ["CALL"] = "call"
    };

    MODE_STANDARD = 1;
    MODE_EXTENDED = 2;

    currentMode = MODE_STANDARD; -- default
}

---
-- Set mode for processing load commands.
-- Modes: 1-Standard (default); 2-Extended.
--
function CommandController.setMode(mode)
    -- validate mode value
    if mode ~= CommandController.MODE_EXTENDED then mode = CommandController.MODE_STANDARD end
    -- set mode value
    CommandController.currentMode = mode
end

---
-- Dispatch commands
--
function CommandController.dispatch(commandStr)
    local array = StringUtils.seperate(commandStr)
    local command = StringUtils.getByIndex(1, array)
    -- validate command
    if command == nil then return end
    -- process
    command = string.lower(command)
	
	if command == CommandController.COMMANDS["CALL"] then 
		CommandController.call(command, string.sub(commandStr, string.len(command)+1))
		return
	end
	
    local arguments = {}
    local i = 1
    for k, v in ipairs(array) do
        if k >= 2 then
            arguments[i] = string.lower(v)
            i = i + 1
        end
    end
    if CommandController.currentMode == CommandController.MODE_STANDARD then
        local i = 1
        while i <= table.getn(CommandController.COMMANDS) do
            if command == CommandController.COMMANDS[i] then
                CommandController.call(command, arguments)
                return
            end
            i = i + 1
        end
        PushDebugMessage("[ERROR] This command is not supported: '"..command.."'")
    else
        CommandController.call(command, arguments)
    end
end

---
-- Call command (All commands are stored in 'command package', each command contains global function that starts with a specified prefix)
-- @param cmdName
-- @param arguments
--
function CommandController.call(cmdName, arguments)
    local commandPrefix = "Command_"
    local func = _G[commandPrefix..cmdName]
    if func == nil then
        PushDebugMessage("[ERROR] Function '"..commandPrefix..cmdName.."()' is not existed")
        return
    end
    if type(func) ~= "function" then
        PushDebugMessage("[ERROR] '"..commandPrefix..cmdName.."' isn't a function name")
    else
        func(arguments)
    end
end

return CommandController

