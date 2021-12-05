#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=autosamba4
PKG_VERSION:=1
PKG_RELEASE:=12
PKG_ARCH:=all

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=Samba autoconfig hotplug script.
  MAINTAINER:=Lean
  DEPENDS:=+luci-app-samba4 +wsdd2
endef

define Package/$(PKG_NAME)/description
A hotplug script to config Samba4 share automatically.
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/block
	$(INSTALL_BIN) ./files/20-smb4 $(1)/etc/hotplug.d/block/20-smb4
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
