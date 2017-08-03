# plantuml_grammar

**plantuml_grammar** is a library providing the grammar for
[PlantUML](http://plantuml.com/) via
[Pegged](https://github.com/PhilippeSigaud/Pegged)

Currently only the most trivial class diagrams are supported.

# Getting Started

To use plantuml_grammar via dub add this to your dub.json:
```json
"dependencies": {
"plantuml_grammar": "~>0.0.1"
}
```

# Rebuild the Grammar

When the grammar file is changed it has to be regenerated. To do this run the
following command:
```sh
dub -c generate
```
