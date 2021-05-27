#!/bin/bash
# when creating a new ec2 instance it is possible to add user-data to the instance that will run after boot
# the command to create the ec2 instance is:
#
# aws ec2 --profile choop --region us-east-1 run-instances --image-id ami-068663a3c619dd892 --key-name MyKey --security-groups EC2SecurityGroup --instance-type t2.micro --placement AvailabilityZone=us-east-1a --block-device-mappings DeviceName=/dev/sdh,Ebs={VolumeSize=8} --user-data file://start.sh
#
# Creating a security group and key pair need to take place only once (otherwise you'll get an error) therefore the commands to
# create them are not included.
apt-get -y update
apt-get -y install wireguard-tools
privatekey=$(wg genkey)
publickey=$(echo -n ${privatekey} | wg pubkey)
cat << EOF > /etc/wireguard/wg0.conf
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
cat << EOF > /etc/sysctl.conf
net.ipv4.ip_forward=1
EOF
echo 1 | tee /proc/sys/net/ipv4/ip_forward
systemctl enable wg-quick@wg0
reboot

