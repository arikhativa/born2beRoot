#!/bin/bash

user="N/A"
tty="N/A"
time="N/A"
architecture=$(uname -a)
cpu_physical="$(grep "physical id"  /proc/cpuinfo | wc -l)"
vcpu="$(grep processor /proc/cpuinfo | wc -l)"

memory_use="$(free -m | awk '$1 == "Mem:" {print $3}')"
memory_all="$(free -m | awk '$1 == "Mem:" {print $2}')"
memory_percent="$(free | grep Mem | awk '{print $3/$2 * 100.0}')"

disk_use="$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $3} END {print ft}')"
disk_all="$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')"
disk_precent="$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')"

cpu_load="$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1"%"}')"

last_boot="$(who -b | xargs | awk '{print $3 " " $4}')"

is_lvm=$(cat /etc/fstab | grep "^/dev/mapper" | wc -l)
lvm=$(if [ $is_lvm -eq 0 ]; then echo no; else echo yes; fi)

connections="N/A"
user="N/A"
network="N/A"
sudo="N/A"

function print()
{
	wall "
	#Architecture: $architecture
	#CPU physical: $cpu_physical
	#vCPU: $vcpu
	#Memory Usage: $memory_use/$memory_all ($memory_percent%)
	#Disk Usage: $disk_use/$disk_all ($disk_precent%)
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm
	#Connections TCP: $connections
	#User log: $user
	#Network: $network
	#Sudo: $sudo
	"
}

print
