{
  lib,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "subliminal";
  version = "2.2.0";

  pyproject = true;

  src = python3Packages.fetchPypi {
    inherit pname version;
    hash = "sha256-8QM4DR4u8Jt8sZS+/1v0oZSS1fO78zbewDp0UcmSpZM=";
  };

  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    babelfish
    beautifulsoup4
    chardet
    click
    click-option-group
    dogpile-cache
    enzyme
    guessit
    platformdirs
    pysubs2
    rarfile
    requests
    srt
    stevedore
    tomli
  ];

  pythonImportsCheck = [
    "subliminal"
  ];

  meta = {
    description = "Subtitles, faster than your thoughts";
    homepage = "https://github.com/Diaoul/subliminal";
    license = lib.licenses.mit;
    mainProgram = "subliminal";
  };
}
