FROM nixos/nix

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
    nix-channel --update

VOLUME ["/output", "/cache"]
COPY *.nix /
COPY scripts/build.sh /

ENTRYPOINT [ "sh", "./build.sh" ]
