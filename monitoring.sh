#!/bin/bash

ARCH=$(uname -i -v -m)

PPROCSS=$(lscpu | grep "Socket(s)" | awk '{print "\x1b[38;5;10m"$2"\033[0m"}')

VPROCSS=$(lscpu | sed -n '5p' | awk '{printf "\x1b[38;5;10m"$2"\033[0m"}')

RAMUSE=$(free -h | sed -n '2p' | awk '{printf "\x1b[38;5;10m"$3"\033[0m" "/" "\x1b[38;5;197m"$2"\033[0m"}' | tr "i" "b")

RAMPRC=$(free -m| sed -n '2p' | awk '{printf "\x1b[38;5;10m%.2f%%\033[0m", $3/$2*100}')

DISK=$(df -h --total | grep total | awk '{print "\x1b[38;5;10m"$3"\033[0m" "/" "\x1b[38;5;197m"$2"\033[0m" "(""\x1b[38;5;10m" $5"\033[0m" ")"}')

CPU=$(uptime | awk '{printf "\x1b[38;5;10m"$9"\033[0m"}' | sed 's/,//')

LSTRBT=$(uptime -s | cut -d ":" -f 1,2)

Getls=$(printf "\x1b[38;5;10m%s \033[0m" $LSTRBT)

LVM=$(lvdisplay | grep -c "available")

LVMDSP=`if [ $(lsblk | grep 'lvm' | wc -l) -ne 0 ]; then printf "\x1b[38;5;10myes\033[0m"; else printf "\x1b[38;5;197mno\033[0m"; fi`

CONNC=$(ss -t | grep -c "ESTAB")

Getconn=$(printf "\x1b[38;5;10m%i\033[0m" $CONNC)

USERS=$(w | sed -n '1p' | cut -d " " -f 7)

Getusr=$(printf "\x1b[38;5;10m%i\033[0m" $USERS)

IPADDRS=$(hostname -I)

MACADDRS=$(ip -o link | cut -d " " -f 20 | sed -n '2p')

SUDO=$(journalctl _COMM=sudo | grep -c "COMMAND")

Getsu=$(printf "\x1b[38;5;10m%i\033[0m" $SUDO)

Ccpu=$(printf "\x1b[38;5;227mCPU Physical\033[0m")
Cvcpu=$(printf "\x1b[38;5;227mvCPU\033[0m")
Cmemory=$(printf "\x1b[38;5;227mMemory Usage\033[0m")
Cdisk=$(printf "\x1b[38;5;227mDisk Usage\033[0m")
CcpuL=$(printf "\x1b[38;5;227mCPU Load\033[0m")
Clast=$(printf "\x1b[38;5;227mLast boot\033[0m")
Clvmcheck=$(printf "\x1b[38;5;227mLVM Use\033[0m")
Cconnection=$(printf "\x1b[38;5;227mConnections TCP\033[0m")
Cuserl=$(printf "\x1b[38;5;227mUser Log\033[0m")
Cnet=$(printf "\x1b[38;5;227mNetwork\033[0m")
Csu=$(printf "\x1b[38;5;227mSudo\033[0m")

wall "	$(printf "\x1b[38;5;99m
	╔════════════════════════════════════════════════════════════════════════╗
	║\033[0m") Architecture: $ARCH	 $(printf "\x1b[38;5;99m║
	╚════════════════════════════════════════════════════════════════════════╝\033[0m")
	╔══════════════╦═════════════════════════════════╗
	║ $Ccpu ║ $PPROCSS				 ║
	╠══════╦═══════╩═════════════════════════════════╣
	║ $Cvcpu ║ $VPROCSS					 ║
	╠══════╩═══════╦═════════════════════════════════╣
	║ $Cmemory ║ $RAMUSE ($RAMPRC)		 ║
	╠════════════╦═╩═════════════════════════════════╣
	║ $Cdisk ║ $DISK			 ║
	╠══════════╦═╩═══════════════════════════════════╣
	║ $CcpuL ║ $CPU 				 ║
	╠══════════╩╦════════════════════════════════════╣
	║ $Clast ║ $Getls			 ║
	╠═════════╦═╩════════════════════════════════════╣
	║ $Clvmcheck ║ $LVMDSP					 ║
	╠═════════╩═══════╦══════════════════════════════╣
	║ $Cconnection ║ $Getconn $(printf "\x1b[38;5;117mESTABLISHED\033[0m")		 ║
	╠══════════╦══════╩══════════════════════════════╣
	║ $Cuserl ║ $Getusr					 ║
	╠═════════╦╩═════════════════════════════════════╣
	║ $Cnet ║ $(printf "\x1b[38;5;117mIP\033[0m") $(printf "\x1b[38;5;10m$IPADDRS ($MACADDRS)\033[0m")║
	╠══════╦══╩══════════════════════════════════════╣
	║ $Csu ║ $Getsu $(printf "\x1b[38;5;117mCMD\033[0m")					 ║
	╚══════╩═════════════════════════════════════════╝"
