{ nixpkgs ? import <nixpkgs> {} }:

let pure-platform = import (builtins.fetchTarball https://github.com/grumply/pure-platform/tarball/583d615db3e815125c3f3d18d6de8fd95c66c57f) {};

in pure-platform.project ({ pkgs, ... }: {

  minimal = false;

  packages = {
    server = ./dev/server;
    dev = ./dev/dev;
  };

  shells = {
    ghc = [ "dev" "server" ];
    ghcjs = [ ];
  };

  tools = ghc: with ghc; [
    pkgs.haskellPackages.fsnotify
    pkgs.pkgs.dhall-json
    pkgs.pandoc
    pkgs.texlive.combined.scheme-full
  ];

})
