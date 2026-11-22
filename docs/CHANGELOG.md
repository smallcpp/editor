# Changelog

## Unreleased

The top of the window is a menu bar. File, Edit, Search, View,
and Documents are submenus. File has New, Open, Save, Save As,
Save All, Close, and Quit. Edit has Undo, Redo, Cut, Copy,
Paste, Indent, Unindent, and Settings. Search has Search, Replace,
Reverse, Whole word, Match case, and Wrap. The last four are
check items. A selection that covers more than one line
limits the search to those lines. Wrap is on unless it is
turned off. View has Whitespace, Line ends, and Indent
stops. Those three draw in the text. Documents
lists the open files. Menus place a separator between
groups: File separates new and open, the saves, the closes,
and Quit. Edit separates undo, the clipboard, and indent.
Search separates the commands from the options. Edit
separates Settings from the other commands. File also has
Close All. Open can select
several files. Each one is opened, and the last one is the
active tab. A new line shows its gutter number when Enter
creates it, before any character is typed. The last
line keeps a number when that line has no characters.
When a buffer's file changes on disk, a dialog offers
Reload, Save, or Ignore. A saved file that disappears
is reported once. General can write recovery copies.
That checkbox is off. The minutes box starts at 5.
Copies go in `$HOME/.config/smallcpp/recovery`. A settings
control writes `$HOME/.config/smallcpp/editor.ini` when it
changes. Close only hides the dialog. Settings is a notebook
with the tabs on the
left. Those tabs stay put while the page scrolls. General
holds the switches. Search names wrap at the end of the
buffer, reverse direction, whole words, and exact word
case. Appearance holds Whitespace, Line ends, Indent
stops, and Font. Remember files sits with the recent-file
count and is off until it is turned on. General holds how many
recent files to keep, and that count starts at 10.
Keyboard is a
grid of the command and its accelerator.
Click a shortcut, press the new keys, and Escape cancels.
A shortcut already used by another command is refused, and
the page names that command. An accepted shortcut is
written with the other settings.
The notebook grows and shrinks with the dialog.
The editor window keeps its width and height in that
file and uses them the next time it starts. A first run
with no saved size uses the usual size. File has Open
Recent beside Open. It lists the newest files first, and
only as many as the recent-file count. A recent file
that is gone opens a message dialog,
File "name" not found., and does not open a buffer.
When recovery is on and that file has a recovery copy,
startup asks to Open or Ignore it. Open loads the copy
and says File "name" was restored. Ignore leaves it
closed. When Remember
files is on, the open file paths and the active file are
stored and opened again next time. An untitled buffer is
not restored. The document tabs scroll with left and
right buttons instead of stretching the window.
Search options and view options are written with the
other settings. A missing file keeps the defaults. Tabs show a
dark border.

Documents keeps underscores in a file name, so `howdy.scpp` and
`how_dy.scpp` appear as written. Opening a file selects that tab.
The tab close control is a button. The gutter holds four digits
and one space before the text. The current line highlight is one
line, including the last line and a line just inserted. Indent,
unindent, and Tab use spaces by default, four spaces wide, and
Settings can choose tabs or a different space count. The right
column marker is two pixels wide.

`test-window` saves a named file through the menu and checks that
an untitled save asks for a path. Neither step presents a file
dialog.

Opening a file updates the tab title, including when that open
replaces the untitled buffer. Documents lists the loaded files
and switches to the chosen one. Tabs have a border and, by
default, a close button. Settings can hide that button.

Line numbers sit in the left gutter, one per buffer line, and they
scroll with the text. An empty buffer shows line 1. The current
line is highlighted. Settings has a
toggle and a color, and the highlight is on by default. The
settings dialog uses the editor window as its transient parent.

Tab width defaults to four spaces. Settings can change it. A
right column marker is off by default, at 80 columns, with a
toggle, a color, and a character count. Font and size come from
a font chooser dialog.

scpp coloring also marks preprocessor lines, extra keywords,
types, and names used as calls. A `.shpp` file uses that same
coloring. Other languages are unchanged. Opening a file paints
those colors in one pass. It no longer walks from the start of
the file for every colored span. A modified tab shows a dot
before the name, and the dot goes away when the buffer is
clean. General can save a named file when its tab loses
focus, or when the window loses focus. Both are off until
turned on. An untitled buffer is not written on focus loss.
Each settings field sits beside its label, and the field is
12 characters wide. Search and Appearance say that those
choices are the defaults. Indenting, the current line, the
column marker, saving, and the text marks each sit in a
bordered group. Indent can use tabs, spaces, or both, and
the width is how many character places one indent shows.
Autoindent is the name of the new-line indent. Trim
trailing spaces on save is off until it is turned on.
Ensure newline at end of file is off until it is turned
on. A save then adds one newline when the buffer does not
already end with one. Show path in file tab is off until
it is turned on. Its depth is how many parent directories
to keep. Depth 2 of `.../editor/src/ui.scpp` shows
`editor/src/ui.scpp`. Depth 0, or the switch off, shows
only the file name. Both are saved in `editor.ini`.
Font is on Appearance. Remember files sits with the
recent-file count on General. Autoclose brackets keeps an
edit box of the pairs. The default is `()[]{}""''`. The
editor closes whatever pairs are in that box, and a change
stores them as `bracket-pairs`. Search names the wrap, reverse,
whole-word, and match-case choices in full. The left tabs
stay in place while a settings page scrolls. Close button
on file tabs sits on General, with the file choices. It is
not on the dialog frame. There is no Apply button. Current
line color and column marker
color each have a Color button. That button opens the
color chooser and stores `#rrggbb`. Syntax spans store a
tag name: keyword, type, string, comment, number,
preprocessor, call, or operator. Operator covers
characters such as `()`, `{}`, `[]`, and `+`. A span does
not store a color.
The theme in editor.ini maps each tag to a color. The
default theme is the same for every language and keeps
the colors the editor already used. A language can
override one tag, so a Python keyword can differ from a
C keyword. A tag with no override uses the default. The
file text never contains a tag. One scanner still covers
every language, and language_of is still the suffix map.
Appearance opens Syntax colors. That dialog is a grid.
The tag name, the foreground, and the background sit in
columns. A file type sets a color for each tag. The
color is stored as an override, such as
`theme-python-keyword`. The cursor paints a bracket
pair. The tag `brackets` is a matching pair, and
`brackets-unmatched` is a bracket with no mate. Each of
those tags has a foreground and a background. A match
is dark on gold. An unmatched bracket is white on red.
A file type can override either color, such as
`theme-python-brackets-back`. A bracket inside a string
or a comment matches only inside that span. A bracket
in code skips those spans. The dialog also sets the
buffer background. The default is `#ffffff`. A file
type can override it, such as
`theme-python-background`. Each tag has a Bold
checkbox. The default is off. A file type can turn
one on, such as `theme-python-keyword-bold`. A line
separates that grid from Close. Close is centered
on this dialog and on the setup dialog.
The save dialog lists every modified file.
Each one can be saved or discarded, and Save all and Discard
all do the whole list. Saving an untitled file still asks
for a path.

Quit destroys the window and leaves the process, including after
a save dialog. Ctrl+S runs the save command after the key handler
returns, and the file dialog uses the editor window as its parent.
The shortcut hook stays alive after the window is built, so a
later Ctrl+S still reaches that command. The window test builds
the window in a function that returns, then sends Ctrl+S to a
named dirty file and checks that the file is written.
Every file dialog starts in the process current directory the
first time, then in the directory last chosen. That directory is
remembered for the session only.

Typing `(` or `{` inserts the closer after GTK's user action, at
a character offset, so the buffer iterator stays valid and the
insert is not nested in that action. `()` stays `()` when the
closer is typed. Undo and redo call `TextView::scroll_to`, which
scrolls a mark, so the caret stays on the edited spot.

Ctrl+O, Ctrl+S, Ctrl+Shift+S, Ctrl+Shift+L, Ctrl+Z, Ctrl+Y,
Ctrl+Shift+Z, Ctrl+X, Ctrl+C, Ctrl+V, Ctrl+], and Ctrl+[ run the
existing commands. The view shows line numbers. Settings toggles
autoclose brackets and indenting a new line.

File, Open starts in the process current directory.
`gtk_file_dialog_set_initial_folder` receives that directory.
`test-editor` checks the directory after `chdir`.

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
