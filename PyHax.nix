(final: prev: with prev; {

  speech_recognition = buildPythonPackage rec {
    pname = "SpeechRecognition";
    version = "3.10.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "";
    };
    pythonImportsCheck = [ "SpeechRecognition" ];

    meta = {
      description = "Library for performing speech recognition, with support for several engines and APIs, online and offline.";
      homepage = "https://github.com/Uberi/speech_recognition";
    };
  };

})
