# 全脚本源码通用diy.sh文件

Diy_all() {
echo "all"
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
}

# 全脚本源码通用diy2.sh文件

Diy_all2() {
echo "all2"
rm -rf {LICENSE,README,README.md}
rm -rf ./*/{LICENSE,README,README.md}
rm -rf ./*/*/{LICENSE,README,README.md}
}

################################################################################################################


# LEDE源码通用diy1.sh文件

Diy_lede() {
echo "LEDE源码自定义1"
rm -rf package/lean/{luci-app-netdata,luci-theme-argon,k3screenctrl}

git clone -b $REPO_BRANCH --single-branch https://github.com/281677160/openwrt-package package/danshui
svn co https://github.com/281677160/openwrt-package/branches/usb/AutoUpdate package/base-files/files/bin
chmod +x package/base-files/files/bin/* ./

git clone https://github.com/fw876/helloworld package/danshui/luci-app-ssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/danshui/luci-app-passwall
git clone https://github.com/jerrykuku/luci-app-vssr package/danshui/luci-app-vssr
git clone https://github.com/vernesong/OpenClash package/danshui/luci-app-openclash
git clone https://github.com/frainzy1477/luci-app-clash package/danshui/luci-app-clash
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass

find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
}

# LEDE源码通用diy2.sh文件

Diy_lede2() {
echo "LEDE源码自定义2"
mkdir -p files/usr/bin/AdGuardHome/data
}

################################################################################################################



################################################################################################################


# LIENOL源码通用diy1.sh文件

Diy_lienol() {
echo "LIENOL源码自定义1"
rm -rf package/diy/luci-app-adguardhome
rm -rf package/lean/{luci-app-netdata,luci-theme-argon,k3screenctrl}

git clone -b $REPO_BRANCH --single-branch https://github.com/281677160/openwrt-package package/danshui
svn co https://github.com/281677160/openwrt-package/branches/usb/AutoUpdate package/base-files/files/bin
chmod +x package/base-files/files/bin/* ./

git clone https://github.com/fw876/helloworld package/danshui/luci-app-ssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall package/danshui/luci-app-passwall
git clone https://github.com/jerrykuku/luci-app-vssr package/danshui/luci-app-vssr
git clone https://github.com/vernesong/OpenClash package/danshui/luci-app-openclash
git clone https://github.com/frainzy1477/luci-app-clash package/danshui/luci-app-clash
git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass

find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
}

# LIENOL源码通用diy2.sh文件

Diy_lienol2() {
echo "LIENOL源码自定义2"
mkdir -p files/usr/bin/AdGuardHome/data
}

################################################################################################################



################################################################################################################


# 天灵源码通用diy1.sh文件

Diy_immortalwrt() {
echo "天灵源码自定义1"
rm -rf package/lienol/luci-app-timecontrol
rm -rf package/ctcgfw/{luci-app-argon-config,luci-theme-argonv3,luci-app-adguardhome}
rm -rf package/lean/{luci-theme-argon}

git clone -b $REPO_BRANCH --single-branch https://github.com/281677160/openwrt-package package/danshui
svn co https://github.com/281677160/openwrt-package/branches/usb/AutoUpdate package/base-files/files/bin
chmod +x package/base-files/files/bin/* ./

git clone https://github.com/garypang13/luci-app-bypass package/danshui/luci-app-bypass
}

# 天灵源码通用diy2.sh文件

Diy_immortalwrt2() {
echo "天灵源码自定义2"
mkdir -p files/usr/bin/AdGuardHome/data
}

################################################################################################################


# N1、微加云、贝壳云、我家云、S9xxx 打包程序

Diy_n1() {
cd ../
svn co https://github.com/281677160/N1/trunk reform
cp openwrt/bin/targets/armvirt/*/*.tar.gz reform/openwrt
cd reform
sudo ./gen_openwrt -d -k latest
         
devices=("phicomm-n1" "rk3328" "s9xxx" "vplus")
}


################################################################################################################


# 公告

Diy_notice() {
echo "#"
echo "《公告内容》"
echo "祝大家新年快乐、生活愉快！"
echo "使用中有疑问的可以加入电报群，跟群友交流"
echo "#"
}
