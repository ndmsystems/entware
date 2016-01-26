#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=opt-ndmsv1
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_FLAGS:=essential

include $(INCLUDE_DIR)/package.mk

define Package/opt-ndmsv1
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+libc +libgcc +libstdcpp +libpthread +librt \
		+ldconfig +findutils +terminfo
	TITLE:=provides basic toolchain libraries (dummy)
	MAINTAINER:=Entware team, http://entware.net
endef

define Package/opt-ndmsv1/description
 opt-ndmsv1 is a metapackage to install Entware-ng basic libraries and scripts
 on ZyXEL Keenetic routers with NDMS v1.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/opt-ndmsv1/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/rc.unslung $(1)/opt/etc/init.d
	$(INSTALL_DATA) ./files/rc.func $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S01swap $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/profile $(1)/opt/etc
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

define Package/opt-ndmsv1/postinst
#!/bin/sh

echo -n "Updating /opt/etc/ld.so.cache... "
/opt/bin/ldconfig > /dev/null 2>&1
echo "done."
endef

$(eval $(call BuildPackage,opt-ndmsv1))
