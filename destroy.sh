#!/bin/sh

DOMAIN=.storage

for name in ceph nfs{1,2} client{1,2}; do
	virsh destroy $name${DOMAIN}
	virsh undefine --remove-all-storage $name${DOMAIN}
done
