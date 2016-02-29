local moduleName = ...
local M = {}
_G[moduleName] = M

M.ledTimer = 6
M.ledPin = tonumber(require("config").getValue('ledPin', "4"))

function M.blinkLED(startColor, endColor, duration)
    ws2812.writergb(M.ledPin, startColor)
    tmr.alarm(M.ledTimer, duration, 0, function()
        ws2812.writergb(M.ledPin, endColor)
    end)
end

return M
