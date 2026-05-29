local aws = require "resty.aws-signature"

local host = "minio"

-- rewritten URI only
local uri = ngx.var.uri

-- IMPORTANT:
-- remove browser secure_link params before signing
ngx.req.set_uri_args({})

aws.s3_set_headers(host, uri)

ngx.log(ngx.ERR, "SIGNED HOST=", host)
ngx.log(ngx.ERR, "SIGNED URI=", uri)
ngx.log(ngx.ERR, "ARGS CLEARED")