# Converted from https://blog.ryanyuan.top
{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "hei-cursors";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "xxn1001";
    repo = "hei-cursors";
    rev = "cd84d066ef0b390402fec82eb9d6fabe0eea09a6";
    sha256 = "sha256-Oj2Iz95N86f7cxUEMnO4rcnHUyoOaWis57Z+EiEHtdg=";
  };

  installPhase = "
    mkdir -p $out/share/icons/hei
    cp -r * $out/share/icons/hei
    ";

  meta = {
    description = "Hei cursor theme";
    homepage = "https://github.com/xxn1001/hei-cursors";
  };
}

