# This module defines a small NixOS installation CD.  It does not
# contain any graphical stuff.
{config, pkgs, ...}:
{
  services = {
    compton = {
      enable = true;
      fade = true;
    };

    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };

  services.xserver.windowManager.default = "i3";

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];
}
