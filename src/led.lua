local moduleName = ...
local M = {}
_G[moduleName] = M

M.ledTimer = 6
M.ledPin = require("config").ledPin

function M.blinkLED(startColor, endColor, duration)
    ws2812.writergb(M.ledPin, startColor)
    tmr.alarm(M.ledTimer, duration, 0, function()
        ws2812.writergb(M.ledPin, endColor)
    end)
end

return M
