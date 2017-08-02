/**
Copyright: Copyright (c) 2017, Joakim Brännström. All rights reserved.
License: $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0)
Author: Joakim Brännström (joakim.brannstrom@gmx.com)
*/
module plantuml_grammar.test;

import std.stdio : writeln;
import std.string : join;

import unit_threaded;

@("shall be a standalone class definition")
unittest {
    parseClassDiagram("test_data/class/basic.pu").status.shouldEqual(0);
}

@("shall be a class with a body")
unittest {
    parseClassDiagram("test_data/class/basic_with_body.pu").status.shouldEqual(0);
}

@("shall be comments")
unittest {
    parseClassDiagram("test_data/comment.pu").status.shouldEqual(0);
}

@("shall be relations between two identifiers of kind inherit")
unittest {
    parseClassDiagram("test_data/class/inherit.pu").status.shouldEqual(0);
}

auto run(ARGS...)(auto ref ARGS args_) {
    import std.process : execute;

    string[] args;
    foreach (a; args_) {
        args ~= a;
    }

    writeln("run: ", args.join(" "));

    return execute(args);
}

auto parseClassDiagram(string input_file) {
    auto res = run("build/test-plantuml_grammar", "--kind", "class", "--in", input_file);

    if (res.status != 0) {
        writeln(res.output);
    }

    return res;
}
