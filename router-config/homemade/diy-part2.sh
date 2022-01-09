#!/bin/bash
# ------------------------------- Main source started -------------------------------
#
# Modify default theme（FROM luci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Modify default language(FROM zh_cn CHANGE TO en)
sed -i "s/zh_cn/en/g" feeds/luci/modules/luci-base/root/etc/uci-defaults/luci-base
sed -i "s/zh_cn/en/g" package/lean/default-settings/files/zzz-default-settings

# Modify default timezone(FROM Shanghai/CST-8 CHANGE TO Jakarta/WIB-7)
sed -i "s/CST-8/WIB-7/g" package/lean/default-settings/files/zzz-default-settings
sed -i "s/Shanghai/Jakarta/g" package/lean/default-settings/files/zzz-default-settings

# Add autocore support for armvirt
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
echo "DISTRIB_SOURCECODE='Homemade'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.10.1）
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# Modify default Hostname (FROM OpenWRT CHANGE TO Nusantara-STB)
sed -i 's/OpenWrt/Nusantara-STB/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/openwrt-openclash
pushd package/openwrt-openclash/tools/po2lmo && make && sudo make install 2>/dev/null && popd
mkdir -p package/base-files/files/etc/openclash/core/
cd package/base-files/files/etc/openclash/core/
clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-armv8 | sed 's/.*url\": \"//g' | sed 's/\"//g')
wget $clash_main_url && tar zxvf clash-linux-*.tar.gz && cp clash clash_tun && rm -f clash-linux-*.gz
chmod +x clash*
#
# ------------------------------- Other ends -------------------------------

