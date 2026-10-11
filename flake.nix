{
  description = "HL2 Skate — skateboarding mod for Half-Life 2 (Source SDK 2013)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Source SDK 2013 source, pinned so the mod builds against a known tree.
    # `flake = false` — fetched as a plain source snapshot (not a flake).
    sdk = {
      url = "github:ValveSoftware/source-sdk-2013";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, sdk }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.podman        # SDK's buildallprojects expects podman
          pkgs.docker        # fallback / daemon already on the host
        ];

        # Expose the pinned SDK source so scripts can stage the mod into it.
        SDK_SRC = "${sdk}";

        shellHook = ''
          echo "hl2-skate: podman/docker + SDK source ready"
          echo "SDK source: $SDK_SRC"
          echo "stage mod into SDK:  ./setup.sh"
        '';
      };
    };
}
