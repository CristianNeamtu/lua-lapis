local lapis = require("lapis")
local console = require("lapis.console")

local app = lapis.Application()

app:enable("etlua")

app:get("/", function()
  return "Welcome to Lapis " .. require("lapis.version")
end)

app:get("/index", function(self)
  return { render = "index" }
end)
app:match("/console", console.make())

return app
