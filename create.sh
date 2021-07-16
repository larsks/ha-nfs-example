#!/bin/sh

POOL=default
BASEIMAGE=Fedora-Cloud-Base-34-1.2.x86_64.raw
BASEIMAGE_FORMAT=raw
BASEIMAGE_OS=fedora34
DOMAIN=.storage

machines=()

create() {
	local name=$1$DOMAIN
	shift

	echo === $name ===
	machines+=($name)

	if virsh domid $name > /dev/null 2>&1; then
		echo "domain $name already exists" >&2
		return
	fi

	virt-install --noautoconsole -n $name "${@}"
}

create ceph \
	--disk pool=$POOL,size=10,backing_store=$BASEIMAGE,backing_format=$BASEIMAGE_FORMAT \
	--disk pool=$POOL,size=100 \
	--network network=default \
	--os-variant $BASEIMAGE_OS \
	--cloud-init ssh-key=id_rsa.pub \
	-r 4096

for name in client{1,2} nfs{1,2}; do
create $name \
	--disk pool=$POOL,size=10,backing_store=$BASEIMAGE,backing_format=$BASEIMAGE_FORMAT \
	--network network=default \
	--os-variant $BASEIMAGE_OS \
	--cloud-init ssh-key=id_rsa.pub \
	-r 4096
done

for name in ${machines[*]}; do
	echo waiting for $name to start...
	while ! ssh root@$name true > /dev/null 2>&1; do
		sleep 1
	done
done

for name in ${machines[*]}; do
	virsh shutdown $name
done

for name in ${machines[*]}; do
	echo waiting for $name to shut down
	while [[ $(virsh domid $name) != "-" ]]; do
		sleep 1
	done
done

for name in ${machines[*]}; do
	virsh start $name
done
