{
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "mondwest";
  dontConfigue = true;
  dontUnpack = true;
  # phases = "installPhase"; # Removes all phases except installPhase
  src = ../fonts/PPMondwest-Regular.otf;
  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -R $src $out/share/fonts/opentype/
  '';
  meta = {
    description = "A MondWest Font Family derivation.";
  };
})
