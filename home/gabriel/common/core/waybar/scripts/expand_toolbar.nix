{
  pkgs ? import <nixpkgs> { },
  ...
}:
pkgs.writeScriptBin "expand_toolbar" ''
  #!/usr/bin/env bash

  LOCK=/tmp/expand_toolbar.lock

  if [ -f "$LOCK" ]; then
      echo expand
      rm -f "$LOCK"
  else
      echo collapse
      touch "$LOCK"
  fi
''
