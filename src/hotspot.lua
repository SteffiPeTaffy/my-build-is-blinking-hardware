local moduleName = ...
local M = {}
_G[moduleName] = M

function M.startHotspot()
    print("Starting hotspot")
    local cfg = {}
    cfg.ssid = require("config").getValue('hotspotName', "EPS Test AP")
    cfg.pwd = require("config").getValue('hotspotPass', "password")

    wifi.setmode(wifi.SOFTAP)
    wifi.ap.config(cfg)
end

return M
