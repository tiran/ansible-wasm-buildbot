# ansible-wasm-buildbot

Ansible playbook for CPython WASM Buildbot

## Dependencies

* Ansible (ansible-playbook, ansible-galaxy)
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

## Ansible provisioning

* copy ``inventory.example`` to ``inventory`` and adjust the file
* run ``./ansible.sh``

## Post installation

The playbook does not provision and start the buildbot service. Follow the
on-screen installations to create the worker and start the buildbot.

```shell
# su buildbot -c '.../bin/buildbot-worker create-worker ...
# systemctl start buildbot.service
```

## Updates

The playbook can update and downgrade EMSDK, WASI-SDK, WASIX, and wasmtime.
It is recommended to check the
[buildbot UI](https://buildbot.python.org/all/#/builders?tags=%2Bwasm) first
and then stop the buildbot worker with ``systemctl stop buildbot.service``
once the worker is idle. The buildbot server must be started manually after
the update is done.

## Monitoring

The buildbot host is running netdata on local HTTP port 19999.

```
ssh -C -L 19999:127.0.0.1:19999  azureuser@HOST
```
