#
# Copyright (C) 2008-2014 The LuCI Team <luci@lists.subsignal.org>
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk
PKG_NAME:=luci-app-jd-signdog
LUCI_PKGARCH:=all
PKG_VERSION:=0.8.9
PKG_RELEASE:=20201230

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-jd-signdog
 	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=Luci for JD dailybonus Script 
	PKGARCH:=all
	DEPENDS:=+node +wget
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/jd-signdog
endef

define Package/luci-app-jd-signdog/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./root/etc/config/jd-signdog $(1)/etc/config/jd-signdog

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/* $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./root/etc/uci-defaults/* $(1)/etc/uci-defaults/

	$(INSTALL_DIR) $(1)/usr/share/jd-signdog
	$(INSTALL_BIN) ./root/usr/share/jd-signdog/*.sh $(1)/usr/share/jd-signdog/
	$(INSTALL_DATA) ./root/usr/share/jd-signdog/*.js $(1)/usr/share/jd-signdog/

	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/* $(1)/usr/share/rpcd/acl.d

	$(INSTALL_DIR) $(1)/usr/lib/node
	cp -pR ./root/usr/lib/node/* $(1)/usr/lib/node

	$(INSTALL_DIR) $(1)/www/jd-signdog
	$(INSTALL_DATA) ./root//www/jd-signdog/* $(1)/www/jd-signdog

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/* $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/jd-signdog
	$(INSTALL_DATA) ./luasrc/model/cbi/jd-signdog/* $(1)/usr/lib/lua/luci/model/cbi/jd-signdog/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/jd-signdog
	$(INSTALL_DATA) ./luasrc/view/jd-signdog/* $(1)/usr/lib/lua/luci/view/jd-signdog/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	po2lmo ./po/zh-cn/jd-signdog.po $(1)/usr/lib/lua/luci/i18n/jd-signdog.zh-cn.lmo
endef

$(eval $(call BuildPackage,luci-app-jd-signdog))

# call BuildPackage - OpenWrt buildroot signature
