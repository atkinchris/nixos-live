#!/bin/bash
set -eu

CACHE_DIR="/cache"
STORE_DIR="/nix/store"

function on_exit {
  cp $STORE_DIR/* $CACHE_DIR
}

trap on_exit EXIT

if [ "$(ls -A $CACHE_DIR)" ]; then
  cp -r $CACHE_DIR/* $STORE_DIR
fi

nix-build \
  '<nixpkgs/nixos>' \
  -A config.system.build.isoImage \
  -I nixos-config=config.nix

mv $STORE_DIR/*.iso/iso/*.iso /output
