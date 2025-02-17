{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

    ./hardware.nix
    ./services/syncthing.nix
  ];

  services.flatpak.enable = true;
  security.allowUserNamespaces = true;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ../../wallpapers/moebius-bw.png;
  };

  stylix.opacity = {
    applications = 1.0;
    terminal = 0.95;
    desktop = 1.0;
    popups = 1.0;
  };

  stylix.fonts = {
    sizes = {
      applications = 10;
      terminal = 12;
      desktop = 10;
      popups = 10;
    };

    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
      name = "FiraCode Nerd Font Mono";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = "x86_64-linux";

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "max";
    efi.canTouchEfiVariables = true;
  };

  boot.plymouth.enable = true;

  hardware.bluetooth.enable = true;
  networking = {
    hostName = "gauss";
    networkmanager.enable = true;
    firewall.enable = true;
    tempAddresses = "disabled";
    interfaces.enp3s0.wakeOnLan.enable = true;
    interfaces.enp3s0.useDHCP = true;
    nftables.enable = true;
  };

  users.users.nikoof = {
    description = "Nicolas Bratoveanu";
    isNormalUser = true;
    shell = "${pkgs.nushell}/bin/nu";
    extraGroups = ["wheel" "networkmanager" "dialout" "tty" "plugdev" "uucd" "libvirtd" "optical" "cdrom" "ubridge"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;

    users.nikoof = ./users/nikoof.nix;
  };

  desktop = {
    xdgDirs.enable = true;
    plasma.enable = true;

    printing.enable = true;
    printing.autodetect = true;
  };

  apps = {
    gns3.enable = true;

    gaming.bottles.enable = true;
    gaming.steam.enable = true;
    gaming.mangohud.enable = true;

    gaming.victoria2Server.openFirewall = true;
  };

  peripherals.wacom.enable = true;
  peripherals.nitrokey = {
    enable = true;
    enableSSHSupport = true;
  };

  services.ratbagd.enable = true;
  services.openssh.enable = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = ["856127940c682c75"];
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  programs.dconf.enable = true;

  services.xserver = {
    monitorSection = ''
      Modeline "1440x1080_60.00"  129.00  1440 1528 1680 1920  1080 1083 1087 1120 -hsync +vsync
    '';

    deviceSection = ''
      Option "ModeValidation" "AllowNonEdidModes"
    '';
  };

  services.xserver.xrandrHeads = [
    {
      output = "DP-3";
      primary = true;
    }
    {
      output = "HDMI-0";
      monitorConfig = ''
        Option "RightOf" "DP-3"
      '';
    }
  ];
}
