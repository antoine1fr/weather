[![Build Status](https://travis-ci.org/antoine1fr/weather.svg?branch=master)](https://travis-ci.org/antoine1fr/weather)

```
 _      __         __  __
| | /| / /__ ___ _/ /_/ /  ___ ____
| |/ |/ / -_) _ `/ __/ _ \/ -_) __/
|__/|__/\__/\_,_/\__/_//_/\__/_/

```

A command-line weather-forecast tool.

## Usage

```
$ weather [PLACE ...]
```

## Dependencies

* [OCaml](http://ocaml.org/) + [Opam](http://opam.ocaml.org/) installation (tested with OCaml 4.01.00 & Opam 1.1.1)
* [Core](https://github.com/janestreet/core)
* [Async](https://github.com/janestreet/async)
* [URI](https://github.com/mirage/ocaml-uri)
* [Cohttp](https://github.com/mirage/ocaml-cohttp)
* [atdgen](https://github.com/mjambon/atdgen)

```
$ opam install uri cohttp atdgen core async
```

## Build

```
$ corebuild -pkgs uri,cohttp.async,atdgen src/weather.native
```
