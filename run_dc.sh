#!/bin/sh

#docker run \
#  --privileged -p 53:53 -p 53:53/udp -p 88:88 -p 88:88/udp -p 135:135 -p 137:137/udp -p 138:138/udp -p 139:139 -p 389:389 -p 389:389/udp
#     -v $(pwd)/data:/var/lib/samba \
#     -v $(pwd)/config:/etc/samba \
#     -e SAMBA_DOMAIN=dc1 -e SAMBA_REALM=dc1.cloud.out.ba \
#     --name dc1 --dns 127.0.0.1 -d samba-ad-dc:trusty

S_DOMAIN=dc1
S_REALM=$S_DOMAIN.test.com

docker rm -f $S_DOMAIN
docker run -d --name $S_DOMAIN \
     --privileged \
     -p 53:53 -p 53:53/udp -p 88:88 -p 88:88/udp -p 135:135 -p 137:137/udp \
     -p 138:138/udp -p 139:139 -p 389:389 -p 389:389/udp \
     -p 445:445 -p 464:464 -p 464:464/udp -p 636:636 \
     -p 3268:3268 -p 3269:3269 \
     -p 1024:1024 -p 1025:1025 -p 1026:1026 -p 1027:1027 -p 1028:1028 -p 1029:1029 -p 1030:1030 -p 1031:1031 -p 1032:1032 \
     -p 1033:1033 -p 1034:1034 -p 1035:1035 -p 1036:1036 -p 1037:1037 -p 1038:1038 -p 1039:1039 -p 1040:1040 -p 1041:1041 \
     -p 1042:1042 -p 1043:1043 -p 1044:1044 \
     -v /data/samba/dc1-samba:/var/lib/samba \
     -v /data/samba/dc1-etc:/etc/samba \
     -e SAMBA_DOMAIN=$S_DOMAIN -e SAMBA_REALM=$S_REALM -e "SAMBA_HOST_IP=$(hostname --all-ip-addresses |cut -f 1 -d' ')"  \
     --dns=127.0.0.1 \
     samba-ad-dc 

echo pokreni:
echo docker logs $S_DOMAIN 2>&1 | head -3
