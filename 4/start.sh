#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install wireguard-tools
privatekey=$(wg genkey)
publickey=$(echo -n ${privatekey} | wg pubkey)
sudo cat << EOF > /etc/wireguard/wg0.conf
[Interface]
Address = 10.0.0.1/24
ListenPort = 51120
PrivateKey = ${privatekey}
PostUp   = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE;
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE;
[Peer]
PublicKey = 4rAKHOQhV9wfwmaWSGKnjir2/xjkce8idAZqbNqeRHM=
AllowedIPs = 10.0.0.2/32

[Peer]
PublicKey = 63SJ38K7hvS/7VIwpNKNoNPnesWRrOJXhHImwxvkcQo=
AllowedIPs = 10.0.0.3/32, 192.168.2.0/24 

[peer]
PublicKey = dohkV/AfkeKzCRtPhj6dp26ZRF8y/Gmnkc7P+Me16i4=
AllowedIPs = 10.0.0.4/32
EOF
sudo echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo systemctl start wg-quick@wg0


