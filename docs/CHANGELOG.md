# Changelog

## Unreleased

The command line uses the standard `Cli` parser. `--help` prints
`help_text` and `--version` prints `version_text`. An unknown
option exits 2 and writes that help text to stderr. The help and
usage checks expect that text.

The suite gained `test-buffer`, `test-document`, `test-syntax`,
`test-editor`, and `test-window`. It also checks `editor --help`,
`editor --version`, and an unknown option. `test-window` runs under
`xvfb-run`. A normal `build` compiles `bin/editor` and leaves the
test programs unbuilt. `build test` builds `bin/editor` and those
programs, then runs the suite.

`test-document` rejects a Save As whose write fails, and checks
that the previous path and title stay. `test-syntax` checks that a
keyword after a multibyte character is colored at the character
column, not the byte index. `test-window` copies the text view's
selection, which is separate from the editor cursor until the
command reads it.

## 0.0.1

The first editor. It opens files and untitled documents, switches
among them, edits, saves, copies, indents, and undoes. A dirty
document asks before it closes.
