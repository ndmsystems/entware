#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=iptables-keenetic
PKG_VERSION:=1.4.21
PKG_RELEASE:=1

PKG_SOURCE:=iptables-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://www.netfilter.org/projects/iptables/files \
	ftp://ftp.be.netfilter.org/pub/netfilter/iptables/ \
	ftp://ftp.de.netfilter.org/pub/netfilter/iptables/ \
	ftp://ftp.no.netfilter.org/pub/netfilter/iptables/
PKG_MD5SUM:=536d048c8e8eeebcd9757d0863ebb0c0

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_LICENSE:=GPL-2.0

#PKG_BUILD_DIR:=$(BUILD_DIR)/iptables-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/iptables-keenetic
  TITLE:=iptables-keenetic
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Firewall
  URL:=http://netfilter.org/
endef

define Package/iptables-keenetic/description
IP firewall administration tool.

 Matches:
  - icmp
  - tcp
  - udp
  - comment
  - conntrack
  - limit
  - mac
  - mark
  - multiport
  - set
  - state
  - time

 Targets:
  - ACCEPT
  - CT
  - DNAT
  - DROP
  - REJECT
  - LOG
  - MARK
  - MASQUERADE
  - REDIRECT
  - SET
  - SNAT
  - TCPMSS

 Tables:
  - filter
  - mangle
  - nat
  - raw

endef

TARGET_CPPFLAGS := \
	-I$(PKG_BUILD_DIR)/include \
	-I$(LINUX_DIR)/include \
	$(TARGET_CPPFLAGS)

TARGET_CFLAGS += \
	-I$(PKG_BUILD_DIR)/include \
	-I$(LINUX_DIR)/include \
	-ffunction-sections -fdata-sections \
	-DNO_LEGACY

TARGET_LDFLAGS += \
	-lm -Wl,--gc-sections

CONFIGURE_ARGS += \
	--enable-shared \
	--enable-devel \
	--with-kernel="$(LINUX_DIR)" \
	--with-xtlibdir=/opt/lib/iptables \
	--enable-static \

MAKE_FLAGS := \
	$(TARGET_CONFIGURE_OPTS) \
	COPT_FLAGS="$(TARGET_CFLAGS)" \
	KERNEL_DIR="$(LINUX_DIR)/user_headers/" PREFIX=/usr \
	KBUILD_OUTPUT="$(LINUX_DIR)" \

define Package/iptables-keenetic/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/iptables-xml $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/sbin/* $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/lib/iptables
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/*.so* $(1)/opt/lib/
	$(CP) $(PKG_BUILD_DIR)/extensions/*.so $(1)/opt/lib/
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/iptables/*.so* $(1)/opt/lib/iptables/
endef

$(eval $(call BuildPackage,iptables-keenetic))
