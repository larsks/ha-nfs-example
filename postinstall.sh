#!/bin/sh

ganesha-rados-grace \
	--userid nfsmeta \
	--ns ganesha \
	--pool cephfs.tank.meta \
	add nfs.storage

pcs resource create --group nfs nfs_vip \
	IPaddr2 ip=192.168.122.254 cidr_netmask=24 \
	op monitor interval=10s
pcs resource create --group nfs nfsd \
	systemd:nfs-ganesha op monitor interval=10s
