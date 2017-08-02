/**
Copyright: Copyright (c) 2017, Joakim Brännström. All rights reserved.
License: $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0)
Author: Joakim Brännström (joakim.brannstrom@gmx.com)
*/
module plantuml_grammar.integration_test.test_runner;

import unit_threaded;

int main(string[] args) {
    import std.stdio : writeln;
    import unit_threaded.runner;

    writeln("Running unit tests");
    //dfmt off
    return args.runTests!(
                          "plantuml_grammar.test",
                          );
    //dfmt on
}
