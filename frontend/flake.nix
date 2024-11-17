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
        pname = "JackBlog";
        version = "1.0.0";
        src = ./.;
        projectFile = "JackBlog.csproj";
        dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0_1xx;
        dotnet-runtime = pkgs.dotnetCorePackages.aspnetcore_8_0;
        nugetDeps = ./deps.nix;
        
        # Include static files and configuration
        includeContentFiles = true;
        
        # Ensure wwwroot is copied
        copyWwwRoot = true;
        
        # For framework-dependent ASP.NET Core app
        runtimeDeps = with pkgs; [
          dotnetCorePackages.aspnetcore_8_0
          icu
        ];
        
        # Specify the runtime identifier
        runtime = "linux-x64";

        # Make sure publish is used instead of build
        executables = [ "JackBlog" ];
        
        # Additional build steps if needed
        postBuild = ''
          # Ensure configurations are copied
          cp -r ${./appsettings.json} $out/lib/JackBlog/
          cp -r ${./appsettings.Development.json} $out/lib/JackBlog/
        '';
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          dotnetCorePackages.sdk_8_0_1xx
          dotnetCorePackages.aspnetcore_8_0
          nuget-to-nix
          bat
        ];
      
        shellHook = ''
          echo ".NET SDK $(dotnet --version) activated"
        '';
      };
    }
  );
}
# {
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     utils.url = "github:numtide/flake-utils";
#   };
#   outputs = { self, nixpkgs, utils }: 
#     utils.lib.eachDefaultSystem (system:
#       let
#         pkgs = nixpkgs.legacyPackages.${system};
#       in {
#       packages.default = pkgs.buildDotnetModule {
#         pname = "frontend";
#         version = "1.0.0";
#         src = ./.;
#         projectFile = "frontend.csproj";
#         dotnet-sdk = pkgs.dotnetCorePackages.sdk_7_0_1xx;
#         dotnet-runtime = pkgs.dotnetCorePackages.aspnetcore_7_0;
#           # dotnet-runtime = pkgs.dotnetCorePackages.runtime_8_0;
#         nugetDeps = ./deps.nix;
#         # For framework-dependent ASP.NET Core app
#         runtimeDeps = [
#           pkgs.dotnetCorePackages.aspnetcore_8_0
#         ];
#         runtime = "linux-x64";
#       };
#       devShells.default = pkgs.mkShell {
#         buildInputs = with pkgs; [
#           dotnetCorePackages.sdk_8_0_1xx
#           dotnetCorePackages.aspnetcore_8_0
#           nuget-to-nix
#           bat
#         ];
#       
#         shellHook = ''
#           echo ".NET SDK $(dotnet --version) activated"
#         '';
#       };
#     }
#   );
# }
