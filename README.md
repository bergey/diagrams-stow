This repository has several files which I find useful for developing
on [diagrams](http://github.com/diagrams/).  I check out this repo as
the directory where I keep the diagrams code, and run
[stow](http://www.gnu.org/software/stow/) on each subdir to put
symlinks in the appropriate locations.

# mr

The mr directory has a `.mrconfig` which informs
[mr](https://github.com/joeyh/myrepos) of all the Diagrams repos.
Running `mr update` will checkout them all, `mr run git checkout
master` will switch to the master branch, and so forth.  This is a
much larger set of repos than the mrconfig provided
[on the wiki](http://www.haskell.org/haskellwiki/Diagrams/Contributing#Getting_the_code).
This one includes everything that I consider to be collectively
maintained by the Diagrams team.  Packages with names `diagrams-*`
have the `diagrams-` prefix removed from the directory name.

# packdeps

[packdeps](http://hackage.haskell.org/package/packdeps) is a helpful
script that checks that upper bounds in a cabal file do not prevent
using the latest released version.  The shell script here runs
packdeps on most of the Diagrams packages.

# stack

[stack](http://docs.haskellstack.org/en/stable/README.html) files for
the Diagrams packages.  Each includes dependencies that are part of
the Diagrams umbrela from local git repos.  The directory layout is
the same as in the mr config in this repo.
