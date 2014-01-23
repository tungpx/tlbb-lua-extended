--
-- Powered by IntelliJ IDEA
-- Author: sou
-- Created date: 2014/01/22 8:50 AM
-- © 2014 ShareSRC Group
--

StringUtils = {}

function StringUtils.startWith(sign, source)
    -- valid parameters
    if source == nil or string.len(source) ==0 or sign == nil or string.len(sign) ==0 then return false
        -- check
    elseif string.sub(source, 1, 1) == sign then return true
    else return false
    end
end

function StringUtils.endWith(sign, source)
    -- valid parameters
    if source == nil or string.len(source) ==0 or sign == nil or string.len(sign) ==0 then return false
    -- check
    else return sign == "" or string.sub(source, -string.len(sign)) == sign
    end
end

function StringUtils.getByIndex(index, array)
    -- valid variable
    if array == nil or table.getn(array) == 0 or table.getn(array) < index then return nil end
    -- process
    return array[index]
end

function StringUtils.seperate(source)
    return StringUtils.split(source, "%S+")
end

function StringUtils.split(source, pattern)
    -- valid parameters
    if source == nil or string.len(source) ==0 then return source end
    -- process
    local iteratorSource = string.gfind(source, pattern)
    local array = {}
    local i = 1
    for str in iteratorSource do
        array[i] = str
        i = i + 1
    end
    return array
end

return StringUtils

