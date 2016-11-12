#!/bin/bash
# Created by mindcrank Twitter: @n0mad86
# Queries based off of https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/
# Credit to Twitter: @g0tmi1k
# Version 0.1

DIR=`pwd`
DUMP=`dump.txt`

echo "##Operating System" >> ${DIR}\${DUMP}
echo "#What's the distribution type? What version?" >> ${DIR}\${DUMP}
cat /etc/issue >> ${DIR}\${DUMP}
cat /etc/*-release >> ${DIR}\${DUMP}
cat /etc/lsb-release >> ${DIR}\${DUMP}
cat /etc/redhat-release >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What's the kernel version? Is it 64-bit?" >> ${DIR}\${DUMP}
cat /proc/version >> ${DIR}\${DUMP}
uname -a >> ${DIR}\${DUMP}
uname -mrs >> ${DIR}\${DUMP}
rpm -q kernel >> ${DIR}\${DUMP}
dmesg | grep Linux >> ${DIR}\${DUMP}
ls /boot | grep vmlinuz- >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What can be learnt from the environmental variables?" >> ${DIR}\${DUMP}
cat /etc/profile >> ${DIR}\${DUMP}
cat /etc/bashrc >> ${DIR}\${DUMP}
cat ~/.bash_profile >> ${DIR}\${DUMP}
cat ~/.bashrc >> ${DIR}\${DUMP}
cat ~/.bash_logout >> ${DIR}\${DUMP}
env >> ${DIR}\${DUMP}
set >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Is there a printer?" >> ${DIR}\${DUMP}
lpstat -a >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "##Applications & Services" >> ${DIR}\${DUMP}
echo "#What services are running? Which service has which user privilege?" >> ${DIR}\${DUMP}
ps aux >> ${DIR}\${DUMP}
ps -ef >> ${DIR}\${DUMP}
top >> ${DIR}\${DUMP}
cat /etc/services >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Which service(s) are been running by root? Of these services, which are vulnerable - it's worth a double check!" >> ${DIR}\${DUMP}
ps aux | grep root >> ${DIR}\${DUMP}
ps -ef | grep root >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What applications are installed? What version are they? Are they currently running?" >> ${DIR}\${DUMP}
ls -alh /usr/bin/ >> ${DIR}\${DUMP}
ls -alh /sbin/ >> ${DIR}\${DUMP}
dpkg -l >> ${DIR}\${DUMP}
rpm -qa >> ${DIR}\${DUMP}
ls -alh /var/cache/apt/archivesO >> ${DIR}\${DUMP}
ls -alh /var/cache/yum/ >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Any of the service(s) settings misconfigured? Are any (vulnerable) plugins attached?" >> ${DIR}\${DUMP}
cat /etc/syslog.conf >> ${DIR}\${DUMP}
cat /etc/chttp.conf >> ${DIR}\${DUMP}
cat /etc/lighttpd.conf >> ${DIR}\${DUMP}
cat /etc/cups/cupsd.conf >> ${DIR}\${DUMP}
cat /etc/inetd.conf >> ${DIR}\${DUMP}
cat /etc/apache2/apache2.conf >> ${DIR}\${DUMP}
cat /etc/my.conf >> ${DIR}\${DUMP}
cat /etc/httpd/conf/httpd.conf >> ${DIR}\${DUMP}
cat /opt/lampp/etc/httpd.conf >> ${DIR}\${DUMP}
ls -aRl /etc/ | awk '$1 ~ /^.*r.*/' >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What jobs are scheduled?" >> ${DIR}\${DUMP}
crontab -l >> ${DIR}\${DUMP}
ls -alh /var/spool/cron >> ${DIR}\${DUMP}
ls -al /etc/ | grep cron >> ${DIR}\${DUMP}
ls -al /etc/cron* >> ${DIR}\${DUMP}
cat /etc/cron* >> ${DIR}\${DUMP}
cat /etc/at.allow >> ${DIR}\${DUMP}
cat /etc/at.deny >> ${DIR}\${DUMP}
cat /etc/cron.allow >> ${DIR}\${DUMP}
cat /etc/cron.deny >> ${DIR}\${DUMP}
cat /etc/crontab >> ${DIR}\${DUMP}
cat /etc/anacrontab >> ${DIR}\${DUMP}
cat /var/spool/cron/crontabs/root >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Any plain text usernames and/or passwords?" >> ${DIR}\${DUMP}
grep -i user [filename] >> ${DIR}\${DUMP}
grep -i pass [filename] >> ${DIR}\${DUMP}
grep -C 5 "password" [filename] >> ${DIR}\${DUMP}
find . -name "*.php" -print0 | xargs -0 grep -i -n "var $password" >> ${DIR}\${DUMP}   # Joomla
echo " " >> ${DIR}\${DUMP}

echo "##Communications & Networking" >> ${DIR}\${DUMP}
echo "#What NIC(s) does the system have? Is it connected to another network?" >> ${DIR}\${DUMP}
/sbin/ifconfig -a >> ${DIR}\${DUMP}
cat /etc/network/interfaces >> ${DIR}\${DUMP}
cat /etc/sysconfig/network >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What are the network configuration settings? What can you find out about this network? DHCP server? DNS server? Gateway?" >> ${DIR}\${DUMP}
cat /etc/resolv.conf >> ${DIR}\${DUMP}
cat /etc/sysconfig/network >> ${DIR}\${DUMP}
cat /etc/networks >> ${DIR}\${DUMP}
iptables -L >> ${DIR}\${DUMP}
hostname >> ${DIR}\${DUMP}
dnsdomainname >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What other users & hosts are communicating with the system?" >> ${DIR}\${DUMP}
lsof -i >> ${DIR}\${DUMP}
lsof -i :80 >> ${DIR}\${DUMP}
grep 80 /etc/services >> ${DIR}\${DUMP}
netstat -antup >> ${DIR}\${DUMP}
netstat -antpx >> ${DIR}\${DUMP}
netstat -tulpn >> ${DIR}\${DUMP}
chkconfig --list >> ${DIR}\${DUMP}
chkconfig --list | grep 3:on >> ${DIR}\${DUMP}
last >> ${DIR}\${DUMP}
w >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Whats cached? IP and/or MAC addresses" >> ${DIR}\${DUMP}
arp -e >> ${DIR}\${DUMP}
route >> ${DIR}\${DUMP}
/sbin/route -nee >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "##Confidential Information & Users" >> ${DIR}\${DUMP}
echo "#Who are you? Who is logged in? Who has been logged in? Who else is there? Who can do what?" >> ${DIR}\${DUMP}
id >> ${DIR}\${DUMP}
who >> ${DIR}\${DUMP}
w >> ${DIR}\${DUMP}
last >> ${DIR}\${DUMP}
cat /etc/passwd | cut -d: -f1 >> ${DIR}\${DUMP}    # List of users
grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}' >> ${DIR}\${DUMP}   # List of super users
awk -F: '($3 == "0") {print}' /etc/passwd >> ${DIR}\${DUMP}   # List of super users
cat /etc/sudoers >> ${DIR}\${DUMP}
sudo -l >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What sensitive files can be found?" >> ${DIR}\${DUMP}
cat /etc/passwd >> ${DIR}\${DUMP}
cat /etc/group >> ${DIR}\${DUMP}
cat /etc/shadow >> ${DIR}\${DUMP}
ls -alh /var/mail/ >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Anything 'interesting' in the home directorie(s)? If it's possible to access" >> ${DIR}\${DUMP}
ls -ahlR /root/ >> ${DIR}\${DUMP}
ls -ahlR /home/ >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Are there any passwords in; scripts, databases, configuration files or log files? Default paths and locations for passwords" >> ${DIR}\${DUMP}
cat /var/apache2/config.inc >> ${DIR}\${DUMP}
cat /var/lib/mysql/mysql/user.MYD >> ${DIR}\${DUMP}
cat /root/anaconda-ks.cfg >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What has the user being doing? Is there any password in plain text? What have they been edting?" >> ${DIR}\${DUMP}
cat ~/.bash_history >> ${DIR}\${DUMP}
cat ~/.nano_history >> ${DIR}\${DUMP}
cat ~/.atftp_history >> ${DIR}\${DUMP}
cat ~/.mysql_history >> ${DIR}\${DUMP}
cat ~/.php_history >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What user information can be found?" >> ${DIR}\${DUMP}
cat ~/.bashrc >> ${DIR}\${DUMP}
cat ~/.profile >> ${DIR}\${DUMP}
cat /var/mail/root >> ${DIR}\${DUMP}
cat /var/spool/mail/root >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Can private-key information be found?" >> ${DIR}\${DUMP}
cat ~/.ssh/authorized_keys >> ${DIR}\${DUMP}
cat ~/.ssh/identity.pub >> ${DIR}\${DUMP}
cat ~/.ssh/identity >> ${DIR}\${DUMP}
cat ~/.ssh/id_rsa.pub >> ${DIR}\${DUMP}
cat ~/.ssh/id_rsa >> ${DIR}\${DUMP}
cat ~/.ssh/id_dsa.pub >> ${DIR}\${DUMP}
cat ~/.ssh/id_dsa >> ${DIR}\${DUMP}
cat /etc/ssh/ssh_config >> ${DIR}\${DUMP}
cat /etc/ssh/sshd_config >> ${DIR}\${DUMP}
cat /etc/ssh/ssh_host_dsa_key.pub >> ${DIR}\${DUMP}
cat /etc/ssh/ssh_host_dsa_key >> ${DIR}\${DUMP}
cat /etc/ssh/ssh_host_rsa_key.pub >> ${DIR}\${DUMP}
cat /etc/ssh/ssh_host_rsa_key >> ${DIR}\${DUMP}
cat /etc/ssh/ssh_host_key.pub >> ${DIR}\${DUMP}
cat /etc/ssh/ssh_host_key >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "##File Systems" >> ${DIR}\${DUMP}
echo "#Which configuration files can be written in /etc/? Able to reconfigure a service?" >> ${DIR}\${DUMP}
ls -aRl /etc/ | awk '$1 ~ /^.*w.*/' 2>/dev/null >> ${DIR}\${DUMP}     # Anyone
ls -aRl /etc/ | awk '$1 ~ /^..w/' 2>/dev/null >> ${DIR}\${DUMP}       # Owner
ls -aRl /etc/ | awk '$1 ~ /^.....w/' 2>/dev/null >> ${DIR}\${DUMP}    # Group
ls -aRl /etc/ | awk '$1 ~ /w.$/' 2>/dev/null >> ${DIR}\${DUMP}        # Other
find /etc/ -readable -type f 2>/dev/null >> ${DIR}\${DUMP}               # Anyone
find /etc/ -readable -type f -maxdepth 1 2>/dev/null >> ${DIR}\${DUMP}   # Anyone
echo " " >> ${DIR}\${DUMP}

echo "#What can be found in /var/ ?" >> ${DIR}\${DUMP}
ls -alh /var/log >> ${DIR}\${DUMP}
ls -alh /var/mail >> ${DIR}\${DUMP}
ls -alh /var/spool >> ${DIR}\${DUMP}
ls -alh /var/spool/lpd >> ${DIR}\${DUMP}
ls -alh /var/lib/pgsql >> ${DIR}\${DUMP}
ls -alh /var/lib/mysql >> ${DIR}\${DUMP}
cat /var/lib/dhcp3/dhclient.leases >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Any settings/files (hidden) on website? Any settings file with database information?" >> ${DIR}\${DUMP}
ls -alhR /var/www/ >> ${DIR}\${DUMP}
ls -alhR /srv/www/htdocs/ >> ${DIR}\${DUMP}
ls -alhR /usr/local/www/apache22/data/ >> ${DIR}\${DUMP}
ls -alhR /opt/lampp/htdocs/ >> ${DIR}\${DUMP}
ls -alhR /var/www/html/ >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Is there anything in the log file(s) (Could help with "Local File Includes"!)" >> ${DIR}\${DUMP}
cat /etc/httpd/logs/access_log >> ${DIR}\${DUMP}
cat /etc/httpd/logs/access.log >> ${DIR}\${DUMP}
cat /etc/httpd/logs/error_log >> ${DIR}\${DUMP}
cat /etc/httpd/logs/error.log >> ${DIR}\${DUMP}
cat /var/log/apache2/access_log >> ${DIR}\${DUMP}
cat /var/log/apache2/access.log >> ${DIR}\${DUMP}
cat /var/log/apache2/error_log >> ${DIR}\${DUMP}
cat /var/log/apache2/error.log >> ${DIR}\${DUMP}
cat /var/log/apache/access_log >> ${DIR}\${DUMP}
cat /var/log/apache/access.log >> ${DIR}\${DUMP}
cat /var/log/auth.log >> ${DIR}\${DUMP}
cat /var/log/chttp.log >> ${DIR}\${DUMP}
cat /var/log/cups/error_log >> ${DIR}\${DUMP}
cat /var/log/dpkg.log >> ${DIR}\${DUMP}
cat /var/log/faillog >> ${DIR}\${DUMP}
cat /var/log/httpd/access_log >> ${DIR}\${DUMP}
cat /var/log/httpd/access.log >> ${DIR}\${DUMP}
cat /var/log/httpd/error_log >> ${DIR}\${DUMP}
cat /var/log/httpd/error.log >> ${DIR}\${DUMP}
cat /var/log/lastlog >> ${DIR}\${DUMP}
cat /var/log/lighttpd/access.log >> ${DIR}\${DUMP}
cat /var/log/lighttpd/error.log >> ${DIR}\${DUMP}
cat /var/log/lighttpd/lighttpd.access.log >> ${DIR}\${DUMP}
cat /var/log/lighttpd/lighttpd.error.log >> ${DIR}\${DUMP}
cat /var/log/messages >> ${DIR}\${DUMP}
cat /var/log/secure >> ${DIR}\${DUMP}
cat /var/log/syslog >> ${DIR}\${DUMP}
cat /var/log/wtmp >> ${DIR}\${DUMP}
cat /var/log/xferlog >> ${DIR}\${DUMP}
cat /var/log/yum.log >> ${DIR}\${DUMP}
cat /var/run/utmp >> ${DIR}\${DUMP}
cat /var/webmin/miniserv.log >> ${DIR}\${DUMP}
cat /var/www/logs/access_log >> ${DIR}\${DUMP}
cat /var/www/logs/access.log >> ${DIR}\${DUMP}
ls -alh /var/lib/dhcp3/ >> ${DIR}\${DUMP}
ls -alh /var/log/postgresql/ >> ${DIR}\${DUMP}
ls -alh /var/log/proftpd/ >> ${DIR}\${DUMP}
ls -alh /var/log/samba/ >> ${DIR}\${DUMP}
# Note: auth.log, boot, btmp, daemon.log, debug, dmesg, kern.log, mail.info, mail.log, mail.warn, messages, syslog, udev, wtmp
echo " " >> ${DIR}\${DUMP}

echo "#If commands are limited, you break out of the "jail" shell?" >> ${DIR}\${DUMP}
python -c 'import pty;pty.spawn("/bin/bash")' >> ${DIR}\${DUMP}
echo os.system('/bin/bash') >> ${DIR}\${DUMP}
/bin/sh -i >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#How are file-systems mounted?" >> ${DIR}\${DUMP}
mount >> ${DIR}\${DUMP}
df -h >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Are there any unmounted file-systems?" >> ${DIR}\${DUMP}
cat /etc/fstab >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#What "Advanced Linux File Permissions" are used? Sticky bits, SUID & GUID" >> ${DIR}\${DUMP}
find / -perm -1000 -type d 2>/dev/null >> ${DIR}\${DUMP}   # Sticky bit - Only the owner of the directory or the owner of a file can delete or rename here.
find / -perm -g=s -type f 2>/dev/null >> ${DIR}\${DUMP}    # SGID (chmod 2000) - run as the group, not the user who started it.
find / -perm -u=s -type f 2>/dev/null >> ${DIR}\${DUMP}    # SUID (chmod 4000) - run as the owner, not the user who started it.
find / -perm -g=s -o -perm -u=s -type f 2>/dev/null >> ${DIR}\${DUMP}    # SGID or SUID
for i in `locate -r "bin$"`; do find $i \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null; done >> ${DIR}\${DUMP}    # Looks in 'common' places: /bin, /sbin, /usr/bin, /usr/sbin, /usr/local/bin, /usr/local/sbin and any other *bin, for SGID or SUID (Quicker search)
# find starting at root (/), SGID or SUID, not Symbolic links, only 3 folders deep, list with more detail and hide any errors (e.g. permission denied)
find / -perm -g=s -o -perm -4000 ! -type l -maxdepth 3 -exec ls -ld {} \; 2>/dev/null >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#Where can written to and executed from? A few 'common' places: /tmp, /var/tmp, /dev/shm" >> ${DIR}\${DUMP}
find / -writable -type d 2>/dev/null >> ${DIR}\${DUMP}      # world-writeable folders
find / -perm -222 -type d 2>/dev/null >> ${DIR}\${DUMP}     # world-writeable folders
find / -perm -o w -type d 2>/dev/null >> ${DIR}\${DUMP}     # world-writeable folders
find / -perm -o x -type d 2>/dev/null >> ${DIR}\${DUMP}     # world-executable folders
find / \( -perm -o w -perm -o x \) -type d 2>/dev/null >> ${DIR}\${DUMP}   # world-writeable & executable folders
echo " " >> ${DIR}\${DUMP}

echo "#Any "problem" files? Word-writeable, "nobody" files" >> ${DIR}\${DUMP}
find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print >> ${DIR}\${DUMP}   # world-writeable files
find /dir -xdev \( -nouser -o -nogroup \) -print >> ${DIR}\${DUMP}   # Noowner files
echo " " >> ${DIR}\${DUMP}

echo "##Preparation & Finding Exploit Code" >> ${DIR}\${DUMP}
echo "#What development tools/languages are installed/supported?" >> ${DIR}\${DUMP}
find / -name perl* >> ${DIR}\${DUMP}
find / -name python* >> ${DIR}\${DUMP}
find / -name gcc* >> ${DIR}\${DUMP}
find / -name cc >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}

echo "#How can files be uploaded?" >> ${DIR}\${DUMP}
find / -name wget >> ${DIR}\${DUMP}
find / -name nc* >> ${DIR}\${DUMP}
find / -name netcat* >> ${DIR}\${DUMP}
find / -name tftp* >> ${DIR}\${DUMP}
find / -name ftp >> ${DIR}\${DUMP}
echo " " >> ${DIR}\${DUMP}
