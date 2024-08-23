#!/bin/bash

#install BBR
#colorEcho $BLUE "��������BBR����"
echo net.core.default_qdisc=fq >> /etc/sysctl.conf
echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf
sysctl -p

#install shadowsocks
#colorEcho $BLUE "��װ shadowsocks��..."
mkdir /root/shadowsocks
cd /root/shadowsocks
wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.20.4/shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz
tar -xvJf shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz
chmod +x /root/shadowsocks/ssserver

#colorEcho $BLUE "ɾ�������ļ���..."
rm -rf /root/shadowsocks/shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz
rm -rf /root/shadowsocks/sslocal
rm -rf /root/shadowsocks/ssurl
rm -rf /root/shadowsocks/ssmanager
rm -rf /root/shadowsocks/ssservice

#colorEcho $BLUE "����shadowsocks��������������..."
echo "screen -dmS shadowsocks /root/shadowsocks/ssserver -s 0.0.0.0:12888 -m chacha20-ietf-poly1305 -k 123abc -U" >> /root/shadowsocks/run.sh
chmod +x /root/shadowsocks/run.sh
(echo @reboot /root/shadowsocks/run.sh;crontab -l) | crontab

#colorEcho $BLUE "shadowsocks��ɰ�װ"

#install frp
#colorEcho $BLUE "��װfrp��..."
mkdir /root/frp
cd /root/frp
wget https://github.com/fatedier/frp/releases/download/v0.60.0/frp_0.60.0_linux_amd64.tar.gz
gzip -d frp_0.60.0_linux_amd64.tar.gz
tar -xvf frp_0.60.0_linux_amd64.tar
cp /root/frp/frp_0.60.0_linux_amd64/frpc /root/frp

#colorEcho $BLUE "ɾ�������ļ���..."
rm -rf /root/frp/frp_0.60.0_linux_amd64
rm -rf /root/frp/frp_0.60.0_linux_amd64.tar

#colorEcho $BLUE "����frpc��������������..."
echo "screen -dmS frpc /root/frp/frpc -c /root/frp/frpc.toml" >> /root/frp/run.sh
chmod +x /root/frp/run.sh
(echo @reboot /root/frp/run.sh;crontab -l) | crontab

colorEcho $BLUE "frp��ɰ�װ"

colorEcho $BLUE  ȫ�������Ѿ�ִ�����
colorEcho $BLUE  ���ϴ�frpc.toml�ļ���/root/frpĿ¼��ִ��reboot�������vps

