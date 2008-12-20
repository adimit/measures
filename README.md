Measures
========

This is a small suite for calculating inter-annotator agreement measures on
linguistic corpora, following the concepts laid out in Artstein & Poesio (2008).

Currently, only two annotators per corpus are supported. The input file format
is: one item per line, tabs separating the item from the two coder's
annotations.

Build Instructions
========

Build like any other cabal package. I.e. either with cabal itself or by running:

    runhaskell Setup.lhs configure --prefix=$HOME/ --user
    runhaskell Setup.lhs build
    runhaskell Setup.lhs install --user

Then run 'measures' using your corpus file as a command line argument.

References
=========
Artstein and Poesio. 2008. <i>Inter-Annotator Agreement</i>. Survey Article
    Computational Linguistics, Volume 34, Number 4

