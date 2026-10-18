# spflashtool-flake

SP Flash Tool 5 and 6 packaged for Nix

## Run without installing

```sh
nix run github:dmfrpro/spflashtool-flake#spflashtool5
nix run github:dmfrpro/spflashtool-flake#spflashtool6
```

## Add to your NixOS / home-manager configuration

Add the flake as an input in `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spflashtool = {
      url = "github:dmfrpro/spflashtool-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

Then either use the overlay:

```nix
nixpkgs.overlays = [ inputs.spflashtool.overlays.default ];
environment.systemPackages = with pkgs; [
  spflashtool5
  spflashtool6
];
```

or install the package directly:

```nix
environment.systemPackages = with inputs.spflashtool.packages.x86_64-linux; [
  spflashtool5
  spflashtool6
];
```
