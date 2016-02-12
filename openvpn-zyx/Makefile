#
# Copyright (C) 2010-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=openvpn-zyx

PKG_VERSION:=2.3.10
PKG_RELEASE:=50

PKG_SOURCE_URL:=http://swupdate.openvpn.net/community/releases
PKG_SOURCE:=openvpn-$(PKG_VERSION).tar.xz
PKG_MD5SUM:=8831ded42db4317e287157b6b8cba74c
PKG_UNPACK=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xf $(DL_DIR)/$(PKG_SOURCE)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/openvpn-zyx
  TITLE:=Open source VPN solution using openssl
  SECTION:=net
  CATEGORY:=Network
  URL:=http://openvpn.net
  SUBMENU:=VPN
  MENU:=1
  DEPENDS:=+liblzo +libopenssl
  MAINTAINER:=Mirko Vogt <mirko@openwrt.org>
  CONFLICTS:=openvpn-openssl
endef

CONFIGURE_VARS += \
	IFCONFIG=/opt/sbin/ifconfig \
	ROUTE=/opt/sbin/route \
	IPROUTE=/opt/sbin/ip \
	NETSTAT=/opt/bin/netstat

define Build/Configure
	$(call Build/Configure/Default, \
		--disable-selinux \
		--disable-systemd \
		--disable-plugins \
		--disable-debug \
		--disable-pkcs11 \
		--enable-lzo \
		--enable-server \
		--disable-management \
		--enable-socks \
		--enable-fragment \
		--enable-multihome \
		--disable-iproute2 \
		--enable-def-auth \
		--enable-pf \
		--with-crypto-library=openssl \
	)
endef

define Package/openvpn-zyx/install
	$(INSTALL_DIR) \
		$(1)/opt/sbin \
		$(1)/opt/etc/init.d \

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/opt/sbin/openvpn \
		$(1)/opt/sbin/

	$(INSTALL_BIN) \
		files/S20openvpn \
		$(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,openvpn-zyx))
