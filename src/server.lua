local moduleName = ...
local M = {}
_G[moduleName] = M

function M.getHTMLPage(pageName)
    local page = ""
    if file.open(pageName, "r") then
        text = file.read("\n")
        while (text ~= nil) do
            text = text:gsub("$HEAP", node.heap())
            page = page .. text
            text = file.read("\n")
        end
        file.close()
        return page
    else
        return ""
    end
end

function M.extractGetRequest(payload)
    local requestMatcher = "GET /[%w%.]+"
    local getValue = string.match(payload, requestMatcher)
    if (getValue == nil) then
        return "index.html"
    end
    getValue = string.sub(getValue, 6)
    return getValue
end

function M.startServer(timeout)
    print("Starting server")
    srv = net.createServer(net.TCP, timeout)
    srv:listen(80, function(conn)
        conn:on("receive", function(conn, payload)
            require("led").blinkLED(string.char(15, 127, 15), string.char(0, 0, 15), 500)

            requestedFile = M.extractGetRequest(payload)
            htmlString = M.getHTMLPage(requestedFile)
            conn:send(htmlString)
        end)
        conn:on("sent", function(conn)
            conn:close()
        end)
    end)
end

return M
