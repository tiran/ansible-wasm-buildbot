# ansible-wasm-buildbot

Ansible playbook for CPython WASM Buildbot

## Dependencies

* https://galaxy.ansible.com/staticdev/pyenv

## Azure provisioning

Playbook assumes that the host is an Ubuntu 20.04 system and provisioning
user can become root without sudo password.

We install all buildbot and buildenv files on a persistent disk, not on the
operating system disk. A fresh data disk has no partition table and file
system. The playbook mounts the disk to ``/datadrive`` and bind-mounts
``/opt`` to ``/datadrive/opt``.

```
parted /dev/disk/azure/scsi1/lun0 mklabel gpt mkpart xfspart xfs 0% 100%
mkfs.xfs /dev/disk/azure/scsi1/lun0-part1
partprobe /dev/disk/azure/scsi1/lun0-part1
```

## Monitoring

The buildbot host is running netdata on local HTTP port 19999.

```
ssh -C -L 19999:127.0.0.1:19999  azureuser@HOST
```
