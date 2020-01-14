#!/bin/bash
IP='10.252.7.162'
fping -c1 -t300 $IP 2>/dev/null 1>/dev/null
if [ "$?" = 0 ]
then
  echo "Ya estamos conectado a la vpn"
else
  echo "Conentando a la vpn"
  sudo openvpn --client --config pfsense-UDP4-1194-jfranco-config.ovpn --auth-user-pass auth.txt & 
fi
