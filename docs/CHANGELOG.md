# Changelog

## Unreleased

The Sessions dialog has no name field. Rename and
Duplicate each ask for the name in a small prompt.
Open is back at the top of the button column. A click
selects a row and does not open it. Moving the mouse
over a row does not change the selection. From the
top the buttons are Open, New Session, Delete, Close,
Rename, and Duplicate, with a gap before Delete and
a gap before Rename.

The Sessions list highlights one row. It stays a
column view, with a single selection so the theme
draws that row. Up and Down move the highlight. Open,
Delete, Rename, and Duplicate use that row.

Quit detaches the Files and Documents right-click
menus from their column views before those views are
destroyed.

The window title is the current session name. When no
session is open, the title is `<No Session>`. Opening,
creating, renaming, saving, saving as, or closing a
session updates that title.

Startup with no files keeps the Sessions dialog open.
The editor window is registered first and stays hidden
until a session is chosen, so GTK does not quit and
then disconnect shortcut handlers that were never
attached to a widget. Closing the dialog opens the
most recent session, or a blank editor.

A session is the set of files being edited. There is
no project menu, project page, project file, project
kind, template, or project theme. Startup with no
files shows a dialog that lists sessions by name,
file count, and the date last opened. Open, New
Session, Delete, Close, Rename, and Duplicate act on
that list. Delete removes the session record and
leaves the files on disk. Close opens the most recent
session. The Sessions menu has New Session, Recent,
All Sessions, Save Session, and Save As. A session
remembers the open files, the current file, and the
caret line. The editor does not build, run, or debug.

Keyboard shortcuts show the character when the key has
one, so bracketright is ]. Escape, F1, and the arrows
stay named. Each shortcut has Default, which restores
its built-in binding. A combo another command already
uses asks first. Assign moves it and clears the old
command. Cancel leaves both. Shortcut buttons keep a
fixed width. Reading the new-project browse folder
does not release the dialog's copy of that folder.

Right-click on the mini-map opens a dialog for its font
and size. Save updates the column immediately and stores
the same `map-font` value as Settings, Appearance. Cancel
leaves the font as it is. The wheel, the drag, the
current-line mark, and the width stay as they are.

The left panel no longer has a Project tab. Documents
lists the open files and the project tree. One click
still opens a project file or switches documents.
Files and Symbols stay.

Setup, Project has the same actions as the Project
menu: Create New, Individual files, From directory,
Git repo, CMake build, Open, Close, Save, Save As,
and Delete. It also chooses the project's theme.

Save writes the open project and says so. Save As
asks for a new name, writes that project, and leaves
the original open. The same name is refused. Close
saves and clears the project. Delete removes that
project file. With no project, Save, Save As, Close,
and Delete say there is no project.

A project stores a theme. Choosing it on the Project
page uses that theme while the project is open.
Closing or deleting the project returns to the editor
theme. The editor theme in setup stays the editor
theme.

Right-click in the text hides Insert Emoji and adds
Insert date and Insert color. Insert date writes the
local date at the caret as `YYYY-MM-DD`. Insert color
opens the color chooser and writes the same `#rrggbb`
text a theme color is stored as.

Right-click on Files, Project, or Documents shows New,
Open, Close, Save, and Remove. Open, Close, Save, and
Remove stay gray until the click is on a file, and
then they apply to that file. New stays available when
a file can be created. Remove asks first. One choice
drops the file from that list and leaves it on disk.
The other also deletes it. Cancel leaves it alone.

The mini-map width can be set from 24 to 500. The
setup spin, the drag bar, and a saved map-width all
use that range. A width already saved stays as it is.
The column does not change width on its own.

A Color button is filled with the chosen color, so the
color shows without opening the chooser. Clicking it
still opens the chooser. The label stays readable on
that patch.

A theme sets the background and the text color of the
panels, menus, and buttons, as well as the editor text.
Panels and buttons use `theme-background` and
`theme-text`. Menus use `theme-menu` and
`theme-menu-text`. Those colors are saved with the
theme the same way the other theme colors are saved.

The mouse wheel over the mini-map scrolls the buffer.
Each notch moves the view by one line. The caret stays
where it was, and the highlight follows the lines now in
view. Dragging the highlight still scrolls without moving
the caret. A click in the buffer still moves the
current-line mark. The column width stays fixed, and a
short file stays packed from the top.

A short file in the mini-map is drawn at the mini-map
font's line spacing, packed from the top of the column.
It looks like the top of a longer file. A file that does
not fit still fills the column. The column width, dragging
the highlight to scroll, and the current-line mark stay
as they are.

The open files that were on the Documents menu are a
Documents tab on the left panel. The menu item is gone.
The tab lists those files by the same names, lined up
on the left, and one click switches to that file. The
tab row still scrolls with the same buttons. Files,
Project, and Symbols stay as they are.
Project no longer has New. That item created an empty
project from a name and a source. Create New and Create
From remain. Create New still asks for a directory,
including one typed in Browse that does not exist yet,
and unpacks the template there.

Project, Create New, Browse opens in the directory where
the editor was started. That directory is kept for the
whole session. The user types a directory name there,
including one that does not exist yet, or chooses a
directory that already exists. Create New creates a
missing directory and unpacks the template into it. An
existing directory is used as before. A project created
there stores absolute paths, so opening it later from
another directory still uses the directory chosen when
it was created.

Creating or opening a project closes the file buffers
that were already open. If a buffer has unsaved changes,
the editor asks before it closes that buffer and switches.
The left panel then shows the Project page and that
project's tree. Open, Create New, and each Create From
item do this. A project that saved its place opens those
files after the previous buffers are gone.

Project, Create New asks for a directory, unpacks the
project template there, and opens that directory as a
project named for the directory. The editor build clones
https://github.com/smallcpp/template, writes
`template.tar.gz`, and deletes the clone. Installing the
editor copies that archive to
`$HOME/.config/smallcpp/template.tar.gz`.
Project, Create From opens Individual files, From
directory, Git repo, and CMake build. Individual files
asks for a project name and the files. From directory
asks for a project name and a directory. Git repo asks
for a project name and the repository directory. CMake
build asks for a project name and the directory that
holds the CMake build. Each one creates a project of
that kind.

A project is a named list of files, and using one is
optional. More than one project can describe the same
directory. Project has Create New, Create From,
Open, Close, Save, Save As, and Delete. Open lists the
projects already saved. A
project's files come from an explicit list, a directory,
a git repository, or the sources named by a CMake build.
The project panel shows those files as a collapsible
tree of names. Each project is a file under
`$HOME/.config/smallcpp/projects/<name>.project`. That
file remembers the active file, the line, and the other
open files, and opening the project uses that place.
Remember files in the global `editor.ini` is a separate
choice. There is no build, run, or debug.

A click in the buffer that moves the caret marks that line
on the mini-map at once. The mark is the same one drawn
when the buffer scrolls, and the click does not wait for
a scroll.

The bar between the editor and the mini-map sets the column
width, and Settings, Appearance, Font, Map width sets that
same width. The column keeps the width from whichever
control was used last. Resizing the window does not change
it.

Pressing the highlighted area and moving the mouse scrolls
the buffer. The caret stays where it was. A click outside
the highlight still only scrolls.

The mini-map draws each line in a font, so the shape of the
text is visible across the column. Settings, Appearance, Font
has a Mini-map control that chooses that font.

Edit, Select All, and Ctrl+A select the current buffer from
the start through the end. The Edit menu shows that shortcut.
If another command already used Ctrl+A, that command loses
the shortcut.

The mini-map keeps its own reference to the drawing area.
Closing a file, or quitting with several files open, no
longer releases that area after the split has already
freed it.

Project lines its file names up on the left, the same way
Files does. Dragging the marker between the left panel and
the editor changes the panel width, and that width stays
when the panel is hidden and shown again. The current line
is marked in the mini-map.

The left panel tab row has scroll buttons. The panel
sits on the left edge of the window. Files lines up its
names on the left. Project shows the open project's
files as a tree of names, and one click opens a file.

View has Left panel and Right panel. Each is checked
while that panel is shown. Left panel is the files and
project list. Right panel is the mini-map. Clearing a
check hides that panel, and checking it shows the panel
again. The choice is saved in `editor.ini`.

The installed program is `sedit`. The binary is `bin/sedit`,
and `install` copies that file into the prefix. Help and the
version line use that name.

A function that names a return type returns a value of
that type. `0` and `-1` returned from `long`, and a
comparison returned from `int`, now use a cast.

Edit can record keystrokes and play them back. Record
starts a list on the current text view. Stop keeps it.
Play inserts typing, Enter, Tab, Backspace, Delete, and
arrow keys into the view. A Control or Alt key that
matches a command runs that command. GTK 4 has no
key-event constructor, so playback performs the key.
The list holds 64 keys.
Edit can keep several carets in one buffer. Add caret
puts another caret on the next line, in the same column.
Clear carets removes the extras. Typing, Backspace,
Delete, and Comment apply at each caret and share one
undo step. An arrow key or a click clears the extras.
The text view stores those carets as marks. GtkTextView
itself still has one cursor.
A narrow column on the right of the current buffer
shows the shape of the file and a band for the lines
in view. A click in that column scrolls the buffer.
The column reads the buffer the editor already has.
A panel on the left lists files, the project, symbols,
and the open documents. The panel does not keep its own
buffer. Opening a file uses the same path as File, Open.
A symbol moves the cursor in the current buffer.
The top of the window is a menu bar. File, Edit, Search, View,
and Project are submenus. File has New, Open, Save, Save As,
Save All, Close, and Quit. Edit has Undo, Redo, Cut, Copy,
Paste, Indent, Unindent, Comment, Add caret, Clear
carets, Record, Stop, Play, and Settings. Search has
Search, Replace,
Reverse, Whole word, Match case, and Wrap. The last four are
check items. A selection that covers more than one line
limits the search to those lines. Wrap is on unless it is
turned off. View has Whitespace, Line ends, and Indent
stops. Those three draw in the text. The Documents
tab lists the open files. Menus place a separator between
groups: File separates new and open, the saves, the closes,
and Quit. Edit separates undo, the clipboard, and indent.
Search separates the commands from the options. Edit
separates Settings from the other commands. Comment
toggles a line comment on every selected line. Ctrl+/
is its key. Block comment is Alt+/, and it adds a
multi-line comment without removing one. A language
whose only marker is `#` uses that marker on each line.
The shortcut list shows `/` instead of the name slash.
Appearance picks a named theme and can save the current
settings as a new one. A theme is a file under
`$HOME/.config/smallcpp/themes`. It sets the window
background and text, menus, tabs, the current line, the
column marker, syntax colors and bold, bracket match and
unmatched colors, and the font. The tag map in
`editor.ini` is the default theme. A theme file that
omits a color keeps that default.
Settings has a Languages page. A language has a name,
suffixes, special filenames, a shebang, a line comment,
an optional block comment, and keywords. Add, Save, and
Delete change the list. Reset restores a built-in.
Commenting and coloring both use that list. A file
with no language stays plain. CMakeLists.txt, Makefile,
and Dockerfile stay special names.
Python, shell, and toml use `#` on each line.
CMakeLists.txt, Makefile, makefile, GNUmakefile,
Dockerfile, dockerfile, and Containerfile do too. A
suffix the editor already highlights keeps that language,
so `Dockerfile.cpp` stays C++. A shebang on the first
line picks the language. Markdown and plain text ignore
the command. File also has
Close All. Open can select
several files. Each one is opened, and the last one is the
active tab. A new line shows its gutter number when Enter
creates it, before any character is typed. The last
line keeps a number when that line has no characters.
When a buffer's file changes on disk, a dialog offers
Reload, Save, or Ignore. A saved file that disappears
is reported once. General can write recovery copies.
That checkbox is off. The minutes box starts at 5.
Recovery copies go in
`$HOME/.config/smallcpp/recovery`. Keep
starts at 20 and is `recovery-keep`. Older copies past
that count are removed. A settings
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
and says File "name" was restored. Ignore deletes
that copy and leaves the file closed. When Remember
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
replaces the untitled buffer. The Documents tab lists
the loaded files and switches to the chosen one. Tabs have a border and, by
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
`test-editor`, and `test-window`. It also checks `sedit --help`,
`sedit --version`, and an unknown option. `test-window` runs under
`xvfb-run`. A normal `build` compiles `bin/sedit` and leaves the
test programs unbuilt. `build test` builds `bin/sedit` and those
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
