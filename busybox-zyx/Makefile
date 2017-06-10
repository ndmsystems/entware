#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=busybox
PKG_VERSION:=1.25.1
PKG_RELEASE:=2
PKG_FLAGS:=essential

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.busybox.net/downloads \
		http://sources.buildroot.net
PKG_MD5SUM:=4f4c5de50b479b11ff636d7d8eb902a2

PKG_BUILD_DEPENDS:=BUSYBOX_CONFIG_PAM:libpam
PKG_BUILD_PARALLEL:=1
PKG_CHECK_FORMAT_SECURITY:=0

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE archival/libarchive/bz/LICENSE

include $(INCLUDE_DIR)/package.mk

ifeq ($(DUMP),)
  STAMP_CONFIGURED:=$(strip $(STAMP_CONFIGURED))_$(shell $(SH_FUNC) grep '^CONFIG_BUSYBOX_' $(TOPDIR)/.config | md5s)
endif

ifneq ($(findstring c,$(OPENWRT_VERBOSE)),)
  BB_MAKE_VERBOSE := V=1
else
  BB_MAKE_VERBOSE :=
endif

define Package/busybox-zyx
  SECTION:=base
  CATEGORY:=Base system
  MAINTAINER:=Felix Fietkau <nbd@nbd.name>
  TITLE:=Core utilities for embedded Linux
  URL:=http://busybox.net/
  CONFLICTS:=busybox
endef

define Package/busybox/description
 The Swiss Army Knife of embedded Linux.
 It slices, it dices, it makes Julian Fries.
endef

define Build/Configure
	rm -f $(PKG_BUILD_DIR)/.configured*
	$(CP) ./files/.config $(PKG_BUILD_DIR)/.config
	yes 'n' | $(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		ARCH="$(ARCH)" \
		$(BB_MAKE_VERBOSE) \
		oldconfig
endef

LDLIBS:=m crypt
define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
		ARCH="$(ARCH)" \
		SKIP_STRIP=y \
		LDLIBS="$(LDLIBS)" \
		$(BB_MAKE_VERBOSE) \
		all
	rm -rf $(PKG_INSTALL_DIR)
	$(FIND) $(PKG_BUILD_DIR) -lname "*busybox" -exec rm \{\} \;
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		EXTRA_LDFLAGS="$(TARGET_LDFLAGS)" \
		ARCH="$(ARCH)" \
		CONFIG_PREFIX="$(PKG_INSTALL_DIR)/opt" \
		LDLIBS="$(LDLIBS)" \
		$(BB_MAKE_VERBOSE) \
		install
endef

define Package/busybox-zyx/install
	$(INSTALL_DIR) $(1)/opt/{bin,sbin}
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/busybox $(1)/opt/bin/
	chmod u+s $(1)/opt/bin/busybox
	$(INSTALL_DIR) $(1)/opt/share
	(cd $(PKG_INSTALL_DIR); \
	    find ./opt -lname "*" | sed "s|^./opt/||g" > $(1)/opt/share/busybox_applets.lst.dist)
endef

define Package/busybox-zyx/postinst
#!/bin/sh

cd /opt
rm -f share/busybox_applets.lst
for applet in $$(cat share/busybox_applets.lst.dist)
do
    if [ ! -e $$applet ]
    then
       ln -s /opt/bin/busybox $$applet
    fi
done
endef

define Package/busybox-zyx/postrm
#!/bin/sh

cd /opt
for applet in $$(cat share/busybox_applets.lst)
do
    if [ -L $$applet ]
    then
       rm -f $$applet
    else
       echo "Warning: '/opt/$$applet' has been deleted\modified before, skipping."
    fi
done
rm -f share/busybox_applets.lst
endef

$(eval $(call BuildPackage,busybox-zyx))
