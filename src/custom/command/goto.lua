--
-- Powered by IntelliJ IDEA
-- Author: sou
-- Created date: 2014/01/22 8:56 AM
-- © 2014 ShareSRC Group
--

dofile("C:/LuaScripts/MapData.lua")

function Command_goto(arguments)
    --PushDebugMessage("Command 'goto' loaded")

    local mapName, xPos, yPos;
    local nArguments = table.getn(arguments);
    if nArguments == 2 then
        mapName = nil
        xPos = arguments[1]
        yPos = arguments[2]
    else
        mapName = arguments[1]
        xPos = arguments[2]
        yPos = arguments[3]
    end

    -- validate map
    local mapKey;
    if mapName ~= nil then
        mapKey = MapData.getMapKey(mapName);
        if mapKey == nil then
            PushDebugMessage("[ERROR] This map is not supported: '"..mapName.."'")
            return
        end
    end
    -- validate positions
    if xPos == nil  or yPos == nil or tonumber(xPos) < 0  or tonumber(yPos) < 0 then
        PushDebugMessage("[ERROR] Invalid position coordinates")
        return
    end
    -- process
    local mapID = MapData.getMapID(mapKey);
    local curSceneID = GetSceneID();
    if mapName == nil or mapID == curSceneID then
        AutoRunToTarget(tonumber(xPos), tonumber(yPos));
    else
        AutoRunToTargetEx(tonumber(xPos), tonumber(yPos), mapID);
    end
end

