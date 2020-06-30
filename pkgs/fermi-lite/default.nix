{ stdenv, gcc, zlib, fetchFromGitHub }:

stdenv.mkDerivation {

  name = "fermi-lite";

  src = fetchFromGitHub {
    owner = "lh3";
    repo = "fermi-lite";
    rev = "d468f39457124764a7073dd989583813e3353a10";
    sha256 = "0xxsipxikbvdszw6dffnvnbxaxli97vpc9c81aydh8653jq35gfl";

  };

#  nativeBuildInputs = [ gcc ];

  buildInputs = [ zlib ];

  /*
  preBuild = ''

  '';

  buildPhase = ''
     echo $(pwd)
     make
     ls -hal .
    ./fml-asm test/MT-simu.fq.gz > MT.fq
     mkdir --parents "$out"/bin
     cp ./fml-asm $out/bin
  '';

  installPhase = ''
    echo "Skipping install phase"
  '';
  */

}
