# editor

`editor` edits text files. It opens several files and untitled
documents, switches between them, and saves them. Syntax coloring
covers scpp. The buffer keeps undo and redo.

Build, test, and install it with the scripts in the root `README.md`.
Do not run `cmake` yourself. `scripts/setup`, then `build`, then
`install`, then `bin/editor`. `install` copies `bin/editor` to
`bin/editor` under the prefix. A fresh configuration uses
`$HOME/opt/smallcpp`. `install /absolute/path` selects that prefix
for one run. A normal `build` compiles the editor and leaves the
test programs unbuilt. `build test` builds those programs and runs
the unit tests. The window test runs under `xvfb-run`. The other
tests do not open a window.

## Starting

```text
editor [file]...
editor --help
editor --version
```

`--help` and `--version` exit 0. Help and the version line come
from the standard `Cli` parser. `--help` prints `help_text`.
`--version` prints `version_text`, `editor: v0.0.1`. An unknown
option exits 2 and writes that same help text to stderr. Each
file argument opens
as a document. A directory is refused with `not a file`. A file
that contains a NUL byte or invalid UTF-8 is refused with
`not a text file`, and the documents already open stay as they
were. Files larger than 32 MiB are refused. With no path, a new
`untitled.scpp` buffer is shown. Opening a path that is already
open focuses that document.

## Window

The window has File and Edit menus, document tabs, and a status
line. The status line shows the title, a dirty star, the line, the
column, and the language.

File covers New, Open, Save, Save As, Save All, Close, Settings,
and Quit. Open starts in the process current directory. Save
writes the active named document. An untitled document asks for
a path.
Save As refuses a path that belongs to another open document,
and it asks before replacing a file that already exists.
A failed Save As leaves the previous path and title in place. Save
All writes modified named documents and skips untitled ones. Only
Quit and the window close button leave the program. A dirty
document asks Save, Discard, or Cancel. Cancel leaves it open.
Discard drops it. The last document, when closed, is replaced by
a fresh untitled buffer.

Edit covers Undo, Redo, Cut, Copy, Paste, Indent, and Unindent.
Copy and cut read the selection in the text view. Indent and
unindent use a width of four spaces. Undo and redo walk the editor
buffer, including a change typed in the view.

The text view is monospace and shows line numbers in a gutter.
Tags color scpp keywords, strings, comments, and numbers. A span
is painted at its character column, so a multibyte character does
not shift a later color. Undo and redo put the caret back on the
edited spot and scroll that spot into view.

Keys: Ctrl+O opens, Ctrl+S saves, Ctrl+Shift+S saves as,
Ctrl+Shift+L saves all, Ctrl+Z undoes, Ctrl+Shift+Z and Ctrl+Y
redo, Ctrl+X cuts, Ctrl+C copies, Ctrl+V pastes, Ctrl+] indents,
and Ctrl+[ unindents. Settings toggles closing brackets and
indenting a new line. Those apply to every open document and to
the next one.
