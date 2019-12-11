let
  # NOTE: Should point to master on nixpkgs
  nixpkgs = import ../nixpkgs
    {
      overlays = [
        (import ./nix)
      ];
      config.allowUnfree = true;
    };

in nixpkgs.python37Packages.buildPythonPackage {
  name = "yolov3";
  src = "./.";
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
  ];
}
