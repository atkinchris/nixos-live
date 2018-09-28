# https://nixos.org/nixos/options.html
{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  time.timeZone = "Europe/London";

  services.xserver = {
    enable = true;

    layout = "gb";
    xkbVariant = "mac";

    desktopManager.gnome3.enable = true;
    displayManager.gdm.autoLogin = {
      enable = true;
      user = "root";
    };
  };

  users.mutableUsers = false;

  networking.networkmanager.enable = true;
  networking.wireless.enable = mkForce false;
  powerManagement.enable = true;

  environment.systemPackages = with pkgs; [
    vim
  ];
}
