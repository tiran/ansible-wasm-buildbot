# ansible-wasm-buildbot

Ansible playbook for CPython WASM Buildbot

## Dependencies

* https://galaxy.ansible.com/staticdev/pyenv

## Azure provisioning

Playbook assumes that the host is an Ubuntu 20.04 system and provisioning
user can become root without sudo password.

We install all buildbot and buildenv files on a persistent disk, not on the
operating system disk. A fresh data disk has no partition table and file
system. The disk is mounted to ``/datadrive`` and ``/opt`` is bind-mounted
to ``/datadrive/opt``.

```
parted /dev/disk/azure/scsi1/lun0 mklabel gpt mkpart xfspart xfs 0% 100%
mkfs.xfs /dev/disk/azure/scsi1/lun0-part1
partprobe /dev/disk/azure/scsi1/lun0-part1
```

```
# append to /etc/fstab
/dev/disk/azure/scsi1/lun0-part1 /datadrive xfs defaults,nofail 0 2
/datadrive/opt /opt none defaults,bind 0 2
```

```
mkdir /datadrive
mount /datadrive
mkdir /datadrive/opt
mount /opt
```

