{
  lib,
  stdenv,
  fetchzip,
  fpc,
  lang ? "en",
}:

assert lib.assertOneOf "lang" lang [
  "cn"
  "de"
  "en"
  "fr"
  "tr"
];

stdenv.mkDerivation rec {
  pname = "gavrasm";
  version = "5.4";
  flatVersion = lib.strings.replaceStrings [ "." ] [ "" ] version;

  src = fetchzip {
    url = "http://www.avr-asm-tutorial.net/gavrasm/v${flatVersion}/gavrasm_sources_lin_${flatVersion}.zip";
    sha256 = "sha256-uTalb8Wzn2RAoUKZx9RZFCX+V9HUEtUnJ4eSltFumh0=";
    stripRoot = false;
  };

  nativeBuildInputs = [ fpc ];

  configurePhase = ''
    runHook preConfigure
    cp gavrlang_${lang}.pas gavrlang.pas
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    fpc gavrasm.pas
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp gavrasm $out/bin
    mkdir -p $out/doc
    cp instr.asm $out/doc
    cp ReadMe.Txt $out/doc
    cp LiesMich.Txt $out/doc
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "http://www.avr-asm-tutorial.net/gavrasm/";
    description = "AVR Assembler for ATMEL AVR-Processors";
    license = licenses.unfree;
    maintainers = with maintainers; [ mafo ];
    platforms = platforms.linux;
  };
}
