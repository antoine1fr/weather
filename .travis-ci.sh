# Edit this for your own project dependencies
OPAM_DEPENDS=""

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
  make
  # make test
}

case "$TRAVIS_OS_NAME" in
  linux) setup_ubuntu_env ;;
  *) echo "Unknown environment: $TRAVIS_OS_NAME"; exit1 ;;
esac
