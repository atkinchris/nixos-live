FROM nixos/nix

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
    nix-channel --update

VOLUME /output
ADD config.nix /

CMD nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=config.nix && \
    cp /nix/store/*.iso/iso/*.iso /output
