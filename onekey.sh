#!/bin/bash

#install BBR
echo "正在启动BBR功能"
echo net.core.default_qdisc=fq >> /etc/sysctl.conf
echo net.ipv4.tcp_congestion_control=bbr >> /etc/sysctl.conf
sysctl -p
sleep 2

#install shadowsocks
echo "安装 shadowsocks中..."
mkdir /root/shadowsocks
cd /root/shadowsocks
wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.20.4/shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz
tar -xvJf shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz
chmod +x /root/shadowsocks/ssserver
sleep 2
echo "删除多余文件中..."
rm -rf /root/shadowsocks/shadowsocks-v1.20.4.x86_64-unknown-linux-gnu.tar.xz
rm -rf /root/shadowsocks/sslocal
rm -rf /root/shadowsocks/ssurl
rm -rf /root/shadowsocks/ssmanager
rm -rf /root/shadowsocks/ssservice
sleep 2
echo "创建shadowsocks开机自启动操作..."
echo "screen -dmS shadowsocks /root/shadowsocks/ssserver -s 0.0.0.0:12888 -m chacha20-ietf-poly1305 -k 123abc -U" >> /root/shadowsocks/run.sh
chmod +x /root/shadowsocks/run.sh
(echo @reboot /root/shadowsocks/run.sh;crontab -l) | crontab
echo "shadowsocks完成安装"
sleep 2
#install frp
echo "安装frp中..."
mkdir /root/frp
cd /root/frp
wget https://github.com/fatedier/frp/releases/download/v0.60.0/frp_0.60.0_linux_amd64.tar.gz
gzip -d frp_0.60.0_linux_amd64.tar.gz
tar -xvf frp_0.60.0_linux_amd64.tar
cp /root/frp/frp_0.60.0_linux_amd64/frpc /root/frp
sleep 2
echo "删除多余文件中..."
rm -rf /root/frp/frp_0.60.0_linux_amd64
rm -rf /root/frp/frp_0.60.0_linux_amd64.tar
sleep 2
echo "创建frpc开机自启动操作..."
echo "screen -dmS frpc /root/frp/frpc -c /root/frp/frpc.toml" >> /root/frp/run.sh
chmod +x /root/frp/run.sh
(echo @reboot /root/frp/run.sh;crontab -l) | crontab
sleep 2
echo "frp完成安装"
echo  "全部操作已经执行完毕"
echo  "请上传frpc.toml文件到/root/frp目录后执行reboot命令，重启vps"

