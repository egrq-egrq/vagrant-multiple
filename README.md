# Home Lab with Vagrant

## Description
- This repository contains a set of Vagrant configurations and helper scripts.
- Only Apple Silicon (ARM64) systems.

---

## Available Configurations

| Name | Virtualization | Status | Start command | Description |
|:----|:--------------:|:------:|:--------------|:------------|
| [arm64.vbox.Vagrantfile](https://github.com/egrq-egrq/vagrant-multiple/blob/master/arm64.vbox.Vagrantfile) | VirtualBox | Stable | `vagrant up --vagrantfile=arm64.vbox.Vagrantfile` | **Recommended.** Default daily-use configuration. |
| [vagrantWipe.sh](https://github.com/egrq-egrq/vagrant-multiple/blob/master/vagrantWipe.sh) | Unix-like | Stable | `chmod +x vagrantWipe.sh && ./vagrantWipe.sh` | **Recommended.** Safely & smart cleanup script vagrant waste product |
| [arm64.qemu.Vagrantfile](https://github.com/egrq-egrq/vagrant-multiple/blob/master/arm64.qemu.Vagrantfile) | QEMU | Stable | `vagrant up --provider=qemu --vagrantfile=arm64.qemu.Vagrantfile` | **Do not modify the box image!** Minimalistic QEMU configuration. Fast startup, no more |

---

## Deprecated
`Historical archive / legacy configurations`
