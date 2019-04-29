### RacketDoc

An experimental tool to automatically generate Racket scribble documentation from a given code base directory. Given a configuration file that looks like the following:

```
source-dir:/home/caner/pycketland/pycket/pycket/
extension:py
doctag:pycketdoc
block:"""
scribble-out-dir:/home/caner/pycketland/pycket/
main-scrbl-file:main.scrbl
title:Pycket
```

RacketDoc will traverse the `source-dir` and look inside the files with `.extension` to look for `block`s starting with `doctag`, and automatically generate scribble docs from those blocks, and put the `.scrbl` files inside the `scribble-out-dir`.

The blocks don't have a format yet. Also, instead of having a static format I'm leaning towards getting a block template from the user via the `config` file and process the blocks accordingly. However, again, at this initial stage the blocks are gonna be treated as just chunks of texts that'll be pasted in the scribble.

The implementation is at its very early stage, so it's not usable yet.