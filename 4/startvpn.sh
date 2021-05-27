#!/bin/bash
cat << EOF > wireguard_config.sh
#!/bin/bash
echo -n ${1} > /pkey
wg set wg0 private-key /pkey
EOF
aws ec2 --profile choop --region us-east-1 run-instances --image-id ami-0d59ca58f98dddbe3 --key-name MyKey --security-groups EC2SecurityGroup --instance-type t2.micro --placement AvailabilityZone=us-east-1a --user-data file://wireguard_config.sh
rm wireguard_config.sh
