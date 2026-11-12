let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    packages = [
		(pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
			beautifulsoup4
		]))
	];
    buildInputs = with pkgs; [
	  (texlive.combined.scheme-medium.withPackages (ps: with ps; [ csquotes datetime2 ]))
	  perl5Packages.LaTeXML
    ];
  }
