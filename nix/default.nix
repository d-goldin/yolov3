self: super:

rec {
  python37 = super.python37.override {
     packageOverrides = py-self: py-super: {
       pytorch = py-self.callPackage ./pytorch.nix {
         cudaSupport = true;
         cudnn = super.cudnn_cudatoolkit_10;
         cudatoolkit = super.cudatoolkit_10;
       };
       torchvision = (py-self.callPackage ./torchvision.nix {
       }).overrideAttrs (old: { FORCE_CUDA=1; CUDA_HOME="${super.cudatoolkit_10}"; });
     };
   };

   python37Packages = python37.pkgs;
 }
