# Copyright (C) 2020 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-pushserver
PKG_VERSION:=2.00
PKG_RELEASE:=6

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  DEPENDS:=+iputils-arping +curl
  TITLE:=LuCI support for pushserver
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/pushserver
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/usr/bin/pushserver $(1)/etc/config $(1)/usr/lib/lua/luci $(1)/etc/uci-defaults $(1)/usr/share/rpcd/acl.d
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_CONF) ./root/etc/config/pushserver $(1)/etc/config
	$(INSTALL_BIN) ./root/etc/init.d/pushserver $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/uci-defaults/luci-pushserver $(1)/etc/uci-defaults/luci-pushserver
	$(INSTALL_BIN) ./root/usr/bin/pushserver/pushserver $(1)/usr/bin/pushserver
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-pushserver.json $(1)/usr/share/rpcd/acl.d/luci-app-pushserver.json
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
