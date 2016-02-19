local moduleName = ... 
local M = {}
_G[moduleName] = M

function M.blinkLED(color)
    ws2812.writergb(4, color)
    tmr.alarm(6, 500, 0, function() 
        ws2812.writergb(4, string.char(0,0,16))
    end )
end

function M.getHTMLPage(pageName)
  local page = ""
  file.open(pageName, "r")
  text = file.read("\n")
  while (text ~= nil) do
    text = text:gsub("$HEAP", node.heap())
    page = page .. text
    text = file.read()
  end  
  file.close()  
  return page
end

function M.startHotspot() 
    print("Starting hotspot")
    local cfg={}
    cfg.ssid="ESP Test AP"
    cfg.pwd="password"
    
    wifi.setmode(wifi.SOFTAP)
    wifi.ap.config(cfg)
end

function M.startServer(timeout)
    print("Starting server")
    srv=net.createServer(net.TCP, timeout)
    srv:listen(80,function(conn)
      conn:on("receive",function(conn,payload)
        require("led").blinkLED(string.char(15,127,15), string.char(0,0,15), 500)
        print(payload)
        htmlString = M.getHTMLPage("index.html")
        conn:send(htmlString)
      end)
      conn:on("sent",function(conn)
        conn:close()
      end)
    end)
end

return M
