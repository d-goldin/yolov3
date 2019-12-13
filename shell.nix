let
  nixpkgs = import (fetchTarball {
    url = "https://github.com/nixos/nixpkgs/tarball/7e93638ca77c87d0441e57ec044d4da58077b4e4";
    sha256 = "03bg5sqkhlgmb9zanbp6d7him7w5kaani5fkhq3x4kknhl76xzpk";
  }) {
      overlays = [
        (import ./nix)
      ];
      config.allowUnfree = true;
    };

in nixpkgs.stdenv.mkDerivation {
  name = "yolov3-testbed";

  buildInputs = with nixpkgs; with python37Packages; [
    cudatoolkit
    pytorch
    torchvision
    matplotlib
    numpy
    opencv4
    pillow
    tqdm
    python37Full
    ipython
  ];
}
