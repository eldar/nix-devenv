{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =  {
    self,
    nixpkgs,
  }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
   devShells.${system}.default =
    pkgs.mkShell
    {
      buildInputs = with pkgs; [
        bashInteractive
        curl
        zsh
        stow
        git
        git-lfs
        ripgrep
        lua
        luarocks
        less
        neovim
        lazygit
        delta
        helix
      ];
      # https://github.com/NixOS/nix/issues/6677
      # https://discourse.nixos.org/t/interactive-bash-with-nix-develop-flake/15486
      shellHook = ''
        export PS1='\n\[\033[1;32m\][nix-shell:\w]\$\[\033[0m\] '
        SHELL=${pkgs.bashInteractive}/bin/bash
      '';
    };
  };
} 
