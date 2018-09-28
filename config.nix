# https://nixos.org/nixos/options.html
{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  time.timeZone = "Europe/London";

  services.xserver = {
    layout = "gb";
    xkbVariant = "mac";
  };

  users.mutableUsers = false;
}
