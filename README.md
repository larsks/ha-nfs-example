This repository accompanies my series of blog posts titled "[HA NFS
With Ceph and NFS Ganesha][hanfs]".

[hanfs]: https://blog.oddbit.com/tag/series/ha-nfs/

- [part1](part1) sets up a virtual ceph cluster
- [part2](part2) sets up a virtual ceph cluster and a pair of servers
  that use [Pacemaker][] to manage an RBD resource and filesystem
  mount.
- [part3](part3) sets up a virtual ceph cluster, a pair of servers
  that use [Pacemaker][] to manage an RBD resource, a filesystem
  mount, and an NFS server using [NFS Ganesha][], as well as a client
  from which to test the NFS service.

[pacemaker]: https://wiki.clusterlabs.org/wiki/Pacemaker
[nfs ganesha]: https://github.com/nfs-ganesha/nfs-ganesha
