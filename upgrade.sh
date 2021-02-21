GET_TARGET_INFO() {
	[ -f ${GITHUB_WORKSPACE}/Openwrt.info ] && . ${GITHUB_WORKSPACE}/Openwrt.info
	Openwrt_Version="${Compile_Date}"
	Author="${Author}"
	DEVICE=$(awk -F '[="]+' '/TARGET_BOARD/{print $2}' .config)
        SUBTARGET="$(awk -F '[="]+' '/TARGET_SUBTARGET/{print $2}' .config)"
        if [[ "$DEVICE" == "x86" ]]; then
		TARGET_PROFILE="x86-${SUBTARGET}"
		Firmware_sfx=".img.gz"
	elif [[ "$DEVICE" != "x86" ]]; then
		TARGET_PROFILE="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/.*DEVICE_(.*)=y/\1/')"
	elif [[ "$TARGET_PROFILE" == "phicomm-k3" ]]; then
		Firmware_sfx=".trx"
	elif [[ "$TARGET_PROFILE" == "d-team_newifi-d2" ]]; then
		Firmware_sfx=".bin"
	else
		Firmware_sfx="${Extension}"
	fi
	Github_Repo="$(grep "https://github.com/[a-zA-Z0-9]" ${GITHUB_WORKSPACE}/.git/config | cut -c8-100)"
	AutoUpdate_Version="$(awk 'NR==6' package/base-files/files/bin/AutoUpdate.sh | awk -F '[="]+' '/Version/{print $2}')"
}

Diy_Part1() {
	sed -i '/luci-app-autoupdate/d' .config > /dev/null 2>&1
	echo -e "\nCONFIG_PACKAGE_luci-app-autoupdate=y" >> .config
	sed -i '/luci-app-ttyd/d' .config > /dev/null 2>&1
	echo -e "\nCONFIG_PACKAGE_luci-app-ttyd=y" >> .config
	sed -i '/IMAGES_GZIP/d' .config > /dev/null 2>&1
	echo -e "\nCONFIG_TARGET_IMAGES_GZIP=y" >> .config
}

Diy_Part2() {
	GET_TARGET_INFO
	[[ -z "${AutoUpdate_Version}" ]] && AutoUpdate_Version="Unknown"
	[[ -z "${Author}" ]] && Author="Unknown"
	echo "插件版本: ${AutoUpdate_Version}"
	echo "编译源码: ${Source}"
	echo "源码链接: ${REPO_URL}"
	echo "源码分支: ${REPO_BRANCH}"
	echo "源码作者: ${ZUOZHE}"
	echo "机子型号: ${TARGET_PROFILE}"
	echo "自动更新固件名字: ${Updete_firmware}"
	echo "自动更新固件后缀: ${Firmware_sfx}"
	echo "自动更新固件版本: Firmware-${Openwrt_Version}"
	echo "固件作者: ${Author}"
	echo "仓库链接: ${Github_Repo}"
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
	if [[ ${UPLOAD_RELEASE} == "false" ]]; then
		echo "发布固件: 关闭"
	elif [[ ${UPLOAD_RELEASE} == "true" ]]; then
		echo "发布固件: 开启"
	fi
	if [[ ${SERVERCHAN_SCKEY} == "false" ]]; then
		echo "微信通知: 关闭"
	elif [[ ${SERVERCHAN_SCKEY} == "true" ]]; then
		echo "微信通知: 开启"
	fi
	if [[ ${REGULAR_UPDATE} == "true" ]]; then
		echo "把定时自动更新编译进固件已开启"
		echo "请把“REPO_TOKEN”密匙设置好,没设置好密匙不能发布云端地址"
		echo "请注意核对固件名字和后缀,避免编译错误"
	fi
	echo "Firmware-${Openwrt_Version}" > package/base-files/files/etc/openwrt_info
	echo "${Github_Repo}" >> package/base-files/files/etc/openwrt_info
	echo "${TARGET_PROFILE}" >> package/base-files/files/etc/openwrt_info
	echo "${Source}" >> package/base-files/files/etc/openwrt_info
}

Diy_Part3() {
	GET_TARGET_INFO
	Default_Firmware="${Updete_firmware}"
	AutoBuild_Firmware="openwrt-${Source}-${TARGET_PROFILE}-Firmware-${Openwrt_Version}${Firmware_sfx}"
	AutoBuild_Detail="openwrt-${Source}-${TARGET_PROFILE}-Firmware-${Openwrt_Version}.detail"
	Mkdir bin/Firmware
	echo "Firmware: ${AutoBuild_Firmware}"
	cp -f bin/targets/*/*/*"${Default_Firmware}" bin/Firmware/"${AutoBuild_Firmware}"
	_MD5="$(md5sum bin/Firmware/${AutoBuild_Firmware} | cut -d ' ' -f1)"
	_SHA256="$(sha256sum bin/Firmware/${AutoBuild_Firmware} | cut -d ' ' -f1)"
	echo -e "\nMD5:${_MD5}\nSHA256:${_SHA256}" > bin/Firmware/"${AutoBuild_Detail}"
}

Mkdir() {
	_DIR=${1}
	if [ ! -d "${_DIR}" ];then
		echo "[$(date "+%H:%M:%S")] Creating new folder [${_DIR}] ..."
		mkdir -p ${_DIR}
	fi
	unset _DIR
}
