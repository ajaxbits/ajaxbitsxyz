{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
    in {
      packages.website = pkgs.stdenv.mkDerivation {
        pname = "ajaxbitsxyz";
        version = "";
        src = ./.;
        nativeBuildInputs = [pkgs.zola];
        buildPhase = "zola build";
        installPhase = "cp -r public $out";

        meta = with lib; {
          description = "My website";
          homepage = "https://ajaxbits.xyz";
          changelog = "https://github.com/ajaxbits/ajaxbitsxyz/commits/main";
          licence = licences.agpl3Only;
          maintainers = [
            {
              name = "Alex Jackson";
              email = "contact@ajaxbits.com";
              github = "ajaxbits";
              githubId = 45179933;
              keys = [
                {fingerprint = "ED00BE54AAF8A59F4E409560798DF4ACC8A798B3";}
              ];
            }
          ];
        };
      };
      defaultPackage = self.packages.${system}.website;
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          zola
        ];
      };
    });
}
