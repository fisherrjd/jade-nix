{ pkgs ? import
    (fetchTarball {
      name = "jpetrucciani-2023-04-26";
      url = "https://github.com/jpetrucciani/nix/archive/5f01d3c72d7d2b003debb8d333d654f5a51c2403.tar.gz";
      sha256 = "19kr4d49z54sf8z8llbdc720im07slb3128c0dpqc172hxrnpqwj";
    })
    { }
}:
let
  name = "cfg";
  tools = with pkgs; {
    cli = [
      bashInteractive
      cowsay
      curl
      delta
      dyff
      figlet
      gh
      git
      gron
      hax.comma
      jq
      just
      llama-cpp
      scc
      shfmt
      starship
      yq-go
      (writeShellScriptBin "hms" ''
        nix-env -i -f ~/cfg.nix
      '')
    ];
    nix = [
      direnv
      nil
      nix_hash_jpetrucciani
      nix-direnv
      nixpkgs-fmt
      nixup
    ];
    node = [
      nodejs_20
      nodePackages.prettier
    ];
    python = [
      (python311.withPackages (p: with p; [
        bandit
        black
        mypy
        requests
        ruff
        types-requests
      ]))
    ];
  };
  paths = pkgs.lib.flatten [ (builtins.attrValues tools) ];
in
pkgs.buildEnv {
  inherit name paths;
  buildInputs = paths;
}
