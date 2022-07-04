#!/bin/bash


function print()
{
	local architecture=$1
	local cpu_physical=$2
	local vcpu=$3
	local memory=$4
	local disk=$5
	local cpu_load=$6
	local last_boot=$7
	local lvm=$8
	local connections=$9
	local user=${10}
	local network=${11}
	local sudo=${12}
	local user=${13}
	local tty=${14}

	printf "Broadcast message from: %s (%s) (%s)" $user $tty $time
	printf "Architecture: %s" $architecture
	printf "CPU physical: %s" $cpu_physical
	printf "vCPU: %s" $vcpu
	printf "Memory Usage: %s" $memory
	printf "Disk Usage: %s" $disk
	printf "CPU load: %s" $cpu_load
	printf "Last boot: %s" $last_boot
	printf "LVM use: %s" $lvm
	printf "Connections TCP: %s" $connections
	printf "User log: %s" $user
	printf "Network: %s" $network
	printf "Sudo: %s" $sudo
}

# Broadcast message from root@wil (tty1) (Sun Apr 25 15:45:00 2021):
#Architecture: Linux wil 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 GNU/Linux
#CPU physical : 1
#vCPU : 1
#Memory Usage: 74/987MB (7.50%)
#Disk Usage: 1009/2Gb (39%)
#CPU load: 6.7%
#Last boot: 2021-04-25 14:45
#LVM use: yes
#Connections TCP : 1 ESTABLISHED
#User log: 1
#Network: IP 10.0.2.15 (08:00:27:51:9b:a5)
#Sudo : 42 cmd
