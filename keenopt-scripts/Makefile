#
# Copyright (C) 2011-2015 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=keenopt-scripts
PKG_VERSION:=0.2
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/keenopt-scripts
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=provides basic scripts for ZyXEL routers
	MAINTAINER:=Entware team, entware.wl500g.info
endef

define Package/keenopt-scripts/description
 keenopt-scripts provides basic scripts for ZyXEL routers.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/keenopt-scripts/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S00telnetd $(1)/opt/etc/init.d
	$(INSTALL_CONF) ./files/passwd.root $(1)/opt/etc
	$(INSTALL_DATA) ./files/shells $(1)/opt/etc
	$(LN) /opt/etc/init.d/rc.unslung $(1)/opt/etc/initrc
	$(INSTALL_DIR) $(1)/opt/etc/ndm/{netfilter,time,usb,user,wan}.d
	$(INSTALL_BIN) ./files/{010-profile,020-root-pwd}.sh \
	    $(1)/opt/etc/ndm/user.d
	$(INSTALL_DIR) $(1)/opt/{home,root}
	$(INSTALL_BIN) ./files/.profile $(1)/opt/root
endef

define Package/keenopt-scripts/conffiles
/opt/etc/passwd.root
endef

define Package/keenopt-scripts/postinst
#!/bin/sh

grep -q "LD_LIBRARY_PATH" /opt/etc/profile || echo "unset LD_LIBRARY_PATH" >> /opt/etc/profile
endef

$(eval $(call BuildPackage,keenopt-scripts))
