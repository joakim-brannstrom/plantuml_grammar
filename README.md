# plantuml_grammar [![Build Status](https://travis-ci.org/joakim-brannstrom/plantuml_grammar.svg?branch=master)](https://travis-ci.org/joakim-brannstrom/plantuml_grammar)

**plantuml_grammar** is a library providing the grammar for
[PlantUML](http://plantuml.com/) via
[Pegged](https://github.com/PhilippeSigaud/Pegged)

Currently only the most trivial class diagrams are supported.

**NOTE** The grammar is intended to be good enough, not complete.

# Purpose

The intent of plantuml_grammar is to make it easy to extract relevant
information from a PlantUML diagram that uses a restricted subset of the
official PlantUML features.

To put it in other words the goal is not to be perfect (be able to handle
any kind of PlantUML diagram) but rather a subset that makes it possible to
machine check a diagram for interesting properties.

Why?
It is a lot of work and time to get a complete grammar. I am not even sure if
the official PlantUML grammar is possible to completely express in a PEG
parser.

# Project Goal

Organically grow the grammar on a need-to-parse basis.
Pull requests are welcome :-)

# Getting Started

The following assumes you are using [DUB](https://code.dlang.org/).
See [DUB Registry](https://code.dlang.org/packages/plantuml_grammar) for what
dependency to add to your dub.json/dub.sdl.

Now onto something funnier, a code example.
Lets say you have a PlantUML class diagram that you want to extract all class names from.

```d
void main(string[] args) {
    import std.file;
    import plantuml_grammar;
    // assuming the second argument is the file to parse
    ParseTree p = PlantUML_ClassDiagram(std.file.readText(args[1]));
    printClassName(p);
}

void printClassName(ParseTree p) {
    import std.algorithm;
    import std.stdio;
    switch (p.name) {
    case "PlantUML_ClassDiagram.ClassName":
        writeln("found class: ", p.matches[0]);
        p.children.each!(a => printClassName(a));
        break;
    default:
        p.children.each!(a => printClassName(a));
    }
}
```

# Rebuild the Grammar

When the grammar file is changed it has to be regenerated. To do this run the
following command:
```sh
dub -c generate
```

# Contributing

The code standard is [D-Style](file:///home/joker/sync/dlang/dmd.2/html/d/dstyle.html)
with the modification that local variables and parameters are snake case.

Additions to the grammar need one or more test cases to prove that the
additions work.
These tests are located in test/integration_test/test.d.
For now these tests only test that plantuml_grammar can parse the input. They
do not validate the output. Validation will be added in the future.

Lets say you have modified source/plantuml_grammar_generator/class_diagram.md
and added a new test to test.d.
All you need to do to rebuild the grammar and run the tests with debug output
activated is:
```sh
dub test -- -s -d
```

Yes, it is that simple :)

**Note**: the grammar files uses _.md_ to fool the editors into thinking it is
Markdown. Markdown syntax highlight helps a little bit. It is far from perfect
but better than nothing.

# TODO

The following is a list of improvements that are intended in the immediate future.

 * Add a new module PlantUML_ComponentDiagram containing the grammar for this kind.
 * Extend class diagrams with:
     * the direction inside relations
     * notes
     * the other kind of relations such as relate, association and more

In the far away future.

 * All kind of diagrams.
 * Grammar or helper module to _detect_ the kind of diagram that a file contains.
