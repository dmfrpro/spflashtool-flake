{
  description = "SP Flash Tool 5/6 for Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      spflashtoolPackages = pkgs.callPackage ./pkgs { };
    in
    {
      packages.${system} = {
        inherit (spflashtoolPackages) spflashtool5 spflashtool6;
        default = spflashtoolPackages.spflashtool6;
      };

      apps.${system} =
        let
          mkApp = name: {
            type = "app";
            program = pkgs.lib.getExe' self.packages.${system}.${name} name;
          };
        in
        {
          spflashtool5 = mkApp "spflashtool5";
          spflashtool6 = mkApp "spflashtool6";
        };

      overlays.default = final: prev: {
        spflashtoolPackages = final.recurseIntoAttrs (final.callPackage ./pkgs { });
        inherit (final.spflashtoolPackages) spflashtool5 spflashtool6;
      };
    };
}
