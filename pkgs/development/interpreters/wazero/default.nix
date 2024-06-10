{ lib
, buildGoModule
, fetchFromGitHub
, testers
, wazero
}:

buildGoModule rec {
  pname = "wazero";
  version = "1.7.2";

  src = fetchFromGitHub {
    owner = "tetratelabs";
    repo = "wazero";
    rev = "v${version}";
    hash = "sha256-NhwFIN5xLHovbXko6Ki0szwg+MFJdIwJGude4GiSb8A=";
  };

  vendorHash = null;

  subPackages = [
    "cmd/wazero"
  ];

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/tetratelabs/wazero/internal/version.version=${version}"
  ];

  checkFlags = [
    # fails when version is specified
    "-skip=TestCompile|TestRun"
  ];

  passthru.tests = {
    version = testers.testVersion {
      package = wazero;
      command = "wazero version";
    };
  };

  meta = with lib; {
    description = "Zero dependency WebAssembly runtime for Go developers";
    homepage = "https://github.com/tetratelabs/wazero";
    changelog = "https://github.com/tetratelabs/wazero/releases/tag/${src.rev}";
    license = licenses.asl20;
    maintainers = with maintainers; [ figsoda ];
    mainProgram = "wazero";
  };
}
