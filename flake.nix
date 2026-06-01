{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      profiles = {
        work = import ./profiles/work.nix;
        personal = import ./profiles/personal.nix;
      };

      piCodingAgentOverlay =
        _final: prev:
        let
          version = "0.78.0";
          npmDepsHash = "sha256-TxMiT7nJqLZRXKFoxb4FpsETGe3I99qU7olTgNsoQd4=";
          src = prev.fetchFromGitHub {
            owner = "earendil-works";
            repo = "pi";
            tag = "v${version}";
            hash = "sha256-Cw+W5w6yuL+cH+JfgCbEwiyeXloMb7yFd46TXJPZGTg=";
          };
        in
        {
          pi-coding-agent =
            prev.pi-coding-agent.overrideAttrs (old: {
              inherit version src;
              inherit npmDepsHash;
              npmDeps = old.npmDeps.overrideAttrs (_: {
                name = "pi-coding-agent-${version}-npm-deps";
                inherit src;
                hash = npmDepsHash;
                outputHash = npmDepsHash;
              });
              postInstall = ''
                local nm="$out/lib/node_modules/pi-monorepo/node_modules"

                # Replace workspace deps needed at runtime with real copies
                for ws in @earendil-works/pi-ai:packages/ai \
                          @earendil-works/pi-agent-core:packages/agent \
                          @earendil-works/pi-tui:packages/tui; do
                  IFS=: read -r pkg src <<< "$ws"
                  rm "$nm/$pkg"
                  cp -r "$src" "$nm/$pkg"
                done

                # Delete remaining workspace symlinks
                find "$nm" -type l -lname '*/packages/*' -delete

                # Clean up now-dangling .bin symlinks
                find "$nm/.bin" -xtype l -delete

                # Remove foreign Linux binaries that make audit-tmpdir try to inspect ELF
                # RPATHs with patchelf. koffi may be absent in newer Pi releases.
                if [ -d "$nm/koffi/build/koffi" ]; then
                  find "$nm/koffi/build/koffi" -mindepth 1 -maxdepth 1 -type d \
                    ! -name 'darwin_*' -exec rm -r {} +
                fi
                rm -rf \
                  "$nm/@anthropic-ai/sandbox-runtime/dist/vendor/seccomp" \
                  "$nm/@anthropic-ai/sandbox-runtime/vendor/seccomp"
              '';
            });
        };
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ piCodingAgentOverlay ];
        };

      mkHomeConfiguration =
        profile:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs profile.system;

          modules = [ ./home.nix ];

          extraSpecialArgs = {
            inherit profile;
          };
        };
    in
    {
      homeConfigurations = {
        work-mac = mkHomeConfiguration profiles.work;
        personal-mac = mkHomeConfiguration profiles.personal;
      };
    };
}
