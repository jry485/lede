module("luci.controller.pushserver",package.seeall)

function index()

	if not nixio.fs.access("/etc/config/pushserver")then
		return
	end

	entry({"admin", "services", "pushserver"}, alias("admin", "services", "pushserver", "setting"),_("推送"), 30).dependent = true
	entry({"admin", "services", "pushserver", "setting"}, cbi("pushserver/setting"),_("配置"), 40).leaf = true
	entry({"admin", "services", "pushserver", "advanced"}, cbi("pushserver/advanced"),_("高级设置"), 50).leaf = true
	entry({"admin", "services", "pushserver", "client"}, form("pushserver/client"), "在线设备", 80)
	entry({"admin", "services", "pushserver", "log"}, form("pushserver/log"),_("日志"), 99).leaf = true
	entry({"admin", "services", "pushserver", "get_log"}, call("get_log")).leaf = true
	entry({"admin", "services", "pushserver", "clear_log"}, call("clear_log")).leaf = true
	entry({"admin", "services", "pushserver", "status"}, call("act_status")).leaf = true
end

function act_status()
	local e={}
	e.running=luci.sys.call("ps|grep -v grep|grep -c pushserver >/dev/null")==0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

function get_log()
	luci.http.write(luci.sys.exec(
		"[ -f '/tmp/pushserver/pushserver.log' ] && cat /tmp/pushserver/pushserver.log"))
end

function clear_log()
	luci.sys.call("echo '' > /tmp/pushserver/pushserver.log")
end
