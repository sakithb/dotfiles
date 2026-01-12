{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "authpass";
  version = "1.9.11";
  buildId = "2007";

  src = pkgs.fetchurl {
    url = "https://github.com/authpass/authpass/releases/download/v${version}/authpass-linux-${version}_${buildId}.tar.gz";
    hash = "sha256-x+hPwIZSqdXOF/a8QNVwnRA3m0xoQdEFb44SSGpfyNI=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    wrapGAppsHook3
  ];

  buildInputs = with pkgs; [
    gtk3
    glib
    libepoxy
    xorg.libX11
    libsecret
    jsoncpp
	keybinder3
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/authpass
    cp -r . $out/opt/authpass

    mkdir -p $out/bin
    ln -s $out/opt/authpass/authpass $out/bin/authpass

    install -Dm644 $out/opt/authpass/data/flutter_assets/assets/images/logo_icon.png \
      $out/share/icons/hicolor/512x512/apps/authpass.png

    mkdir -p $out/share/applications
    cat > $out/share/applications/authpass.desktop <<EOF
    [Desktop Entry]
    Name=AuthPass
    Exec=authpass
    Icon=authpass
    Type=Application
    Categories=Utility;Security;
    Comment=AuthPass Password Manager
    EOF

    runHook postInstall
  '';

  preFixup = ''
    addAutoPatchelfSearchPath $out/opt/authpass/lib
  '';

  meta = with pkgs.lib; {
    description = "AuthPass Password Manager";
    homepage = "https://authpass.app/";
    platforms = [ "x86_64-linux" ];
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
  };
}
