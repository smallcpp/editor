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

The window has a menu bar, document tabs, and a status line.
The menus are File, Edit, Search, View, and Documents. The
status line shows the title, a dirty star, the line, the
column, and the language. Each tab has a dark border.
A close button is drawn on the tab unless Settings turns it off.
The mark closes that document, with the same dirty-file question
as File, Close. Documents lists the loaded files and switches to
the chosen one. A name is shown as written, including an
underscore. Opening a file selects that tab and sets its title,
including when the open replaces the single untitled buffer.

File covers New, Open, Save, Save As, Save All, Close, and
Quit. Open can select several files. Each selected file is
opened, and the last one is the active tab. The first file
dialog starts in the process current directory. The next one
starts in the directory last chosen.
That directory is remembered for the session only, not in a
config key. Save writes the active named document. An untitled
document asks for a path.
Save As refuses a path that belongs to another open document,
and it asks before replacing a file that already exists.
A failed Save As leaves the previous path and title in place. Save
All writes modified named documents and skips untitled ones. Only
Quit and the window close button leave the program. A dirty
document asks what to do with every modified file. Each row
can save or discard that file. Save all and Discard all cover
the list. Cancel leaves them open. Saving an untitled file
asks for a path. Discard drops the file that was being closed.
The last document, when closed, is replaced by
a fresh untitled buffer. A modified tab draws a dot before
the file name. The dot is removed when the buffer is clean.

Edit covers Undo, Redo, Cut, Copy, Paste, Indent,
Unindent, and Settings.
Search has Search, Replace, Reverse, Whole word, Match
case, and Wrap. The last four are check items. Wrap is on
by default. Search and Replace open
dialogs and stay open while finding. A selection that spans
lines is the only range that is searched. File includes Close
All, which closes every document and leaves one untitled
buffer. Each command shows its accelerator. View offers
Whitespace, Line ends, and Indent stops. Whitespace draws
a dot for each space and a line for each tab. Line ends
draws a mark after each line. Indent stops draws a line
at each tab stop inside the leading indent. Settings has
General, Search, Appearance, and Keyboard pages, and the
tabs sit on the left and stay put while the page scrolls.
Search holds wrap at the end of the buffer, reverse
direction, whole words only, and exact word case.
Appearance holds Whitespace, Line ends, Indent stops, and
Font. Remember files is on General with the recent-file
count, and it is off until it is turned on. Search and
Appearance
say that the choices on those pages are the defaults.
Similar controls sit in a bordered group. Indenting is
one group: Autoindent, tabs or spaces or both, and the
indent width. The width is how many character places one
indent shows. General can trim trailing spaces when a
file is saved. That switch is off until it is turned on.
Each field has its label on the same line, and the field
is 12 characters wide. General also holds how many recent
files to keep. The count starts at 10. It can save a named
file when its tab loses focus, and when the window loses
focus. Both are off until they are turned on. An untitled
buffer is left unsaved. Keyboard is a
grid of the command and its accelerator. Click a shortcut,
press the new keys, and Escape cancels. A shortcut that
another command already uses is refused, and the page names
that command. Apply does not write a duplicate. The notebook
fills the dialog. The left tabs stay put, and the page
scrolls. Apply stores
them in
`editor.ini` and leaves the dialog open. The same file
stores the window width and height. The next start uses
that size, and a first run with no saved size uses the
usual size. Open Recent sits with Open and lists the
newest files first, up to the saved count. Choosing one
opens it. When Remember files is on, the named files and
the active file are opened again next time. Untitled
buffers are left out. Document tabs stay inside the
window. Left and right buttons scroll them. The close
button and the tab border stay.
Copy and cut read the selection in the text view. Indent,
unindent, and Tab follow the indent settings. The default is
spaces, and one indent is four spaces. Settings can switch to
tabs and can change how many spaces one indent moves. Undo and
redo walk the editor
buffer, including a change typed in the view.

The text view shows line numbers in the left gutter, one per
buffer line. The numbers scroll with the text. An empty buffer
shows line 1. The gutter is wide enough for four digits and
one space before the text. The current line is highlighted,
one line at a time, including a blank line at the end. Settings
can turn that highlight off and can set its color. A right
column marker is off by default and is two pixels wide. Settings
turns it on, sets its color, and sets the character count,
which starts at 80. Font and size are chosen with a font
chooser dialog. Tags color scpp and shpp keywords, types, calls,
preprocessor lines, strings, comments, and numbers. A span
is painted at its character column, so a multibyte character does
not shift a later color. Undo and redo put the caret back on the
edited spot and scroll that spot into view.

Keys: Ctrl+N creates a document, Ctrl+O opens, Ctrl+S saves,
Ctrl+Shift+S saves as, Ctrl+Shift+L saves all, Ctrl+W closes,
Ctrl+Shift+W closes all, Ctrl+Q quits, Ctrl+Z undoes,
Ctrl+Shift+Z and Ctrl+Y redo, Ctrl+X cuts, Ctrl+C copies,
Ctrl+V pastes, Tab and Ctrl+] indent, and Shift+Tab and
Ctrl+[ unindent. Ctrl+F searches and Ctrl+H replaces. The
menus show the same accelerators. The Keyboard page can
change each one. Tab, Shift+Tab, and Ctrl+Shift+Z stay bound
as well. Ctrl+S runs
after the key handler returns, so the save dialog is not opened
inside that handler. Quit
destroys the window and leaves the process, including when a
save dialog is open. Settings toggles autoclose brackets.
The pairs are `()`, `[]`, `{}`, `""`, and `''`. It also
toggles indenting a new line and indenting with spaces,
tabs, or both. It sets how many character places one
indent shows. Those apply to every open
document and to the next one. Apply writes those choices to
`$HOME/.config/smallcpp/editor.ini` and leaves the dialog
open. Close only hides it. A missing file, or a missing
`HOME`, keeps the defaults. The dialog is transient for the
editor window.
