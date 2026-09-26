{ config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    hello
    strace
    ltrace
    htop
    iotop
    iftop
    nettools
    procps
    openssl
  ];

  system.stateVersion = "24.05";
}