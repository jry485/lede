include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-unblockmusic
PKG_VERSION:=2.3.5
PKG_RELEASE:=17

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/config
menu "Configuration"

config UnblockNeteaseMusic_Go
	bool "UnblockNeteaseMusic Golang Version"
	default y if i386||x86_64||arm||aarch64

config UnblockNeteaseMusic_NodeJS
	bool "UnblockNeteaseMusic NodeJS Version"
	depends on HAS_FPU || KERNEL_MIPS_FPU_EMULATOR || SOFT_FLOAT
	default y if i386||x86_64||arm||aarch64

endmenu
endef

PKG_CONFIG_DEPENDS := \
	CONFIG_UnblockNeteaseMusic_Go \
	CONFIG_UnblockNeteaseMusic_NodeJS

define Package/$(PKG_NAME)
 	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for Unblock NeteaseCloudMusic
	PKGARCH:=all
	DEPENDS:=+dnsmasq-full +ipset +uclient-fetch +UnblockNeteaseMusic_NodeJS:UnblockNeteaseMusic +UnblockNeteaseMusic_Go:UnblockNeteaseMusic-Go
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/unblockmusic
endef

define Package/$(PKG_NAME)/install
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci

	$(INSTALL_DIR) $(1)/
	cp -pR ./root/* $(1)/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	po2lmo ./po/zh-cn/unblockmusic.po $(1)/usr/lib/lua/luci/i18n/unblockmusic.zh-cn.lmo
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/unblockmusic ) && rm -f /etc/uci-defaults/unblockmusic
	rm -rf /tmp/luci-indexcache
	rm -rf /tmp/luci-modulecache/*
	chmod 755 /etc/init.d/unblockmusic >/dev/null 2>&1
	/etc/init.d/unblockmusic enable >/dev/null 2>&1
fi
exit 0
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
     /etc/init.d/unblockmusic disable
     /etc/init.d/unblockmusic stop
fi
exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
