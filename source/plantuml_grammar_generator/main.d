/**
Copyright: Copyright (c) 2017, Joakim Brännström. All rights reserved.
License: $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0)
Author: Joakim Brännström (joakim.brannstrom@gmx.com)
*/
module plantuml_grammar_generator.main;

enum classDiagram = import("class_diagram.md");

void main(string[] args) {
    import pegged.grammar;

    // dfmt off
    asModule("plantuml_grammar.class_diagram",
        "source/plantuml_grammar/class_diagram",
        classDiagram
        );
    // dfmt on
}
