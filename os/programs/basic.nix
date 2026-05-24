{ pkgs, ... }:
{
  programs = {
    fish.enable = true;
    # wshowkeys.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        glibc
        libgcc
        openssl
        curl
        libGL
        libxkbcommon
        wayland
        libX11
        libXcursor
        libXrandr
        libXi
      ];
    };
    virt-manager.enable = true;
    git = {
      enable = true;
      config = {
        safe = {
          directory = "*";
        };
      };
    };
  };
}
