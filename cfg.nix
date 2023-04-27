{ jacobi ? import
    (fetchTarball {
      name = "jpetrucciani-2023-04-26";
      url = "https://github.com/jpetrucciani/nix/archive/bad05f7d6160f6ade2c51de0ae27a32e2a5df353.tar.gz";
      sha256 = "0m589a9kba8fkz2iaq02k8baq9h6fbj1rm1haph3fwqxybjhji88";
    })
    { }
}:
let
  name = "cfg";
  tools = with jacobi; {
    cli = [
      bashInteractive
      gh
      hax.comma
      cowsay
      curl
      delta
      dyff
      figlet
      git
      gron
      llama-cpp
      starship
      jq
      just
      nodePackages.prettier
      scc
      shfmt
      yq-go
      (writeShellScriptBin "hms" ''
        nix-env -i -f ~/cfg.nix
      '')
    ];
    nix = [
      nixpkgs-fmt
      nixup
      rnix-lsp
      nix_hash_jpetrucciani
      nix-direnv
      direnv
    ];
    node = [
      nodejs-18_x
    ];
    python = [
      (python311.withPackages (p: with p; [
        bandit
        black
        flake8
        mypy
        pylint
        requests
        types-requests
      ]))
    ];
  };

  env = jacobi.enviro {
    inherit name tools;
  };
in
env
