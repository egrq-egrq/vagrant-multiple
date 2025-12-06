# Home Lab with Vagrant

## Description
- This repository contains a set of Vagrant configurations and helper scripts.
- Only Apple Silicon (ARM64) systems.

---

## Available Configurations

| Name | Virtualization | Status | Usage | Description |
|:----|:--------------:|:------:|:--------------|:------------|
| [Vagrantfile](https://github.com/egrq-egrq/vagrant-multiple/blob/master/Vagrantfile) | VirtualBox | Stable | `vagrant up` | **Recommended.** Default daily-use configuration. |
| [vagrantWipe.sh](https://github.com/egrq-egrq/vagrant-multiple/blob/master/vagrantWipe.sh) | Unix-like | Stable | `chmod +x vagrantWipe.sh && ./vagrantWipe.sh` | **Recommended.** Safely & smart cleanup script vagrant waste product |
| [arm64.qemu.Vagrantfile](https://github.com/egrq-egrq/vagrant-multiple/blob/master/arm64.qemu.Vagrantfile) | QEMU | Stable | `vagrant up --provider=qemu --vagrantfile=arm64.qemu.Vagrantfile` | **Do not modify the box image!** Minimalistic QEMU configuration. Fast startup, no more |

---

## Deprecated
`Historical archive / legacy configurations`
