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

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c10e2f83-8c02-4c75-99ab-40aaa3b71bb3";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/c10e2f83-8c02-4c75-99ab-40aaa3b71bb3";
    fsType = "btrfs";
    options = ["subvol=@nix"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c10e2f83-8c02-4c75-99ab-40aaa3b71bb3";
    fsType = "btrfs";
    options = ["subvol=@home"];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/c10e2f83-8c02-4c75-99ab-40aaa3b71bb3";
    fsType = "btrfs";
    options = ["subvol=@swap"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E70B-B6CF";
    fsType = "vfat";
  };

  swapDevices = [{device = "/swap/swapfile";}];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20f0u1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp47s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
