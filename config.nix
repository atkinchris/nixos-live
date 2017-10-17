{config, pkgs, ...}:
{
  services = {
    xserver = {
      enable = true;
      layout = "gb";
      xkbVariant = "mac";
      displayManager.auto.enable = true;
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
