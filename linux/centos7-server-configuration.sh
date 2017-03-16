#
# Close firewalld: sudo systemctl stop firewalld
# http://docs.datastax.com/en/landing_page/doc/landing_page/recommendedSettingsLinux.html
# 

DEVOPS=devops
HL=hl

# set /etc/hosts
echo '
192.168.32.101  dn1
192.168.32.102  dn2
192.168.32.103  dn3
192.168.32.104  dn4
192.168.32.105  dn5
192.168.32.106  dn6

192.168.32.111  dn111
192.168.32.112  dn112
192.168.32.121  dn121
192.168.32.122  dn122
192.168.32.126  dn126
192.168.32.127  dn127
' >> /etc/hosts

yum -y update
yum -y install vim unzip tree curl htop telnet

# create directories
mkdir -p /home/app
mkdir -p /home/software
chown $DEVOPS:$DEVOPS /home/app
chown $HL:$DEVOPS /home/software

# modify user permissions
usermod -a -G devops $HL

# Production Linux Settings
echo '
# Network settings
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.rmem_default = 16777216
net.core.wmem_default = 16777216
net.core.optmem_max = 40960
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216

vm.max_map_count = 1048575
' >> /etc/sysctl.conf

echo '
devops           -       memlock         unlimited
devops           -       nofile          100000
devops           -       nproc           23768
devops           -       as              unlimited
' >> /etc/security/limits.conf

# devops .bash_profile
echo '
export JAVA_HOME="/home/app/local/java"
export PATH="$JAVA_HOME/bin:$PATH"
' >> /home/devops/.bash_profile


