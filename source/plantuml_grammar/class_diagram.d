/++
This module was automatically generated from the following grammar:

PlantUML_ClassDiagram:
    UML             <- blank* "@startuml" eol Content* "@enduml" (blank* / eoi)

    Content         <   / Class
                        / Comment
                        / Inherit

    Class           <- "class" space+ ClassName blank* ClassBody?
    ClassName       <- identifier
    ClassBody       <  '{' (Class / ~(ClassContent*))* '}'
    ClassContent    <- !Class !'}' .

    Inherit         <  InheritRight / InheritLeft
    InheritRight    <  RelateIdFrom :('-'+ "|>") RelateIdTo
    InheritLeft     <  RelateIdTo :("<|" '-'+) RelateIdFrom

    RelateIdFrom    <- identifier
    RelateIdTo      <- identifier

    Comment         <- space* :'\'' ~((!eol .)*) :eol


+/
module plantuml_grammar.class_diagram;

public import pegged.peg;
import std.algorithm: startsWith;
import std.functional: toDelegate;

struct GenericPlantUML_ClassDiagram(TParseTree)
{
    import std.functional : toDelegate;
    import pegged.dynamic.grammar;
    static import pegged.peg;
    struct PlantUML_ClassDiagram
    {
    enum name = "PlantUML_ClassDiagram";
    static ParseTree delegate(ParseTree)[string] before;
    static ParseTree delegate(ParseTree)[string] after;
    static ParseTree delegate(ParseTree)[string] rules;
    import std.typecons:Tuple, tuple;
    static TParseTree[Tuple!(string, size_t)] memo;
    static this()
    {
        rules["UML"] = toDelegate(&UML);
        rules["Content"] = toDelegate(&Content);
        rules["Class"] = toDelegate(&Class);
        rules["ClassName"] = toDelegate(&ClassName);
        rules["ClassBody"] = toDelegate(&ClassBody);
        rules["ClassContent"] = toDelegate(&ClassContent);
        rules["Inherit"] = toDelegate(&Inherit);
        rules["InheritRight"] = toDelegate(&InheritRight);
        rules["InheritLeft"] = toDelegate(&InheritLeft);
        rules["RelateIdFrom"] = toDelegate(&RelateIdFrom);
        rules["RelateIdTo"] = toDelegate(&RelateIdTo);
        rules["Comment"] = toDelegate(&Comment);
        rules["Spacing"] = toDelegate(&Spacing);
    }

    template hooked(alias r, string name)
    {
        static ParseTree hooked(ParseTree p)
        {
            ParseTree result;

            if (name in before)
            {
                result = before[name](p);
                if (result.successful)
                    return result;
            }

            result = r(p);
            if (result.successful || name !in after)
                return result;

            result = after[name](p);
            return result;
        }

        static ParseTree hooked(string input)
        {
            return hooked!(r, name)(ParseTree("",false,[],input));
        }
    }

    static void addRuleBefore(string parentRule, string ruleSyntax)
    {
        // enum name is the current grammar name
        DynamicGrammar dg = pegged.dynamic.grammar.grammar(name ~ ": " ~ ruleSyntax, rules);
        foreach(ruleName,rule; dg.rules)
            if (ruleName != "Spacing") // Keep the local Spacing rule, do not overwrite it
                rules[ruleName] = rule;
        before[parentRule] = rules[dg.startingRule];
    }

    static void addRuleAfter(string parentRule, string ruleSyntax)
    {
        // enum name is the current grammar named
        DynamicGrammar dg = pegged.dynamic.grammar.grammar(name ~ ": " ~ ruleSyntax, rules);
        foreach(name,rule; dg.rules)
        {
            if (name != "Spacing")
                rules[name] = rule;
        }
        after[parentRule] = rules[dg.startingRule];
    }

    static bool isRule(string s)
    {
		import std.algorithm : startsWith;
        return s.startsWith("PlantUML_ClassDiagram.");
    }
    mixin decimateTree;

    alias spacing Spacing;

    static TParseTree UML(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(blank), pegged.peg.literal!("@startuml"), eol, pegged.peg.zeroOrMore!(Content), pegged.peg.literal!("@enduml"), pegged.peg.or!(pegged.peg.zeroOrMore!(blank), eoi)), "PlantUML_ClassDiagram.UML")(p);
        }
        else
        {
            if (auto m = tuple(`UML`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(blank), pegged.peg.literal!("@startuml"), eol, pegged.peg.zeroOrMore!(Content), pegged.peg.literal!("@enduml"), pegged.peg.or!(pegged.peg.zeroOrMore!(blank), eoi)), "PlantUML_ClassDiagram.UML"), "UML")(p);
                memo[tuple(`UML`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree UML(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(blank), pegged.peg.literal!("@startuml"), eol, pegged.peg.zeroOrMore!(Content), pegged.peg.literal!("@enduml"), pegged.peg.or!(pegged.peg.zeroOrMore!(blank), eoi)), "PlantUML_ClassDiagram.UML")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(blank), pegged.peg.literal!("@startuml"), eol, pegged.peg.zeroOrMore!(Content), pegged.peg.literal!("@enduml"), pegged.peg.or!(pegged.peg.zeroOrMore!(blank), eoi)), "PlantUML_ClassDiagram.UML"), "UML")(TParseTree("", false,[], s));
        }
    }
    static string UML(GetName g)
    {
        return "PlantUML_ClassDiagram.UML";
    }

    static TParseTree Content(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.wrapAround!(Spacing, Comment, Spacing), pegged.peg.wrapAround!(Spacing, Inherit, Spacing)), "PlantUML_ClassDiagram.Content")(p);
        }
        else
        {
            if (auto m = tuple(`Content`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.wrapAround!(Spacing, Comment, Spacing), pegged.peg.wrapAround!(Spacing, Inherit, Spacing)), "PlantUML_ClassDiagram.Content"), "Content")(p);
                memo[tuple(`Content`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Content(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.wrapAround!(Spacing, Comment, Spacing), pegged.peg.wrapAround!(Spacing, Inherit, Spacing)), "PlantUML_ClassDiagram.Content")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.wrapAround!(Spacing, Comment, Spacing), pegged.peg.wrapAround!(Spacing, Inherit, Spacing)), "PlantUML_ClassDiagram.Content"), "Content")(TParseTree("", false,[], s));
        }
    }
    static string Content(GetName g)
    {
        return "PlantUML_ClassDiagram.Content";
    }

    static TParseTree Class(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("class"), pegged.peg.oneOrMore!(space), ClassName, pegged.peg.zeroOrMore!(blank), pegged.peg.option!(ClassBody)), "PlantUML_ClassDiagram.Class")(p);
        }
        else
        {
            if (auto m = tuple(`Class`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("class"), pegged.peg.oneOrMore!(space), ClassName, pegged.peg.zeroOrMore!(blank), pegged.peg.option!(ClassBody)), "PlantUML_ClassDiagram.Class"), "Class")(p);
                memo[tuple(`Class`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Class(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("class"), pegged.peg.oneOrMore!(space), ClassName, pegged.peg.zeroOrMore!(blank), pegged.peg.option!(ClassBody)), "PlantUML_ClassDiagram.Class")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.literal!("class"), pegged.peg.oneOrMore!(space), ClassName, pegged.peg.zeroOrMore!(blank), pegged.peg.option!(ClassBody)), "PlantUML_ClassDiagram.Class"), "Class")(TParseTree("", false,[], s));
        }
    }
    static string Class(GetName g)
    {
        return "PlantUML_ClassDiagram.Class";
    }

    static TParseTree ClassName(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.ClassName")(p);
        }
        else
        {
            if (auto m = tuple(`ClassName`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.ClassName"), "ClassName")(p);
                memo[tuple(`ClassName`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ClassName(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.ClassName")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.ClassName"), "ClassName")(TParseTree("", false,[], s));
        }
    }
    static string ClassName(GetName g)
    {
        return "PlantUML_ClassDiagram.ClassName";
    }

    static TParseTree ClassBody(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.fuse!(pegged.peg.wrapAround!(Spacing, pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, ClassContent, Spacing)), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), "PlantUML_ClassDiagram.ClassBody")(p);
        }
        else
        {
            if (auto m = tuple(`ClassBody`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.fuse!(pegged.peg.wrapAround!(Spacing, pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, ClassContent, Spacing)), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), "PlantUML_ClassDiagram.ClassBody"), "ClassBody")(p);
                memo[tuple(`ClassBody`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ClassBody(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.fuse!(pegged.peg.wrapAround!(Spacing, pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, ClassContent, Spacing)), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), "PlantUML_ClassDiagram.ClassBody")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("{"), Spacing), pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.or!(pegged.peg.wrapAround!(Spacing, Class, Spacing), pegged.peg.fuse!(pegged.peg.wrapAround!(Spacing, pegged.peg.zeroOrMore!(pegged.peg.wrapAround!(Spacing, ClassContent, Spacing)), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("}"), Spacing)), "PlantUML_ClassDiagram.ClassBody"), "ClassBody")(TParseTree("", false,[], s));
        }
    }
    static string ClassBody(GetName g)
    {
        return "PlantUML_ClassDiagram.ClassBody";
    }

    static TParseTree ClassContent(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.negLookahead!(Class), pegged.peg.negLookahead!(pegged.peg.literal!("}")), pegged.peg.any), "PlantUML_ClassDiagram.ClassContent")(p);
        }
        else
        {
            if (auto m = tuple(`ClassContent`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.negLookahead!(Class), pegged.peg.negLookahead!(pegged.peg.literal!("}")), pegged.peg.any), "PlantUML_ClassDiagram.ClassContent"), "ClassContent")(p);
                memo[tuple(`ClassContent`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree ClassContent(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.negLookahead!(Class), pegged.peg.negLookahead!(pegged.peg.literal!("}")), pegged.peg.any), "PlantUML_ClassDiagram.ClassContent")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.negLookahead!(Class), pegged.peg.negLookahead!(pegged.peg.literal!("}")), pegged.peg.any), "PlantUML_ClassDiagram.ClassContent"), "ClassContent")(TParseTree("", false,[], s));
        }
    }
    static string ClassContent(GetName g)
    {
        return "PlantUML_ClassDiagram.ClassContent";
    }

    static TParseTree Inherit(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, InheritRight, Spacing), pegged.peg.wrapAround!(Spacing, InheritLeft, Spacing)), "PlantUML_ClassDiagram.Inherit")(p);
        }
        else
        {
            if (auto m = tuple(`Inherit`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, InheritRight, Spacing), pegged.peg.wrapAround!(Spacing, InheritLeft, Spacing)), "PlantUML_ClassDiagram.Inherit"), "Inherit")(p);
                memo[tuple(`Inherit`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Inherit(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, InheritRight, Spacing), pegged.peg.wrapAround!(Spacing, InheritLeft, Spacing)), "PlantUML_ClassDiagram.Inherit")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.or!(pegged.peg.wrapAround!(Spacing, InheritRight, Spacing), pegged.peg.wrapAround!(Spacing, InheritLeft, Spacing)), "PlantUML_ClassDiagram.Inherit"), "Inherit")(TParseTree("", false,[], s));
        }
    }
    static string Inherit(GetName g)
    {
        return "PlantUML_ClassDiagram.Inherit";
    }

    static TParseTree InheritRight(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("|>"), Spacing)), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing)), "PlantUML_ClassDiagram.InheritRight")(p);
        }
        else
        {
            if (auto m = tuple(`InheritRight`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("|>"), Spacing)), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing)), "PlantUML_ClassDiagram.InheritRight"), "InheritRight")(p);
                memo[tuple(`InheritRight`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree InheritRight(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("|>"), Spacing)), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing)), "PlantUML_ClassDiagram.InheritRight")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing)), pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("|>"), Spacing)), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing)), "PlantUML_ClassDiagram.InheritRight"), "InheritRight")(TParseTree("", false,[], s));
        }
    }
    static string InheritRight(GetName g)
    {
        return "PlantUML_ClassDiagram.InheritRight";
    }

    static TParseTree InheritLeft(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("<|"), Spacing), pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing)), "PlantUML_ClassDiagram.InheritLeft")(p);
        }
        else
        {
            if (auto m = tuple(`InheritLeft`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("<|"), Spacing), pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing)), "PlantUML_ClassDiagram.InheritLeft"), "InheritLeft")(p);
                memo[tuple(`InheritLeft`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree InheritLeft(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("<|"), Spacing), pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing)), "PlantUML_ClassDiagram.InheritLeft")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.wrapAround!(Spacing, RelateIdTo, Spacing), pegged.peg.discard!(pegged.peg.wrapAround!(Spacing, pegged.peg.and!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("<|"), Spacing), pegged.peg.oneOrMore!(pegged.peg.wrapAround!(Spacing, pegged.peg.literal!("-"), Spacing))), Spacing)), pegged.peg.wrapAround!(Spacing, RelateIdFrom, Spacing)), "PlantUML_ClassDiagram.InheritLeft"), "InheritLeft")(TParseTree("", false,[], s));
        }
    }
    static string InheritLeft(GetName g)
    {
        return "PlantUML_ClassDiagram.InheritLeft";
    }

    static TParseTree RelateIdFrom(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdFrom")(p);
        }
        else
        {
            if (auto m = tuple(`RelateIdFrom`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdFrom"), "RelateIdFrom")(p);
                memo[tuple(`RelateIdFrom`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree RelateIdFrom(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdFrom")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdFrom"), "RelateIdFrom")(TParseTree("", false,[], s));
        }
    }
    static string RelateIdFrom(GetName g)
    {
        return "PlantUML_ClassDiagram.RelateIdFrom";
    }

    static TParseTree RelateIdTo(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdTo")(p);
        }
        else
        {
            if (auto m = tuple(`RelateIdTo`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdTo"), "RelateIdTo")(p);
                memo[tuple(`RelateIdTo`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree RelateIdTo(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdTo")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(identifier, "PlantUML_ClassDiagram.RelateIdTo"), "RelateIdTo")(TParseTree("", false,[], s));
        }
    }
    static string RelateIdTo(GetName g)
    {
        return "PlantUML_ClassDiagram.RelateIdTo";
    }

    static TParseTree Comment(TParseTree p)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(space), pegged.peg.discard!(pegged.peg.literal!("\'")), pegged.peg.fuse!(pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any))), pegged.peg.discard!(eol)), "PlantUML_ClassDiagram.Comment")(p);
        }
        else
        {
            if (auto m = tuple(`Comment`, p.end) in memo)
                return *m;
            else
            {
                TParseTree result = hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(space), pegged.peg.discard!(pegged.peg.literal!("\'")), pegged.peg.fuse!(pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any))), pegged.peg.discard!(eol)), "PlantUML_ClassDiagram.Comment"), "Comment")(p);
                memo[tuple(`Comment`, p.end)] = result;
                return result;
            }
        }
    }

    static TParseTree Comment(string s)
    {
        if(__ctfe)
        {
            return         pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(space), pegged.peg.discard!(pegged.peg.literal!("\'")), pegged.peg.fuse!(pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any))), pegged.peg.discard!(eol)), "PlantUML_ClassDiagram.Comment")(TParseTree("", false,[], s));
        }
        else
        {
            forgetMemo();
            return hooked!(pegged.peg.defined!(pegged.peg.and!(pegged.peg.zeroOrMore!(space), pegged.peg.discard!(pegged.peg.literal!("\'")), pegged.peg.fuse!(pegged.peg.zeroOrMore!(pegged.peg.and!(pegged.peg.negLookahead!(eol), pegged.peg.any))), pegged.peg.discard!(eol)), "PlantUML_ClassDiagram.Comment"), "Comment")(TParseTree("", false,[], s));
        }
    }
    static string Comment(GetName g)
    {
        return "PlantUML_ClassDiagram.Comment";
    }

    static TParseTree opCall(TParseTree p)
    {
        TParseTree result = decimateTree(UML(p));
        result.children = [result];
        result.name = "PlantUML_ClassDiagram";
        return result;
    }

    static TParseTree opCall(string input)
    {
        if(__ctfe)
        {
            return PlantUML_ClassDiagram(TParseTree(``, false, [], input, 0, 0));
        }
        else
        {
            forgetMemo();
            return PlantUML_ClassDiagram(TParseTree(``, false, [], input, 0, 0));
        }
    }
    static string opCall(GetName g)
    {
        return "PlantUML_ClassDiagram";
    }


    static void forgetMemo()
    {
        memo = null;
    }
    }
}

alias GenericPlantUML_ClassDiagram!(ParseTree).PlantUML_ClassDiagram PlantUML_ClassDiagram;

