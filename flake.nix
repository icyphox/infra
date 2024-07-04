{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs =
    { self
    , nixpkgs
    ,
    }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
          fsrv = self.packages.${system}.fsrv;
          files = pkgs.lib.fileset.toSource {
            root = ./.;
            fileset = pkgs.lib.fileset.unions [
              ./index.html
            ];
          };
        in
        {
          yarrContainer = pkgs.dockerTools.buildLayeredImage {
            name = "sini:5000/yarr";
            tag = "latest";
            contents = [
              pkgs.yarr
            ];
            config = {
              Entrypoint = [ "${pkgs.yarr}/bin/yarr" ];
              ExposedPorts = { "7070/tcp" = { }; };
            };
          };
        });

      defaultPackage = forAllSystems (system: self.packages.${system}.fsrv);
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              kubectl
              kubectx
              go
            ];
          };
        });
    };
}
