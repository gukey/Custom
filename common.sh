# 机型文件=${Modelfile}

# 全脚本源码通用diy.sh文件

Diy_all() {
echo "all"
}

# 全脚本源码通用diy2.sh文件

Diy_all2() {
echo "all2"
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
rm -rf {LICENSE,README,README.md}
rm -rf ./*/{LICENSE,README,README.md}
rm -rf ./*/*/{LICENSE,README,README.md}
mkdir -p files/usr/bin/AdGuardHome/data
}

################################################################################################################


# LEDE源码通用diy1.sh文件（除了openwrt机型文件夹）

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

# LEDE源码通用diy2.sh文件（openwrt机型文件夹也使用）

Diy_lede2() {
echo "LEDE源码自定义2"
curl -fsSL  https://raw.githubusercontent.com/281677160/openwrt-package/usb/common/mt7620a_youku_yk1.dts > ./target/linux/ramips/dts/mt7620a_youku_yk1.dts
sed -i '$i '"sed -i 's/(ver.distversion)%>/(ver.distversion)%> <\!--/g' /usr/lib/lua/luci/view/admin_status/index.htm"'' ./package/lean/default-settings/files/zzz-default-settings
sed -i '$i '"sed -i 's/(ver.luciversion)%>)/(ver.luciversion)%>) \!-->/g' /usr/lib/lua/luci/view/admin_status/index.htm"'' ./package/lean/default-settings/files/zzz-default-settings
}

################################################################################################################



################################################################################################################


# LIENOL源码通用diy1.sh文件（除了openwrt机型文件夹）

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

# LIENOL源码通用diy2.sh文件（openwrt机型文件夹也使用）

Diy_lienol2() {
echo "LIENOL源码自定义2"
sed -i '$i '"sed -i 's/(ver.distversion)%>/(ver.distversion)%> <\!--/g' /usr/lib/lua/luci/view/admin_status/index.htm"'' ./package/default-settings/files/zzz-default-settings
sed -i '$i '"sed -i 's/(ver.luciversion)%>)/(ver.luciversion)%>) \!-->/g' /usr/lib/lua/luci/view/admin_status/index.htm"'' ./package/default-settings/files/zzz-default-settings
}

################################################################################################################



################################################################################################################


# 天灵源码通用diy1.sh文件（除了openwrt机型文件夹）

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

# 天灵源码通用diy2.sh文件（openwrt机型文件夹也使用）

Diy_immortalwrt2() {
echo "天灵源码自定义2"
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


Diy_xinxi() {
DEVICES="$(awk -F '[="]+' '/TARGET_BOARD/{print $2}' .config)"
SUBTARGETS="$(awk -F '[="]+' '/TARGET_SUBTARGET/{print $2}' .config)"
if [[ "${DEVICES}" == "x86" ]]; then
	TARGET_PRO="x86-${SUBTARGETS}"
elif [[ ${Modelfile} =~ (Lede_phicomm_n1|Project_phicomm_n1) ]]; then
	TARGET_PRO="n1,Vplus,Beikeyun,L1Pro,S9xxx"
else
	TARGET_PRO="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/.*DEVICE_(.*)=y/\1/')"
fi
[[ -z "${TARGET_PRO}" ]] && TARGET_PRO="无法获取机型"
echo "编译源码: ${Source}"
echo "源码链接: ${REPO_URL}"
echo "源码分支: ${REPO_BRANCH}"
echo "源码作者: ${ZUOZHE}"
echo "机子型号: ${TARGET_PRO}"
echo "固件作者: ${Author}"
echo "仓库链接: ${GITHUB_RELEASE}"
if [[ ${UPLOAD_BIN_DIR} == "false" ]]; then
	echo "上传BIN文件夹(固件+IPK): 关闭"
elif [[ ${UPLOAD_BIN_DIR} == "true" ]]; then
	echo "上传BIN文件夹(固件+IPK): 开启"
fi
if [[ ${UPLOAD_CONFIG} == "false" ]]; then
	echo "上传[.config]配置文件: 关闭"
elif [[ ${UPLOAD_CONFIG} == "true" ]]; then
	echo "上传[.config]配置文件: 开启"
fi
if [[ ${UPLOAD_FIRMWARE} == "false" ]]; then
	echo "上传固件在github空间: 关闭"
elif [[ ${UPLOAD_FIRMWARE} == "true" ]]; then
	echo "上传固件在github空间: 开启"
fi
if [[ ${UPLOAD_COWTRANSFER} == "false" ]]; then
	echo "上传固件到到【奶牛快传】和【WETRANSFER】: 关闭"
elif [[ ${UPLOAD_COWTRANSFER} == "true" ]]; then
	echo "上传固件到到【奶牛快传】和【WETRANSFER】: 开启"
fi
if [[ ${UPLOAD_RELEASE} == "true" ]]; then
	echo "发布固件: 开启"
elif [[ (github.event.inputs.release == 'release' && github.event.inputs.release  != 'false') == (github.event.inputs.release == 'release') ]]; then
	echo "发布固件: 开启"
else
	echo "发布固件: 关闭"
fi
if [[ ${SERVERCHAN_SCKEY} == "false" ]]; then
	echo "微信通知: 关闭"
elif [[ ${SERVERCHAN_SCKEY} == "true" ]]; then
	echo "微信通知: 开启"
fi
if [[ REGULAR_UPDATE="false" ]]; then
	echo "把定时自动更新插件编译进固件: 关闭"
fi
}
