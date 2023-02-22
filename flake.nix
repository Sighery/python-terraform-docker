{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      with import nixpkgs { system = "x86_64-linux"; };
      pkgs.dockerTools.buildLayeredImage {
        name = "sighery/python-terraform";
        tag = "latest";
        created = "now";

        contents = [ pkgs.python39 pkgs.python39Packages.pip terraform ];

        config.Cmd = [ "${terraform}/bin/terraform" ];
      };
  };
}
