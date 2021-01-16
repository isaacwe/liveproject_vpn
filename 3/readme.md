# VPN configuration
The vpn network is configured to be 10.0.0.0/24 on port 51120 for server and client (see client example [config example file](https://github.com/isaacwe/liveproject_vpn/blob/main/3/home_network_wg_config.png)).
Each client have an "Allow IP" section with the /24 subnet mask which enable them to reach the entire network
(wire guard adds routes on the client that redirect packets to different VPN members to the server and the server knows all the other clients connected to it).

A special configuration is used on 10.0.0.3 which acts as the gateway to my home network. Every packet on the VPN network having IP 192.168.2.0/24 is redirected to 
client 10.0.0.3 on which it used NAT to deliver the packet to my home network.
 
[wg command on AWS VPN server & mounting NFS folder from 10.0.0.3 (see next section)](https://github.com/isaacwe/liveproject_vpn/blob/main/3/server_and_nfs_mount.png)

# Shared resources
 Client 10.0.0.3 is also an NFS server ([see export file](https://github.com/isaacwe/liveproject_vpn/blob/main/3/nfs_server_exports.png))
which exports the media folder to the entire VPN network.

Also, see Public SMB share on 192.168.2.2 (home network) as seen from my smartphone.

[smartphone configuration](https://github.com/isaacwe/liveproject_vpn/blob/main/3/smartphone_config.jpg)

[smartphone SMB mount from VLC app](https://github.com/isaacwe/liveproject_vpn/blob/main/3/smb_access_on_smartphone.jpg)
