GET_TARGET_INFO() {
	[ -f ${GITHUB_WORKSPACE}/Openwrt.info ] && . ${GITHUB_WORKSPACE}/Openwrt.info
	Openwrt_Version="${Compile_Date}"
	DEVICE=$(awk -F '[="]+' '/TARGET_BOARD/{print $2}' .config)
        SUBTARGET="$(awk -F '[="]+' '/TARGET_SUBTARGET/{print $2}' .config)"
        if [[ "$DEVICE" == "x86" ]]; then
		TARGET_PROFILE="x86-${SUBTARGET}"
	elif [[ "$DEVICE" != "x86" ]]; then
		TARGET_PROFILE="$(egrep -o "CONFIG_TARGET.*DEVICE.*=y" .config | sed -r 's/.*DEVICE_(.*)=y/\1/')"
	fi
	Github_Repo="$(grep "https://github.com/[a-zA-Z0-9]" ${GITHUB_WORKSPACE}/.git/config | cut -c8-100)"
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
	AutoUpdate_Version="$(awk 'NR==6' package/base-files/files/bin/AutoUpdate.sh | awk -F '[="]+' '/Version/{print $2}')"
	[[ -z "${AutoUpdate_Version}" ]] && AutoUpdate_Version="Unknown"
	echo "AutoUpdate Version: ${AutoUpdate_Version}"
	[[ -z "${Author}" ]] && Author="Unknown"
	echo "插件版本: ${Openwrt_Version}"
	echo "编译源码: ${Source}"
	echo "源码作者: ${ZUOZHE}"
	echo "机子型号: ${TARGET_PROFILE}"
	echo "固件名字: ${Updete_firmware}"
	echo "固件后缀: ${Extension}"
	echo "仓库链接: ${Github_Repo}"
	echo "固件作者: ${Author}"
	echo "Firmware-${Openwrt_Version}" > package/base-files/files/etc/openwrt_info
	echo "${Github_Repo}" >> package/base-files/files/etc/openwrt_info
	echo "${TARGET_PROFILE}" >> package/base-files/files/etc/openwrt_info
	echo "${Source}" >> package/base-files/files/etc/openwrt_info
}

Diy_Part3() {
	GET_TARGET_INFO
	Default_Firmware="${Updete_firmware}"
	AutoBuild_Firmware="openwrt-${Source}-${TARGET_PROFILE}-Firmware-${Openwrt_Version}${Extension}"
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
