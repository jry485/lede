-- Copyright (C) 2020 jerrykuku <jerrykuku@gmail.com>
-- Licensed to the public under the GNU General Public License v3.
module("luci.controller.jd-signdog", package.seeall)
function index() 
    if not nixio.fs.access("/etc/config/jd-signdog") then 
        return 
    end

    entry({"admin", "services", "jd-signdog"}, alias("admin", "services", "jd-signdog", "client"), _("JD-DailyBonus"), 10).dependent = true -- 首页
    entry({"admin", "services", "jd-signdog", "client"}, cbi("jd-signdog/client"),_("Client"), 10).leaf = true -- 基本设置
    entry({"admin", "services", "jd-signdog", "log"},form("jd-signdog/log"),_("Log"), 30).leaf = true -- 日志页面
    entry({"admin", "services", "jd-signdog", "script"},form("jd-signdog/script"),_("Script"), 20).leaf = true -- 直接配置脚本
    entry({"admin", "services", "jd-signdog", "run"}, call("run")) -- 执行程序
    entry({"admin", "services", "jd-signdog", "update"}, call("update")) -- 执行更新
    entry({"admin", "services", "jd-signdog", "check_update"}, call("check_update")) -- 检查更新
    entry({"admin", "services", "jd-signdog", "check_serverchan"}, call("check_serverchan")) -- 执行serverchan测试
end

--执行serverchan测试
function check_serverchan()
	local e = {}
	local key= luci.http.formvalue("key")
	local failed = luci.http.formvalue("failed")
	local serverurl= luci.http.formvalue("serverurl")

	if key ~= " " then
		local uci = luci.model.uci.cursor()	
		local name = ""
    		uci:foreach("vssr", "global", function(s) name = s[".name"] end)
    
		if serverurl~= "scu" then
        	uci:set("jd-signdog", '@global[0]', 'dingding', key)
		else
		uci:set("jd-signdog", '@global[0]', 'serverchan', key)
		end

       	 	uci:set("jd-signdog", '@global[0]', 'failed', failed)
		uci:set("jd-signdog", '@global[0]', 'serverurl', serverurl)
 		uci:save("jd-signdog") 	
		uci:commit("jd-signdog")
	
		e.error =luci.sys.call("/usr/share/jd-signdog/newapp.sh -m")
	else
		e.error = 1
	end

	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end

-- 执行程序

function run()
    local e = {}
    local uci = luci.model.uci.cursor()
    local cookie = luci.http.formvalue("cookies")
    local cookie2 = luci.http.formvalue("cookies2")
    local auto_update = luci.http.formvalue("auto_update")
    local auto_update_time = luci.http.formvalue("auto_update_time")
    local auto_run = luci.http.formvalue("auto_run")
    local auto_run_time = luci.http.formvalue("auto_run_time")
    local stop = luci.http.formvalue("stop")
    local serverurl= luci.http.formvalue("serverurl")
    local key= luci.http.formvalue("key")
    local failed = luci.http.formvalue("failed")
    local jd_enable= luci.http.formvalue("jd_enable")
    local name = ""
    uci:foreach("vssr", "global", function(s) name = s[".name"] end)

    if cookie ~= " " then
        uci:set("jd-signdog", '@global[0]', 'auto_update', auto_update)
        uci:set("jd-signdog", '@global[0]', 'auto_update_time', auto_update_time)
        uci:set("jd-signdog", '@global[0]', 'auto_run', auto_run)
        uci:set("jd-signdog", '@global[0]', 'auto_run_time', auto_run_time)
        uci:set("jd-signdog", '@global[0]', 'stop', stop)
        uci:set("jd-signdog", '@global[0]', 'cookie', cookie)
        uci:set("jd-signdog", '@global[0]', 'cookie2', cookie2)
        uci:set("jd-signdog", '@global[0]', 'serverurl', serverurl)
	uci:set("jd-signdog", '@global[0]', 'jd_enable', jd_enable)

    	if serverurl~= "scu" then
        uci:set("jd-signdog", '@global[0]', 'dingding', key)
	else
	uci:set("jd-signdog", '@global[0]', 'serverchan', key)
	end

        uci:set("jd-signdog", '@global[0]', 'failed', failed)
        uci:save("jd-signdog")
        uci:commit("jd-signdog")
        luci.sys.call("/usr/share/jd-signdog/newapp.sh -r")
        luci.sys.call("/usr/share/jd-signdog/newapp.sh -a")
        e.error = 0
    else
        e.error = 1
    end

    luci.http.prepare_content("application/json")
    luci.http.write_json(e)

end

--检查更新
function check_update()
    local jd = "jd-signdog"
    local e = {}
    local new_version = luci.sys.exec("/usr/share/jd-signdog/newapp.sh -n")
    e.new_version = new_version
    e.error = 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end

--执行更新
function update()
    local jd = "jd-signdog"
    local e = {}
    local uci = luci.model.uci.cursor()
    local version = luci.http.formvalue("version")
    --下载脚本
    local code = luci.sys.exec("/usr/share/jd-signdog/newapp.sh -u")
    e.error = code
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end