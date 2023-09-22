{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/boot.nix
    ../../modules/environment.nix
    ../../modules/fonts.nix
    ../../modules/locale.nix
    ../../modules/services.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  # Networking
  networking = {
    hostName = "nkbox";
    networkmanager = {
      enable = true;
    };

    useDHCP = lib.mkDefault true;
    tempAddresses = "disabled";

    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        { from = 1630; to = 1641; }
        { from = 1714; to = 1764; }
      ];
      allowedUDPPortRanges = [
        { from = 1630; to = 1641; }
        { from = 1714; to = 1764; }
      ];
    };

    interfaces.enp3s0.wakeOnLan.enable = true;
  };


  # Video & Audio
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    xrandrHeads = [
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
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  # Services
  services.openssh.enable = true;
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };


  # Packages
  environment.systemPackages = with pkgs; ([
    # KDE Apps
    libsForQt5.kdeconnect-kde

    # System Utilities
    curl
    git
    gnupg
    pinentry
    cifs-utils
    playerctl

    # Editor
    neovim

    # Others
    hunspellDicts.en_US
    hunspellDicts.en_GB-ise
  ]);


  # Users
  users.users.nikoof = {
    description = "Nicolas Bratoveanu";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "dialout" "tty" "plugdev" "uucd" "libvirtd" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    users.nikoof = import ../../users/nikoof;
  };


  # Syncthing
  services.syncthing = {
    enable = true;
    user = "nikoof";
    dataDir = "/home/nikoof/Sync";
    configDir = "/home/nikoof/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "nkgalaxy" = { id = "FY2JIBO-6VYRLZD-YJBAUSF-W5CMUV7-RCXYVMU-NAKKIHT-NNZLTHA-ZHV3SAE"; };
      "nkideapad" = { id = "DFBQIQO-4Q5RHSF-TFQAH2X-7IH7URS-EQDBRHT-VAK7HAY-WXQC75W-7SOMIAO"; };
    };
    folders = {
      "Obsidian" = {
        path = "/home/nikoof/Documents/nkbrain";
        devices = [ "nkgalaxy" "nkideapad" ];
      };
      "KeePass" = {
        path = "/home/nikoof/KeePass";
        devices = [ "nkgalaxy" "nkideapad" ];
      };
    };
  };

  system.stateVersion = "23.05";
}

