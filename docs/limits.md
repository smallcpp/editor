# Limits

These are places where scpp or the GTK wrapper cannot do what a
desktop editor does. The editor still does the closest real job,
and the unit tests cover that job.

The wrapper has no GtkSourceView and no language-spec directory.
The scanner highlights scpp. A header ending in .shpp uses
that same coloring. The same scanner also colors C,
C++, cw, Python, shell, and toml. Preprocessor lines, extra
keywords, types, and call names are colored for scpp and
for a .shpp file. Other
files, including Markdown, stay plain. A span stores a tag
name. The theme in editor.ini maps that tag to a foreground
color. The default theme is shared by every language. A
language may override one tag, and a missing tag uses the
default. The current line is drawn under the cursor line, one
line high, including a blank line. Line numbers are a gutter of
the visible lines, wide enough for four digits and one space.
Each number is drawn at its buffer line and scrolls with the
text. A narrow column on the right draws the shape of the
file from the length of its lines, and a band for the lines
in view. A click scrolls that part of the file into view.
The column reads the editor buffer and does not keep a
second copy. The wrapper has no mini-map widget, so the
column is drawn directly. A line Enter just created is numbered before it has
characters. Whitespace, line ends, and indent stops are overlays
the view can turn on. The right column marker is an overlay at a character
column. The status line shows the line and column from the
editor buffer.

GtkTextView keeps one cursor. The wrapper stores extra
carets as marks and draws them, because the text view
cannot hold a second cursor itself. The editor asks for
a caret on the next line from the Edit menu. Typing,
Backspace, Delete, and Comment then apply at each caret.
An arrow key or a click clears the extra carets. The
editor keeps at most 16 extra carets.

Shortcuts use `Widget::add_shortcut`. `Widget::on_key` reports
one key while a shortcut cell is waiting. Escape cancels that
wait. Menus run the same commands. The text
view keeps GTK's own navigation keys. Copy, cut, indent, and
unindent read the view's selection and then run on the editor
buffer, which also owns undo.

FileDialog open can return several paths. Save still picks
one path. It has no folder mode. The first dialog starts in the
process current directory, and later dialogs start in the
directory last chosen
during this session. The left panel cannot ask for a
folder, because the dialog has no folder mode. The
project is the active file's directory or a path typed
in the panel. A directory row lists that directory and
does not leave the project. CMake targets are the names
in `add_executable` and `add_library`, not a full CMake
run. A compile line is the `command` string, or the
`arguments` list when `command` is absent. Symbols are
a scan of the current buffer, not a compiler's view.
The panel does not keep a second copy of the text.
Tab titles are the file name. A modified
tab draws a dot before that name. The dirty star is on the
status line. A tab can show a close button. The save dialog
lists every modified file. The window shows at most
32 documents.

`TextView::set_font` sets the family and the size from the font
chooser. Wrapping stays off. The menu bar is the first child
of the window because the wrapper has no title-bar setter.
Settings are stored in `$HOME/.config/smallcpp/editor.ini`,
beside the compiler's `config.ini`. A control writes that
file when it changes, including one `key-` accelerator for
each command, the search options, and the view options.
Close only hides the dialog. The setup dialog is a notebook with
the tabs on the left. Languages is one page. A language
has suffixes, filenames, a shebang, a line comment, an
optional block comment, and keywords. The built-in set
can be reset. The list is `languages.ini` beside
`editor.ini`. A file with no language stays plain.
General holds the switches. Search
holds wrap at the end of the buffer, reverse direction,
whole words only, and exact word case. Appearance picks
a theme. Saving the current settings writes
`$HOME/.config/smallcpp/themes/<name>.ini`. The default
theme is the `theme-` map in `editor.ini`. A theme file
that omits a key keeps the default. A theme also sets
the window background, text, menus, tabs, the current
line, the column marker, and the font. Appearance holds
Whitespace, Line ends, Indent stops, and Font. General
holds the recent-file count, which starts at 10, Remember
files, which is off until turned on, and trim trailing
spaces, which is off. Ensure newline at end of file is
off. Show path in file tab is off, and its depth starts
at 0. Depth 0 shows only the file name. Autoclose pairs
are an edit box.
The default is `()[]{}""''`, saved as `bracket-pairs`.
Comment is Ctrl+/ and toggles a line comment on every
selected line. Block comment is Alt+/ and adds a
multi-line comment without removing one. The shortcut
list shows `/` instead of the name slash. `#` languages,
CMakeLists.txt, Makefile, and Dockerfile comment each
line. A highlighted suffix wins.
A shebang selects the language. Markdown and plain text
ignore it. Close button on file tabs is on General. It
is not on
the dialog frame. Appearance opens a dialog that sets
tag colors for one file type. The tag name, the
foreground, and the background are columns of a grid.
Those overrides are `theme-` lines, such as
`theme-python-keyword`. Operator is a tag for characters
such as `()` and `{}`. `brackets` paints a matching pair,
and `brackets-unmatched` paints a bracket with no mate.
Each of those has a foreground and a background.
The dialog also sets the buffer background. The
default is `#ffffff`. Each tag has a Bold checkbox,
off until it is turned on. A line separates the grid
from Close. Close is centered on this dialog and on
the setup dialog.
A changed file asks to reload, save, or ignore. A
removed file is reported once. Write recovery files is
off. The interval is `recovery-minutes`, from 1 to 1440,
and the default is 5. `recovery-keep` is how many
copies to hold, from 0 to 500, and the default is 20.
Copies are the buffer text in
`$HOME/.config/smallcpp/recovery`. Copies past that
count are removed, oldest first. Startup asks
Open or Ignore when that copy is for a file that is
gone. Open loads it. Ignore deletes that copy.
A Color button sets the current-line color and another
sets the column-marker color. Indent width is a character count. Keyboard
is a grid of command and shortcut. Click a shortcut, press
the new keys, and Escape cancels. A shortcut that
another command already uses is refused. The notebook fills the
dialog. The left tabs stay fixed, and the page scrolls.

This editor does not open projects, run builds, talk to a language
server, load plugins, or show a message pane or a debugger.
