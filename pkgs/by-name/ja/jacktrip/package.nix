{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  help2man,
  libjack2,
  dbus,
  qt6,
  meson,
  python3,
  rtaudio,
  ninja,
}:

stdenv.mkDerivation rec {
  version = "2.4.1";
  pname = "jacktrip";

  src = fetchFromGitHub {
    owner = "jacktrip";
    repo = "jacktrip";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-KxpoY7g5oKN2j8rOcFcJf/29xTELxhBn5KBvKB5kL8M=";
  };

  preConfigure = ''
    rm build
  '';

  buildInputs = [
    rtaudio
    qt6.qtbase
    qt6.qtwayland
    libjack2
    dbus
  ];

  nativeBuildInputs = [
    python3
    python3.pkgs.pyaml
    python3.pkgs.jinja2
    ninja
    help2man
    meson
    qt6.qt5compat
    qt6.qtnetworkauth
    qt6.qtwebsockets
    qt6.qtwebengine
    qt6.qtdeclarative
    qt6.qtsvg
    qt6.wrapQtAppsHook
    pkg-config
  ];

  qmakeFlags = [ "jacktrip.pro" ];

  meta = with lib; {
    description = "Multi-machine audio network performance over the Internet";
    mainProgram = "jacktrip";
    homepage = "https://jacktrip.github.io/jacktrip/";
    license = with licenses; [
      gpl3
      lgpl3
      mit
    ];
    maintainers = [ maintainers.iwanb ];
    platforms = platforms.linux;
  };
}
