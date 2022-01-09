#!/bin/bash
# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM luci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Modify default theme（FROM luci-theme-material CHANGE TO luci-theme-argon）
sed -i 's/luci-theme-material/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Modify default language(FROM zh_cn CHANGE TO en)
sed -i "s/zh_cn/en/g" feeds/luci/modules/luci-base/root/etc/uci-defaults/luci-base
sed -i "s/zh_cn/en/g" package/lean/default-settings/files/zzz-default-settings

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='Homemade'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.10.1）
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#

#
# ------------------------------- Other ends -------------------------------

