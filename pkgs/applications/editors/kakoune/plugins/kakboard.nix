{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "kakboard";
  version = "2020-05-09";

  src = fetchFromGitHub {
    owner = "lePerdu";
    repo = "kakboard";
    rev = "2f13f5cd99591b76ad5cba230815b80138825120";
    sha256 = "1kvnbsv20y09rlnyar87qr0h26i16qsq801krswvxcwhid7ijlvd";
  };

  installPhase = ''
    mkdir -p $out/bin $out/share/kak/autoload/plugins/
    cp kakboard.kak $out/share/kak/autoload/plugins/
  '';

  meta = with stdenv.lib; {
    description = "Clipboard integration for kakoune";
    homepage = "https://github.com/lePerdu/kakboard";
    license = licenses.mit;
    maintainers = with maintainers; [ loewenheim ];
    platforms = platforms.all;
  };
}
