{ lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "uinput" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=0
    options iwlmvm power_scheme=1
  '';
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/708dae67-60e6-469b-a443-2239de0b4753";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/49ED-0A4F";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/74fc403d-48ef-481b-b4a3-50d8155c6341"; }];

  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau
    libvdpau-va-gl
  ];


}
