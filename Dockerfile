FROM nixos/nix

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
    nix-channel --update

VOLUME ["/output", "/cache"]
ADD . /

ENTRYPOINT [ "sh", "./build.sh" ]
