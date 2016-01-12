#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=zyx-opt
PKG_VERSION:=109
PKG_RELEASE:=1

LIBC_VERSION:=<LIBC_VERSION>

include $(INCLUDE_DIR)/package.mk

define Package/zyx-opt
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libc +libgcc +libstdcpp +libpthread +librt \
		+ldconfig +findutils +terminfo
	TITLE:=provides basic toolchain libraries (dummy)
	MAINTAINER:=Entware team, entware.wl500g.info, Zyxmon
	CONFLICTS:=entware-opt
endef

define Package/zyx-opt/description
 zyx-opt is a metapackage to install Entware-ng basic libraries and scripts
 on ZyXEL Keenetic.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/zyx-opt/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/rc.unslung $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/profile $(1)/opt/etc
	$(INSTALL_DATA) ./files/rc.func $(1)/opt/etc/init.d
	touch $(1)/opt/etc/ld.so.conf
	$(INSTALL_DATA) ./files/{shells,passwd,group,screenrc} $(1)/opt/etc
	$(INSTALL_DIR) $(1)/opt/home $(1)/opt/root $(1)/opt/etc/skel
	$(INSTALL_DATA) ./files/.profile $(1)/opt/etc/skel
	$(INSTALL_DATA) ./files/.profile $(1)/opt/root
	$(INSTALL_DATA) ./files/.inputrc $(1)/opt/etc/skel
	$(INSTALL_DATA) ./files/.inputrc $(1)/opt/root
	$(INSTALL_DIR) $(1)/opt/{bin,sbin,share,tmp,usr} \
	    $(1)/opt/var/{log,lock,run} \
	    $(1)/opt/etc/ndm/{wan,user,netfilter,usb,time}.d
endef

define Package/zyx-opt/postinst
#!/bin/sh

echo -n "Updating /opt/etc/ld.so.cache... "
/opt/bin/ldconfig > /dev/null 2>&1
echo "done."
endef

$(eval $(call BuildPackage,zyx-opt))
