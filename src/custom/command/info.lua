--
-- Powered by IntelliJ IDEA
-- Author: sou
-- Created date: 2014/01/22 11:03 AM
-- © 2014 ShareSRC Group
--

function Command_info(arguments)
    --PushDebugMessage("Command 'info' loaded")

    local infoType = arguments[1]

    -- validate info type value
    if infoType == nil or string.len(infoType) == 0 then return end
    -- process
    infoType = string.lower(infoType)
    if "map" == infoType then PushDebugMessage("[INFO] Map: "..GetCurrentSceneName().." (ID = "..GetSceneID()..")")
    end
end

