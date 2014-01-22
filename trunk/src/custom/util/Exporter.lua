--
-- Powered by IntelliJ IDEA
-- Author: sou
-- Created date: 2014/01/22 11:13 AM
-- © 2014 ShareSRC Group
--

Exporter = {}

function Exporter.exportGlobalFunctions(outFilePath)
    local file = io.open(outFilePath, "a")
    local text = ""
    for n, v in pairs(_G) do
        if type(v) == "function" then
            local info = debug.getinfo(v)
            local strInfo = "\t\t\t"
            for name, value in pairs(info) do
                if name ~= "source" and name ~= "short_src" then
                    strInfo = strInfo..name.."= "..tostring(value).."; "
                end
            end
            text = text..n..strInfo.."\n"
        end
    end
    file:write(text)
    file:flush()
    file:close()
end

function Exporter.exportGlobalTables(outFilePath)
    local file = io.open(outFilePath, "a")
    local text = ""
    for n, v in pairs(_G) do
        if type(v) == "table" and n ~= "_G" then
            local strInfo = "\t\t\t"
            for name, value in pairs(v) do
                strInfo = strInfo..name.."= "..tostring(value).."; "
            end
            text = text..n..strInfo.."\n"
        end
    end
    file:write(text)
    file:flush()
    file:close()
end

function Exporter.exportGlobalOthers(outFilePath)
    local file = io.open(outFilePath, "a")
    local text = ""
    for n, v in pairs(_G) do
        if type(v) ~= "table" and type(v) ~= "function" then
            local strInfo = "\t\t\t"..tostring(v)
            text = text..n..strInfo.."\n"
        end
    end
    file:write(text)
    file:flush()
    file:close()
end

return Exporter