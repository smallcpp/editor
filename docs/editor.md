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

The window has File, Edit, and Documents menus, document tabs,
and a status line. The status line shows the title, a dirty star,
the line, the column, and the language. Each tab has a border.
A close mark is drawn on the tab unless Settings turns that off.
The mark closes that document, with the same dirty-file question
as File, Close. Documents lists the loaded files and switches to
the chosen one. Opening a file sets the tab title, including when
the open replaces the single untitled buffer.

File covers New, Open, Save, Save As, Save All, Close, Settings,
and Quit. The first file dialog starts in the process current
directory. The next one starts in the directory last chosen.
That directory is remembered for the session only, not in a
config key. Save writes the active named document. An untitled
document asks for a path.
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
unindent use the tab width. That width defaults to four spaces,
and Settings can change it. Undo and redo walk the editor
buffer, including a change typed in the view.

The text view shows line numbers in the left gutter, one per
buffer line. The numbers scroll with the text. An empty buffer
shows line 1. The current line is
highlighted. Settings can turn that highlight off and can set
its color. A right column marker is off by default. Settings
turns it on, sets its color, and sets the character count,
which starts at 80. Font and size are chosen with a font
chooser dialog. Tags color scpp keywords, types, calls,
preprocessor lines, strings, comments, and numbers. A span
is painted at its character column, so a multibyte character does
not shift a later color. Undo and redo put the caret back on the
edited spot and scroll that spot into view.

Keys: Ctrl+O opens, Ctrl+S saves, Ctrl+Shift+S saves as,
Ctrl+Shift+L saves all, Ctrl+Z undoes, Ctrl+Shift+Z and Ctrl+Y
redo, Ctrl+X cuts, Ctrl+C copies, Ctrl+V pastes, Ctrl+] indents,
and Ctrl+[ unindents. Ctrl+S runs after the key handler returns,
so the save dialog is not opened inside that handler. Quit
destroys the window and leaves the process, including when a
save dialog is open. Settings toggles closing brackets and
indenting a new line. Those apply to every open document and to
the next one. The settings dialog is transient for the editor
window.
