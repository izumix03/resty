local cjson = require "cjson"
local ctime = ""

local args = ngx.req.get_uri_args()
if args.df == "epoch" then
    ctime = os.date("%s")
else
    ctime = os.date("%Y-%m-%dT%H:%M:%S %z")
end
if args.rf == "json" then
    ngx.header.content_type = "application/json";
    ngx.print(cjson.encode({current_time = ctime}))
else
    ngx.header.content_type = "text/plain";
    ngx.print(ctime)
end

ngx.log(ngx.WARN, "test")
