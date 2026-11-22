# editor

`sedit` edits text files. It opens several files and untitled
documents, switches between them, and saves them. Syntax coloring
covers scpp. The buffer keeps undo and redo.

Build, test, and install it with the scripts in the root `README.md`.
Do not run `cmake` yourself. `scripts/setup`, then `build`, then
`install`, then `bin/sedit`. `install` copies `bin/sedit` to
`bin/sedit` under the prefix. A fresh configuration uses
`$HOME/opt/smallcpp`. `install /absolute/path` selects that prefix
for one run. A normal `build` compiles the editor and leaves the
test programs unbuilt. `build test` builds those programs and runs
the unit tests. The window test runs under `xvfb-run`. The other
tests do not open a window.

## Starting

```text
sedit [file]...
sedit --help
sedit --version
```

`--help` and `--version` exit 0. Help and the version line come
from the standard `Cli` parser. `--help` prints `help_text`.
`--version` prints `version_text`, `sedit: v0.0.1`. An unknown
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
A narrow column on the right of the current buffer shows
the shape of the file and a band for the visible lines.
A click in that column scrolls the buffer. The column
reads the buffer the editor already has.
A panel on the left lists files, the project, and symbols.
The project is a folder. Settings, Projects lists recent
project folders, and choosing one opens that folder.
Set types a path, and File folder
uses the directory of the active file. When that folder
contains `CMakeLists.txt`, the project page lists
`add_executable` and `add_library` targets, and compile
lines from `compile_commands.json` when that file is
there. The panel does not own the buffer. Opening a file
uses the same path as File, Open. A symbol moves the
cursor in the current buffer.
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
Unindent, Comment, Block comment, Add caret, Clear
carets, Record, Stop, Play, and Settings. Comment
toggles a line comment on every selected line. Ctrl+/
runs it. Add caret puts another caret on the next line,
in the same column. Typing, Backspace, Delete, and
Comment then apply at each caret. Clear carets removes
the extras. An arrow key or a click clears them too.
Record stores the keystrokes that reach the text view.
Stop keeps that list. Play performs it: typing, Enter,
Tab, Backspace, Delete, and the arrow keys run in the
view, and a shortcut runs its command. Block comment
is Alt+/,
and it adds a
multi-line comment without removing one. Python, shell,
and toml put `#` on each line.
CMakeLists.txt, Makefile, and Dockerfile do too, as do
makefile, GNUmakefile, dockerfile, and Containerfile. A
highlighted suffix wins over those names. A shebang on
the first line selects the language. Markdown and plain
text do nothing.
Search has Search, Replace, Reverse, Whole word, Match
case, and Wrap. The last four are check items. Wrap is on
by default. Search and Replace open
dialogs and stay open while finding. A selection that spans
lines is the only range that is searched. File includes Close
All, which closes every document and leaves one untitled
buffer. Each command shows its accelerator. View offers
Whitespace, Line ends, and Indent stops. Left panel and
Right panel are checked while those panels are shown.
Left panel is the files and project list. Right panel
is the mini-map. Clearing a check hides that panel.
Whitespace draws
a dot for each space and a line for each tab. Line ends
draws a mark after each line. Indent stops draws a line
at each tab stop inside the leading indent. Settings has
General, Projects, Search, Appearance, Languages, and Keyboard
pages, and the tabs sit on the left and stay put while
the page scrolls. Languages lists each language. It has
a name, suffixes, special filenames, a shebang, a line
comment, an optional block comment, and keywords. Add,
Save, and Delete change the list. Reset restores a
built-in language. A file that matches nothing stays
plain. Commenting and coloring use this list.
Search holds wrap at the end of the buffer, reverse
direction, whole words only, and exact word case.
Appearance holds Whitespace, Line ends, Indent stops, and
Font. It also picks a theme and can save the current
settings as a new theme. A theme file lives in
`$HOME/.config/smallcpp/themes` and can be copied in.
It sets the window background and text, menus, tabs, the
current line, the column marker, syntax colors, bracket
colors, and the font. The tag map in `editor.ini` is the
default theme. A missing color keeps that default.
Remember files is on General with the recent-file
count, and it is off until it is turned on. Search and
Appearance
say that the choices on those pages are the defaults.
Similar controls sit in a bordered group. Indenting is
one group: Autoindent, tabs or spaces or both, and the
indent width. The width is how many character places one
indent shows. General can trim trailing spaces when a
file is saved. That switch is off until it is turned on.
Ensure newline at end of file is off until it is turned
on. A save then adds one newline when the buffer does not
already end with one. Show path in file tab is off until
it is turned on. Depth is how many parent directories the
tab keeps. Depth 0, or the switch off, shows only the
file name.
Each field has its label on the same line, and the field
is 12 characters wide. General also holds how many recent
files to keep. The count starts at 10. It can save a named
file when its tab loses focus, and when the window loses
focus. Both are off until they are turned on. An untitled
buffer is left unsaved. Keyboard is a
grid of the command and its accelerator. Click a shortcut,
press the new keys, and Escape cancels. A shortcut that
another command already uses is refused, and the page names
that command. A duplicate shortcut is not written. The
notebook fills the dialog. The left tabs stay put, and
the page scrolls. A change stores the choices in
`editor.ini`. The same file
stores the window width and height. The next start uses
that size, and a first run with no saved size uses the
usual size. Open Recent sits with Open and lists the
newest files first, up to the saved count. Choosing one
opens it. A file that is gone opens a message dialog,
File "name" not found., and does not open a buffer.
When Remember files is on, the named files and
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
chooser dialog. A span stores a tag name, not a color.
The tags are keyword, type, string, comment, number,
preprocessor, call, and operator. Operator covers
characters such as `()`, `{}`, `[]`, and `+`. The theme
in `editor.ini` maps each
tag to a color. The default theme is the same for every
language and keeps the colors already used. A language can
override one tag. A missing tag uses the default color.
The file text never contains a tag. One scanner covers
every language, and `language_of` is still the suffix map.
A span is painted at its character column, so a multibyte
character does not shift a later color. Undo and redo put
the caret back on the
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
The pairs sit in an edit box. The default is `()[]{}""''`,
and the editor closes whatever pairs that box holds. It also
toggles indenting a new line and indenting with spaces,
tabs, or both. It sets how many character places one
indent shows. Those apply to every open
document and to the next one. A control writes those
choices to `$HOME/.config/smallcpp/editor.ini` when it
changes. Close only hides the dialog. Close button on
file tabs sits on General. It is not on the dialog
frame. Current line color and the
column marker color each have a Color button that opens
the color chooser and stores the chosen `#rrggbb`.
Appearance has Syntax colors. That dialog is a grid.
The tag name, the foreground, and the background are
columns. It chooses one file type and assigns a color
to each tag. The color is saved as a theme override,
such as `theme-python-keyword`. When the cursor is on
a bracket, a matching pair uses the `brackets` colors
and an unmatched bracket uses `brackets-unmatched`.
Each of those tags has a foreground and a background.
The match is dark on gold, and an unmatched bracket is
white on red. A bracket in a string or a comment stays
inside that span. A bracket in code skips those spans.
The dialog sets the buffer background. The default is
`#ffffff`, and a file type can override it, such as
`theme-python-background`. Each tag has a Bold
checkbox. The default is off. A file type stores one
as `theme-python-keyword-bold`. A line separates the
grid from Close. Close is centered on this dialog and
on the setup dialog.
When a buffer's file changes on disk, the editor asks
to reload it, save over it, or ignore that copy until
the file changes again. A saved file that is gone from
disk is reported once. General has Write recovery files,
off until it is turned on, and a Minutes box that starts
at 5. Keep starts at 20. A recovery copy is the buffer
text. The open project's copies are written in
`<project>/.sedit`, next to `editor.ini`, which is a copy
of the current settings and records that folder as
`recovery-dir`. With no project, copies are written under
`$HOME/.config/smallcpp/recovery`.
Copies past that count are removed, oldest first. On
startup, a recovery copy for a file that is gone asks
Open or Ignore. Open loads that copy and says the file
was restored. Ignore deletes that copy and leaves it
closed.
A missing file, or a missing
`HOME`, keeps the defaults. The dialog is transient for the
editor window.
