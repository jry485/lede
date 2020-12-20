f = SimpleForm("pushserver")
f.reset = false
f.submit = false
f:append(Template("pushserver/log"))
return f
