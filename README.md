# A Generic Programming Library for OCaml

[Documentation](https://balez.github.io/generic/)

# Usage

## Build & Install

```
make
make install
```

## Uninstall

```
make uninstall
```

## Compile & Link with this library

Without PPX syntax extensions

```
ocamlc -c $(ocamlfind query -i-format generic) a.ml
ocamlc -o a.byte $(ocamlfind query -a-format -predicates byte generic) a.cmo
```

With ``reify`` or ``import``

```
ocamlc -c \
  $(ocamlfind query -i-format generic) \
  -ppx $(ocamlfind query generic)/reify \
  -ppx $(ocamlfind query generic)/import \
   a.ml
```
