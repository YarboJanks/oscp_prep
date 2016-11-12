#!/bin/bash
# Simple network enumeration made by mindcrank
# Twitter @n0mad86
#
DIR=`pwd`
DUMP='dump.txt'
DISCOVER='discovered.txt'

nmap -n -sn $1 -oG - | awk '/Up$/{print $2}' >> ${DIR}/${DISCOVER}
nmap -v -p- -sV -O -sT -iL ${DIR}/${DISCOVER}