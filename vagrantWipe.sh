#!/usr/bin/env bash
set -euo pipefail

# Colors
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
NC="\033[0m"

info() {
  echo -e "${GREEN}[INFO]${NC} $*"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $*"
}

error() {
  echo -e "${RED}[ERROR]${NC} $*"
}

info "Working directory: $(pwd)"

if [[ ! -f Vagrantfile ]]; then
  error "No Vagrantfile in current directory. Aborting."
  exit 1
fi

info "Destroying all Vagrant VMs in this project"
vagrant destroy -f || warn "vagrant destroy failed (maybe nothing to destroy)"

info "Pruning global Vagrant status"
vagrant global-status --prune || warn "vagrant global-status --prune failed"

if [[ -d .vagrant ]]; then
  info "Removing local .vagrant directory"
  rm -rf .vagrant
else
  info ".vagrant directory not found, nothing to remove."
fi

info "Vagrant project cleanup done."