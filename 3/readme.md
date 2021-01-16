# VPN configuration
The vpn network is configured to be 10.0.0.0/24 on port 51120 for server and client (see client example [config example file](https://github.com/isaacwe/liveproject_vpn/blob/main/3/home_network_wg_config.png)).
Each client has Allow ip section with the /24 subnet mask which enable them to reach the entire network
(wire guard add route on the client that redirect packets to different vpn members to the server and the server know all the other clients connected to it).

A special configuration is used on 10.0.0.3 which act as the gateway to my home network. Every packet on the vpn network having ip 192.168.2.0/24 is redirected to 
client 10.0.0.3 on which it used NAT to deliver the packet to my home network.
