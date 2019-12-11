{ buildPythonPackage
, fetchFromGitHub
, six
, numpy
, pillow
, pytorch
, lib
, which
, nose
, scipy
, mock
}:

buildPythonPackage rec {
  version = "0.4.2";
  pname   = "torchvision";

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = "vision";
    rev = "v${version}";
    sha256 = "0xzn9qm55z8gjs5r1irxyfh5402hczzc34fyfhlzpzkhd59fcz7m";
  };

  nativeBuildInputs = [ which ];
  checkInputs = [ nose mock ];

  propagatedBuildInputs = [ six numpy pillow pytorch scipy ];

  # A bunch of tests fail because they can't import the _C module, which is likely
  # due because it's importing the wrong path for the tests
  doCheck = false;
  checkPhase = ''
    nosetests test
  '';

  meta = {
    description = "PyTorch vision library";
    homepage    = https://pytorch.org/;
    license     = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ericsagnes ];
  };
}
