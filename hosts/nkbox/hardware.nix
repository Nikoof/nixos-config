# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/58f4e5f7-20ca-41ba-a073-366ee94fdf3a";
    fsType = "btrfs";
    options = ["subvol=@" "compress=zstd:3" "space_cache=v2" "ssd"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/58f4e5f7-20ca-41ba-a073-366ee94fdf3a";
    fsType = "btrfs";
    options = ["subvol=@nix" "compress=zstd:3" "space_cache=v2" "ssd" "noatime"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/00416392-9379-4110-b74d-e9f04dda1e0b";
    fsType = "btrfs";
    options = ["subvol=@home" "compress=zstd:3" "space_cache=v2"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D598-27BA";
    fsType = "vfat";
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/58f4e5f7-20ca-41ba-a073-366ee94fdf3a";
    fsType = "btrfs";
    options = ["subvol=@swap" "compress=zstd:3" "space_cache=v2" "ssd" "noatime"];
  };

  swapDevices = [{device = "/swap/swapfile";}];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
