# Edit this for your own project dependencies
OPAM_DEPENDS=""
OPAM_PACKAGES="cohttp core async uri atdgen"

function setup_opam
{
  export OPAMYES=1
  opam init
  opam install ${OPAM_DEPENDS}
  eval `opam config env`
}

function setup_ubuntu_env
{
  case "$OCAML_VERSION,$OPAM_VERSION" in
    4.01.0,1.1.0) ppa=avsm/ocaml41+opam11 ;;
    *) echo Unknown $OCAML_VERSION,$OPAM_VERSION; exit 1 ;;
  esac

  echo "yes" | sudo add-apt-repository ppa:$ppa
  sudo apt-get update -qq
  sudo apt-get install -qq ocaml ocaml-native-compilers camlp4-extra opam
  setup_opam
  opam install ${OPAM_PACKAGES}
  make
  # make test
}

case "$(uname)" in
  Linux) setup_ubuntu_env ;;
  *) echo "Unknown environment: $TRAVIS_OS_NAME"; exit 1 ;;
esac
