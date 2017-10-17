{config, pkgs, ...}:
{
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   defaultLocale = "en_GB.UTF-8";
  #   consoleKeyMap = "gb";
  # };
  # time.timeZone = "GB";

  services = {
    xserver = {
      enable = true;
      layout = "gb";
      xkbVariant = "mac";
      windowManager = {
        default = "i3";
        i3 = {
          enable = true;
          # package = pkgs.i3-gaps;
        };
      };
    };
  };

  users.mutableUsers = false;

  environment.systemPackages = with pkgs; [
    vim
  ];

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];
}
