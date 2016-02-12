#
# Copyright (C) 2009-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=proftpd-zyx
PKG_VERSION:=1.3.5a
PKG_RELEASE:=50

PKG_SOURCE:=proftpd-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=ftp://ftp.proftpd.org/distrib/source
PKG_MD5SUM:=b9d3092411478415b31d435f8e26d173

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_UNPACK=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

include $(INCLUDE_DIR)/package.mk

define Package/proftpd-zyx
  SUBMENU:=File Transfer
  SECTION:=net
  CATEGORY:=Network
  TITLE:=ProFTPD FTP server
  URL:=http://www.proftpd.org/
  MAINTAINER:=Cezary Jackiewicz <cezary@eko.one.pl>
  CONFLICTS:=proftpd
endef

define Package/proftpd-zyx/conffiles
/opt/etc/proftpd.conf
endef

MAKE_FLAGS += \
	INSTALL_USER=$(shell id -u) \
	INSTALL_GROUP=$(shell id -g)

CONFIGURE_ARGS += \
	--disable-cap \
	--disable-auth-pam \
	--disable-strip \
	--with-lastlog=/opt/var/log

CONFIGURE_VARS += \
	ac_cv_header_curses_h=no \
	ac_cv_header_ncurses_h=no

define Package/proftpd-zyx/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/opt/etc/proftpd.conf $(1)/opt/etc/
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/ftp{count,dctl,top,who} $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/sbin/{ftpscrub,ftpshut,proftpd} $(1)/opt/sbin/
	$(LN) proftpd $(1)/opt/sbin/in.proftpd
	$(INSTALL_BIN) ./files/S66proftpd $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,proftpd-zyx))
