# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for VSFTPD
# LUCI_DEPENDS:=+vsftpd-alt
LUCI_PKGARCH:=all
PKG_VERSION:=1.0
PKG_RELEASE:=3
PKG_NAME:=luci-app-vsftpd

PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Sftp 

LUCI_DEPENDS:=+vsftpd-alt \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Sftp:openssh-sftp-server \

define Package/$(PKG_NAME)/config

config PACKAGE_$(PKG_NAME)_INCLUDE_Sftp
	bool "Include Openssh-sftp-server"
	default n

endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature

