#!/bin/bash

architecture=$(uname -a)

cpu_physical="$(grep "physical id"  /proc/cpuinfo | wc -l)"
cpu_virtual="$(grep processor /proc/cpuinfo | wc -l)"

memory_use="$(free -m | awk '$1 == "Mem:" {print $3}')"
memory_all="$(free -m | awk '$1 == "Mem:" {print $2}')"
memory_percent="$(awk -v a=$memory_use -v b=$memory_all 'BEGIN{printf "%.2f\n", (a/b)}')"

disk_all=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
disk_use=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
disk_precent="$(awk -v a=$disk_use -v b=$disk_all 'BEGIN{printf "%.2f\n", ((a / 1000)/b)}')"

cpu_load="$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}')"

last_boot="$(who -b | xargs | awk '{print $3 " " $4}')"

is_lvm=$(cat /etc/fstab | grep "^/dev/mapper" | wc -l)
lvm=$(if [ $is_lvm -eq 0 ]; then echo no; else echo yes; fi)

tcp=$(cat /proc/net/sockstat | awk '$1 == "TCP:" {print $3}')
tcp6=$(cat /proc/net/sockstat6 | awk '$1 == "TCP6:" {print $3}')
connections="$(awk -v a=$tcp6 -v b=$tcp 'BEGIN{print a+b}')"

user="$(w | head -n1 | awk '{print $5}')"

ip4="$(ip a show scope global | grep inet | awk '{print $2}')"
ip6="$(ip a show scope global | grep ether | awk '{print $2}')"

sudo="$(journalctl SYSLOG_IDENTIFIER=sudo PRIORITY=5 | wc -l)"
new_line="$(printf "\n")"

function print()
{
	wall "
	#Architecture: $architecture
	#CPU physical: $cpu_physical
	#vCPU: $cpu_virtual
	#Memory Usage: $memory_use/${memory_all}MB ($memory_percent%)
	#Disk Usage: $disk_use/${disk_all}GB ($disk_precent%)
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm
	#Connections TCP: $connections ESTABLISHED
	#User log: $user
	#Network: IP $ip4 ($ip6)
	#Sudo: $sudo cmd
	$new_line"
}

print
