/**
Copyright: Copyright (c) 2017, Joakim Brännström. All rights reserved.
License: $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0)
Author: Joakim Brännström (joakim.brannstrom@gmx.com)
*/
module integration_test.main;

import std.file : readText;
import std.stdio : writeln;

import plantuml_grammar;

int main(string[] args) {
    static import std.getopt;

    bool help;
    bool output_ast_html;
    bool output_ast_console;
    string in_file;
    string diagram_kind;
    std.getopt.GetoptResult help_info;
    try {
        // dfmt off
        help_info = std.getopt.getopt(args, std.getopt.config.passThrough,
            std.getopt.config.keepEndOfOptions,
            "in", "input file to process", &in_file,
            "ast-html", "write the parsed tree as html5", &output_ast_html,
            "ast-console", "dump the ast to the console", &output_ast_console,
            "kind", "kind of diagram to parse (class)", &diagram_kind,
            );
        // dfmt on
        help = help_info.helpWanted;
    }
    catch (std.getopt.GetOptException ex) {
        // unknown option
        help = true;
    }
    catch (Exception ex) {
        help = true;
    }

    void printHelp() {
        import std.getopt : defaultGetoptPrinter;
        import std.format : format;
        import std.path : baseName;

        defaultGetoptPrinter(format("usage: %s\n", args[0].baseName), help_info.options);
    }

    if (help) {
        printHelp;
        return 0;
    } else if (in_file.length == 0) {
        printHelp;
        writeln("Missing --in");
        return -1;
    } else if (diagram_kind.length == 0) {
        printHelp;
        writeln("Missing --kind");
        return -1;
    }

    ParseTree p;

    switch (diagram_kind) {
    case "class":
        p = PlantUML_ClassDiagram(readText(in_file));
        break;
    default:
        writeln("Unknown --kind: ", diagram_kind);
        return -1;
    }

    dump(p, in_file, output_ast_console, output_ast_html);

    if (!p.successful) {
        if (!output_ast_console)
            writeln(p);
        writeln("Unable to parse: ", in_file);
        return 1;
    }

    return 0;
}

void dump(ref ParseTree p, string in_file, bool output_ast_console, bool output_ast_html) {
    if (output_ast_console) {
        writeln(p);
    }

    if (output_ast_html) {
        import pegged.tohtml;
        import std.path : baseName;

        toHTML(p, in_file.baseName ~ ".html");
    }
}
