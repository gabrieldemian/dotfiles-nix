{ stdenvNoCC, ... }:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "neuebit";
  dontConfigue = true;
  dontUnpack = true;
  # phases = "installPhase"; # Removes all phases except installPhase
  src = ../fonts/PPNeueBit-Bold.otf;
  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -R $src $out/share/fonts/opentype/
  '';
  meta = {
    description = "A Neuebit Font Family derivation.";
  };
})
