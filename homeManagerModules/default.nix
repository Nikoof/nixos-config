{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./devel
    ./terminal
    ./apps
    ./wm
  ];
}
