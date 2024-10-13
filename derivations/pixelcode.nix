{
  stdenvNoCC,
  pkgs,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "pixelcode";
  dontConfigue = true;
  src = ../fonts/pixelcode.zip;

  unpackPhase = ''
    ${pkgs.unzip}/bin/unzip $src
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -r ./otf/*.otf $out/share/fonts/opentype
  '';

  meta = {
    description = "A pixel code Font Family derivation.";
    homepage = "https://github.com/qwerasd205/PixelCode/releases/tag/v2.2";
  };
})
