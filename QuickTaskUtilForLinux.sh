#!/bin/bash
#
# Copyright © 2018
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>
#
# Developed by dexoidan
# Script name: Quick Task Utility For Linux
# Script Version 1.0
# Script Usable: Debian based Linux systems
# 
# Original applicable script is open source, free for malicious software.
# Always check all usable software for malware.

function finish {
    echo -e "\nProgram exiting gracefully"
	exit 0
}

trap finish 0

function checkforinternet
{
	varCheck=$(ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` && echo ok || echo error)
	echo $varCheck
}

function getpublicipv4address
{
	networkgateway=$(checkforinternet)
	if [[ $networkgateway == "error" ]]
	then
		echo -e "\nYou cannot reach your network standard gateway!"
		ifconfig
	else
		echo -e "\nYour Currently Public IP Address: $(curl -s ifconfig.me)\n"
	fi
}

function getsystemoverview
{
	echo -e "\e[31;43m***** HOSTNAME INFORMATION *****\e[0m"
	hostnamectl
	echo ""
	# -File system disk space usage:
	echo -e "\e[31;43m***** FILE SYSTEM DISK SPACE USAGE *****\e[0m"
	df -h
	echo ""
	# -Free and used memory in the system:
	echo -e "\e[31;43m ***** FREE AND USED MEMORY *****\e[0m"
	free
	echo ""
	# -System uptime and load:
	echo -e "\e[31;43m***** SYSTEM UPTIME AND LOAD *****\e[0m"
	uptime
	echo ""
	# -Logged-in users:
	echo -e "\e[31;43m***** CURRENTLY LOGGED-IN USERS *****\e[0m"
	who
	echo ""
	# -Top 5 processes as far as memory usage is concerned
	echo -e "\e[31;43m***** TOP 5 MEMORY-CONSUMING PROCESSES *****\e[0m"
	ps -eo %mem,%cpu,comm --sort=-%mem | head -n 6
	echo ""
	echo -e "\e[1;32mDone.\e[0m"
}

while :
do
	clear
	echo "-------------------------------"
	echo "     M A I N - M E N U"
	echo "-------------------------------"
	echo "Server Name: $(hostname)"
	echo "-------------------------------"
	echo "1. Change password locally on current user."
	echo "2. Show the user and group id on current user."
	echo "3. Display the information about active network interfaces."
	echo "4. Display active network connections."
	echo "5. Show network routing table and current arp table."
	echo "6. Display basic information about current system."
	echo "7. Show which applications using active network connections"
	echo "8. Check designated network gateway and obtain current public IPv4 Address."
	echo "9. Display an System Information Overview."
	echo "10. List all installed system services on current system with running status."
	echo "11. List all running processes on current system with implied security information."
	echo "12. Edit scheduled tasks for the current user '$USER' on current system."
	echo "13. Edit scheduled tasks for System Administrator on current system."
	echo "14. Edit the sudoers configuration."
	echo "15. Display an basic overview about installed hardware on current system."
	echo "16. Show information about installed processor on current system."
	echo "17. Show basic information about PCI Devices on current system."
	echo "18. show basic information about USB Devices on current system."
	echo "19. Monitor logging messages about boot and hardware entries on current system."
	echo "20. Monitor logging messages about syslog log entries on current system."
	echo "21. Monitor logging messages about security authentication log entries on current system."
	echo "22. Using fdisk about list all mounted filesystems on current system."
	echo "23. Reboot this system immediately"
	echo "24. Shutdown this system immediately"
	echo "25. Exit"

	# get input from the user 
	read -p "Enter your choice [ 1-25 ] " choice
	
	# make decision using case..in..esac 
	case $choice in
	1)
		echo -e "You changing the password for user '$USER' on this system now.\nHit ENTER key on the keyboard for cancellation.\nDon't Run As Root"
		passwd $USER
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	2)
		id
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	3)
		ifconfig
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	4)
		netstat -antu
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	5)
		echo -e "\nActive Network Routing Table:\n"
		route -v
		echo -e "\nActive Network ARP Table:\n"
		arp -a
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	6)
		cat /etc/issue
		uname -a
		echo
		who --runlevel
		echo
		w
		echo -e "\n"
		free -t
		echo -e "\n"
		mount | column -t
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	7)
		lsof -Pan -i tcp -i udp
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	8)
		getpublicipv4address
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	9)
		getsystemoverview
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	10)
		service --status-all
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	11)
		ps -eo euser,ruser,suser,fuser,f,comm
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	12)
		crontab -e
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	13)
		echo -e "\nInvoking crontab for editing the scheduled tasks.\n"
		sudo crontab -e
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	14)
		echo -e "\nInvoking edit /etc/sudoers configuration.\n"
		sudo visudo
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	15)
		echo -e "\nInvoking show about installed hardware.\n"
		sudo lshw -short
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	16)
		echo -e "\n"
		lscpu
		echo -e "\n"
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	17)
		echo -e "\n"
		lspci
		echo -e "\n"
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	18)
		echo -e "\n"
		lsusb
		echo -e "\n"
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	19)
		dmesg -wH | more
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	20)
		tail -f -n 30 /var/log/syslog
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	21)
		tail -f -n 30 /var/log/auth.log
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	22)
		echo -e "\nInvoking show about installed hardware.\n"
		sudo fdisk -l
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	23)
		reboot --force --no-wtmp --no-wall
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	24)
		poweroff --force --no-wtmp --no-wall
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	25)
		echo -e "Bye!"
		exit 0
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	*)
		echo "Error: Invalid option..."	
		read -p "Press [Enter] key to continue..." readEnterKey
		;;
	esac
done