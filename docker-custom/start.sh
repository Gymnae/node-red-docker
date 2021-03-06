#!/bin/sh

# install npm modules forbluetooth
#npm install @abandonware/noble 
#npm install node-red-contrib-noble-bluetooth

# if spotify device name not defined in balena service var use host name
#if [ "$BLUETOOTH_DEVICE_NAME" == "none" ] ; then
#    BLUETOOTH_DEVICE_NAME=$BALENA_DEVICE_NAME_AT_INIT
#fi

# set dbus address
dbus-uuidgen > /var/lib/dbus/machine-id
mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket

# configure bluetooth
#bluetoothctl power off
#bluetoothctl system-alias $BLUETOOTH_DEVICE_NAME
#bluetoothctl set-alias $BLUETOOTH_DEVICE_NAME
#bluetoothctl pairable on
#bluetoothctl discoverable on
#bluetoothctl discoverable-timeout 0
#bluetoothctl power on

# allow node access to bt le
setcap cap_net_raw+eip $(eval readlink -f $(which node))

# finall start node
su node-red -c "npm start --cache /data/.npm -- --userDir /data"
