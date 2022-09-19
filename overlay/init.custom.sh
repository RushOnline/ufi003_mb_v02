#!/system/bin/sh
#
#logwrapper /system/bin/sh /data/local/userinit.sh;
#

setprop persist.adb.tcp.port 5555
setprop service.adb.root 1
setprop service.adb.tcp.port 5555

log -p -i -t init-custom "Executing $0"


# check bridge ready
if brctl show | grep wlan0; then
	if ! brctl show | grep rndis0; then
		brctl addif bridge1 rndis0
		ip link set dev rndis0 up
		iptables -F natctrl_FORWARD
		setprop custom.init.complete 1
		exit 0
	fi
fi

exit 1
