{ config, lib, pkgs, modulesPath, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
  fonts.fontDir.enable = true;
}
