#!/bin/sh

#docker run \
#  --privileged -p 53:53 -p 53:53/udp -p 88:88 -p 88:88/udp -p 135:135 -p 137:137/udp -p 138:138/udp -p 139:139 -p 389:389 -p 389:389/udp
#     -v $(pwd)/data:/var/lib/samba \
#     -v $(pwd)/config:/etc/samba \
#     -e SAMBA_DOMAIN=dc1 -e SAMBA_REALM=dc1.cloud.out.ba \
#     --name dc1 --dns 127.0.0.1 -d samba-ad-dc:trusty

S_DOMAIN=dc1
S_REALM=$S_DOMAIN.hano-bih.com
S_HOST_IP="192.168.168.89"
S_HOST_ETH="eth3"


ip addr add $S_HOST_IP/24 dev $S_HOST_ETH


docker rm -f $S_DOMAIN
docker run -d --name $S_DOMAIN \
     --privileged \
     -p $S_HOST_IP:53:53 -p $S_HOST_IP:53:53/udp -p $S_HOST_IP:88:88 -p $S_HOST_IP:88:88/udp -p $S_HOST_IP:135:135 -p $S_HOST_IP:137:137/udp \
     -p $S_HOST_IP:138:138/udp -p $S_HOST_IP:139:139 -p $S_HOST_IP:389:389 -p $S_HOST_IP:389:389/udp \
     -p $S_HOST_IP:445:445 -p $S_HOST_IP:464:464 -p $S_HOST_IP:464:464/udp -p $S_HOST_IP:636:636 \
     -p 3268:3268 -p 3269:3269 \
     -p $S_HOST_IP:1024:1024 -p $S_HOST_IP:1025:1025 -p $S_HOST_IP:1026:1026 -p $S_HOST_IP:1027:1027 -p $S_HOST_IP:1028:1028 -p $S_HOST_IP:1029:1029 -p $S_HOST_IP:1030:1030 -p $S_HOST_IP:1031:1031 -p $S_HOST_IP:1032:1032 \
     -p $S_HOST_IP:1033:1033 -p $S_HOST_IP:1034:1034 -p $S_HOST_IP:1035:1035 -p $S_HOST_IP:1036:1036 -p $S_HOST_IP:1037:1037 -p $S_HOST_IP:1038:1038 -p $S_HOST_IP:1039:1039 -p $S_HOST_IP:1040:1040 -p $S_HOST_IP:1041:1041 \
     -p $S_HOST_IP:1042:1042 -p $S_HOST_IP:1043:1043 -p $S_HOST_IP:1044:1044 \
     -v /data/samba/dc1-samba:/var/lib/samba \
     -v /data/samba/dc1-etc:/etc/samba \
     -e SAMBA_DOMAIN=$S_DOMAIN -e SAMBA_REALM=$S_REALM -e SAMBA_HOST_IP=$S_HOST_IP  \
     --dns=127.0.0.1 \
     samba-ad-dc 

echo pokreni:
echo docker logs $S_DOMAIN 2>&1 | head -3
