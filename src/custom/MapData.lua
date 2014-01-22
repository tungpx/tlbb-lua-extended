--
-- Powered by IntelliJ IDEA
-- Author: sou
-- Created date: 2014/01/22 8:54 AM
-- © 2014 ShareSRC Group
--

MapData = {
    MAPS = {
        ["DAI_LY"] = {"daily", "dl", ["ID"]=2},
        ["LAC_DUONG"] = {"lacduong", "ld", ["ID"]=0},
        ["TO_CHAU"] = {"tochau", "tc", ["ID"]=1},
        ["LAU_LAN"] = {"laulan", "ll", ["ID"]=246},
        ["THUC_HA_CO_TRAN"] = {"thuchacotran", "thct", ["ID"]=260},
        ["THIEN_LONG_TU"] = {"thienlongtu", "tlt", ["ID"]=13},
        ["MO_DUNG_SON_TRANG"] = {"modungsontrang", "mdst", ["ID"]=284},
        ["TINH_TUC_HAI"] = {"tinhtuchai", "tth", ["ID"]=16}
    }
}

function MapData.getMapKey(map)
    -- validate map name
    if map == nil then return nil end
    -- process
    map = string.lower(map)
    for key, value in pairs(MapData.MAPS) do
        for k, v in pairs(value) do
            if v == map then return key end
        end
    end
    return nil
end

function MapData.getMapID(mapKey)
    -- validate map key
    if mapKey == nil then return -1 end
    -- process
    mapKey = string.upper(mapKey)
    for key in pairs(MapData.MAPS) do
        if(key == mapKey) then return MapData.MAPS[key]["ID"] end
    end
    return -1
end

return MapData

