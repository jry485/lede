f = SimpleForm("pushserver")
luci.sys.call("/usr/bin/pushserver/pushserver client")
f.reset = false
f.submit = false
f:append(Template("pushserver/client"))
return f
