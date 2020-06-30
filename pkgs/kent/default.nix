{ stdenv
, libpng
, libuuid
, zlib 
, bzip2
, lzma 
, openssl
, curl
, libmysqlclient
, bash
, fetchFromGitHub
, which
}:
stdenv.mkDerivation rec {
  pname = "kent";
  version = "396";

  src = fetchFromGitHub {
    owner = "ucscGenomeBrowser";
    repo = pname;
    rev = "v${version}_base";
    sha256 = "14g5gjq15l488xxl1a9i8ffl5pi1hwxp0yd44mz2bp2gn4fdq9a0";
  };

  buildInputs = [ libpng libuuid zlib bzip2 lzma openssl curl libmysqlclient ];

  postUnpack = ''
    # remove sources of different lisence
    rm -rf ./src/jkOwnLib
  '';

  patchPhase = ''
    substituteInPlace ./src/checkUmask.sh \
      --replace "/bin/bash" "${bash}/bin/bash"
    
    substituteInPlace ./src/hg/sqlEnvTest.sh \
      --replace "which mysql_config" "${which}/bin/which ${libmysqlclient}/bin/mysql_config"
  '';

  buildPhase = ''
    export MACHTYPE=$(uname -m)
    export CFLAGS="-fPIC"
    export MYSQLINC=$(mysql_config --include | sed -e 's/^-I//g')
    export MYSQLLIBS=$(mysql_config --libs)
    export DESTBINDIR=$NIX_BUILD_TOP/bin
    export HOME=$NIX_BUILD_TOP
     
    cd ./src
    chmod +x ./checkUmask.sh
    ./checkUmask.sh

    mkdir -p $NIX_BUILD_TOP/lib
    mkdir -p $NIX_BUILD_TOP/bin/x86_64
    
    make libs
    cd utils
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    cp $NIX_BUILD_TOP/bin/x86_64/* $out/bin
  ''; 

  meta = with stdenv.lib; {
    description = "UCSC Genome Bioinformatics Group's suite of biological analysis tools, i.e. the kent utilities";
    license = licenses.mit;
    maintainers = with maintainers; [ scalavision ];
    platforms = platforms.linux;
  };
}
