# Changelog

## Unreleased

The top of the window is a menu bar. File, Edit, Search, View,
and Documents are submenus. File has New, Open, Save, Save As,
Save All, Close, and Quit. Edit has Undo, Redo, Cut, Copy,
Paste, Indent, and Unindent. Search is empty. View has
Settings. Documents lists the open files. Open can select
several files. Each one is opened, and the last one is the
active tab. A new line shows its gutter number when Enter
creates it, before any character is typed. Settings has Apply.
Apply writes `$HOME/.config/smallcpp/editor.ini` and leaves the
dialog open. A missing file keeps the defaults. Tabs show a
dark border.

Documents keeps underscores in a file name, so `howdy.scpp` and
`how_dy.scpp` appear as written. Opening a file selects that tab.
The tab close control is a flat mark. The gutter holds four digits
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
default, a close mark. Settings can hide the close mark.

Line numbers sit in the left gutter, one per buffer line, and they
scroll with the text. An empty buffer shows line 1. The current line is highlighted. Settings has a
toggle and a color, and the highlight is on by default. The
settings dialog uses the editor window as its transient parent.

Tab width defaults to four spaces. Settings can change it. A
right column marker is off by default, at 80 columns, with a
toggle, a color, and a character count. Font and size come from
a font chooser dialog.

scpp coloring also marks preprocessor lines, extra keywords,
types, and names used as calls. Other languages are unchanged.

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
closing brackets and indenting a new line.

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
