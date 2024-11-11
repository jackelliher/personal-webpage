{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: 
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
      packages.default = pkgs.buildDotnetModule {
        pname = "frontend";
        version = "1.0.0";
        src = ./.;
        projectFile = "frontend.csproj";
        dotnet-sdk = pkgs.dotnet-sdk_8;
        dotnet-runtime = pkgs.dotnet-runtime_8;
        nugetDeps = ./deps.nix;
        selfContainedBuild = true;
        runtime = "linux-x64";
      };
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          dotnet-sdk_8
          nuget-to-nix
        ];
      
        shellHook = ''
          echo ".NET SDK $(dotnet --version) activated"
        '';
      };
    }
  );
}
