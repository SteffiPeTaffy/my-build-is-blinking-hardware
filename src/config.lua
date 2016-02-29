local moduleName = ...
local M = {}
_G[moduleName] = M

M.configName = "config.json"

function M.loadConfig()
    if file.open(M.configName, "r") then
        text = file.read("\n")
        while (text ~= nil) do
            fullText = fullText .. text
            text = file.read("\n")
        end
        file.close()

        local cjson = require "cjson"
        return cjson.decode(fullText)
    else
        return nil
    end
end

function M.storeConfig(config)
    local cjson = require "cjson"
    text = cjson.encode(config)

    if file.open(M.configName, "w") then
        file.write(text)
        file.close()
    end
end

function M.getValue(key, defaultValue)
    config = M.loadConfig()
    if config ~= nil then
        if config[key] ~= nil then
            return config[key]
        end
    end
    return defaultValue
end

function M.setValue(key, value)
    config = M.loadConfig()
    config[key] = value
    M.storeConfig(config)
end


return M
