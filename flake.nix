{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs =  {
    self,
    nixpkgs,
    nixpkgs-stable,
  }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs-stable.legacyPackages.${system};
    unstable = nixpkgs.legacyPackages.${system};

    stableInputs = with pkgs; [
      curl
      zsh
      stow
      git
      ripgrep
      lua
      luarocks
      tmux
      less
    ];
    
    unstableInputs = with unstable; [
      neovim
      lazygit
      delta
      helix
    ];
  in
  {
   devShells.${system}.default =
    pkgs.mkShell
    {
      buildInputs = stableInputs ++ unstableInputs;
      # https://github.com/NixOS/nix/issues/6677
      shellHook = ''
        export PS1='\n\[\033[1;32m\][nix-shell:\w]\$\[\033[0m\] '
      '';
    };
  };
} 
