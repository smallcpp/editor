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
the shape of the file, a band for the visible lines, and
a mark on the current line. A click in the buffer moves
the caret and that mark together, without waiting for a
scroll. Each line is drawn in the
mini-map font, far enough across the column that the text
keeps its shape. A file short enough to fit is drawn at
that font's line spacing, packed from the top, so it looks
like the top of a longer file. A longer file still fills
the column. A click outside the highlighted band
scrolls the buffer. Pressing the highlighted area and
moving the mouse scrolls the buffer with the pointer.
The caret stays where it was. The mouse wheel over the
column scrolls the buffer by one line for each notch and
leaves the caret where it was. A right-click on the
column opens a dialog for the mini-map font and its size.
Save updates the column immediately and stores that font
as `map-font`, the same value Settings, Appearance uses.
Cancel leaves the font as it is. Dragging the bar between the
editor and the column sets the column width. Map width in
Settings sets that same width, from 24 to 500. The column keeps the width
from the last of those and does not change it on its own.
The column reads the buffer the editor already has.
A panel on the left lists files, symbols, and the open
documents. Its left edge is the left edge of the
window. Dragging the marker on the panel's right edge
changes the panel width. The tab row has buttons that
scroll the Files, Symbols, and Documents labels when
they do not fit. Files lists the current folder with
each name starting at the left. Documents lists the
files open in the current session, and one click
switches to that file. A name is shown as written,
including an underscore.
Right-click on Files or the open documents shows New,
Open, Close, Save, and Remove. Open, Close, Save, and
Remove are gray unless the click landed on a file, and
then they use that file. New stays available when a
file can be created: the Files tab has a folder, or
Documents can open a buffer. New is the same as File,
New. Open opens that file. Close closes it when it is
open, and still asks when it is dirty. Save writes it,
opening it first when it is not already open. Remove
asks before it changes anything. Remove from the list
closes a document or hides a name in the Files list,
and the file stays on disk. Remove from the list and
the disk does that and then deletes the file. Cancel
leaves the file alone. A Files name stays hidden for
that folder until the editor quits.
A session is the set of files being edited. It is not
a project. It has no folder, kind, theme, or tree.
Starting the editor with no files shows a dialog
before the window. The dialog lists each session by
name, the number of files, and the date it was last
opened. The most recently opened session is first.
Open opens the highlighted session. New Session opens
the editor with no files. Delete removes that session
from the list and leaves its files on disk. The dialog
stays open. Close opens the most recent session, or a
blank editor when the list is empty. Rename changes
the highlighted session to the name in the entry.
Duplicate copies it to that name. A name already in
use is refused.
The menus are File, Edit, Search, View, and Sessions.
Sessions has New Session, Recent, All Sessions, Save
Session, and Save As. Recent is the latest sessions.
Choosing one opens it. All Sessions opens the same
dialog. Save Session writes the open files, the
current file, and the caret line under the current
name, and updates the opened date. An unnamed session
asks for a name. Save As writes that set under a new
name and makes it the current session. A name that
already belongs to a different session is refused.
Opening a session closes the buffers that were already
open. If one has unsaved changes, the editor asks
before it closes them. The session then restores its
files, the current file, and the caret line. Each
session is a file under
`$HOME/.config/smallcpp/sessions/<name>.session`.
Remember files is a separate global choice. The editor
does not build, run, or debug. The panel does not own
the buffer. Opening a file uses the same path as File,
Open. A symbol moves the cursor in the current buffer.
Right-click in the text keeps the usual edit menu and
hides Insert Emoji. Insert date writes today's local
date at the caret as `YYYY-MM-DD`. Insert color opens
the same color chooser as the theme colors and writes
the chosen color as `#rrggbb`.
The status line shows the title, a dirty star, the line, the
column, and the language. Each tab has a dark border.
A close button is drawn on the tab unless Settings turns it off.
The mark closes that document, with the same dirty-file question
as File, Close. Opening a file selects that tab and sets its
title, including when the open replaces the single untitled
buffer.

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

Edit covers Undo, Redo, Cut, Copy, Paste, Select All,
Indent, Unindent, Comment, Block comment, Add caret,
Clear carets, Record, Stop, Play, and Settings. Select All
and Ctrl+A select the current buffer from the start
through the end. Comment
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
Left panel is the files and documents list. Right panel
is the mini-map. Clearing a check hides that panel.
Whitespace draws
a dot for each space and a line for each tab. Line ends
draws a mark after each line. Indent stops draws a line
at each tab stop inside the leading indent. Settings has
General, Search, Appearance, Languages, and Keyboard
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
Font. Font opens the editor font. Mini-map, in that same
group, opens the font used to draw the mini-map. Map width,
in that group, sets the same column width as the bar beside
the mini-map. Appearance
also picks a theme and can save the current
settings as a new theme. A theme file lives in
`$HOME/.config/smallcpp/themes` and can be copied in.
It sets the window background and text, menus, tabs, the
panels, buttons, the current line, the column marker,
syntax colors, bracket colors, and the font. Panels and
buttons use the theme background and text. Menus use the
menu background and menu text. The tag map in `editor.ini` is the
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
press the new keys, and Escape cancels. The button shows
the character when the key has one, so bracketright is ].
Escape, F1, and the arrows stay named. Each row has
Default, which restores that command's built-in shortcut.
If the new combo is already used, the editor asks. Assign
moves it and clears the old command. Cancel leaves both.
The shortcut buttons stay a fixed width. The
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
Ctrl+V pastes, Ctrl+A selects the whole buffer, Tab and
Ctrl+] indent, and Shift+Tab and Ctrl+[ unindent. Ctrl+F
searches and Ctrl+H replaces. The menus show the same
accelerators. The Keyboard page can
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
column marker color each have a Color button. The button
is filled with the chosen color. Clicking it still opens
the color chooser and stores the chosen `#rrggbb`.
The same patch is on each Color button in Syntax colors.
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
text. Copies are written under
`$HOME/.config/smallcpp/recovery`.
Copies past that count are removed, oldest first. On
startup, a recovery copy for a file that is gone asks
Open or Ignore. Open loads that copy and says the file
was restored. Ignore deletes that copy and leaves it
closed.
A missing file, or a missing
`HOME`, keeps the defaults. The dialog is transient for the
editor window.
