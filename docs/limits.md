# Limits

These are places where scpp or the GTK wrapper cannot do what a
desktop editor does. The editor still does the closest real job,
and the unit tests cover that job.

The wrapper has no GtkSourceView and no language-spec directory.
The scanner highlights scpp, and the same scanner also colors C,
C++, cw, Python, shell, and toml. Preprocessor lines, extra
keywords, types, and call names are colored for scpp only. Other
files, including Markdown, stay plain. Keyword, type, call,
preprocessor, string, comment, and number tags are foreground
colors. The current line is drawn under the cursor line, one
line high, including a blank line. Line numbers are a gutter of
the visible lines, wide enough for four digits and one space.
Each number is drawn at its buffer line and scrolls with the
text. A line Enter just created is numbered before it has
characters. There is no whitespace
glyph, newline mark, or indent
guide. The right column marker is an overlay at a character
column. The status line shows the line and column from the
editor buffer.

Shortcuts use `Widget::add_shortcut`. There is still no key-press
signal on the text view. Menus run the same commands. The text
view keeps GTK's own navigation keys. Copy, cut, indent, and
unindent read the view's selection and then run on the editor
buffer, which also owns undo.

FileDialog open can return several paths. Save still picks
one path. It has no folder mode. The first dialog starts in the
process current directory, and later dialogs start in the
directory last chosen
during this session. Tab titles are the file name. The dirty
star is on the status line. A tab can show a close mark. The
window shows at most 32 documents.

`TextView::set_font` sets the family and the size from the font
chooser. Wrapping stays off. The menu bar is the first child
of the window because the wrapper has no title-bar setter.
Settings are stored in `$HOME/.config/smallcpp/editor.ini`,
beside the compiler's `config.ini`. Apply writes that file.
Close does not.

This editor does not open projects, run builds, talk to a language
server, load plugins, or show a message pane or a debugger.
