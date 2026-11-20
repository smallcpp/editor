# Limits

These are places where scpp or the GTK wrapper cannot do what a
desktop editor does. The editor still does the closest real job,
and the unit tests cover that job.

The wrapper has no GtkSourceView and no language-spec directory.
The scanner highlights scpp, and the same scanner also colors C,
C++, cw, Python, shell, and toml. Other files, including Markdown,
stay plain. Tags are foreground colors only. Line numbers are a
gutter of the visible lines. There is no whitespace glyph, newline
mark, indent guide, right-margin line, or current-line background.
The status line shows the line and column from the editor buffer.

Shortcuts use `Widget::add_shortcut`. There is still no key-press
signal on the text view. Menus run the same commands. The text
view keeps GTK's own navigation keys. Copy, cut, indent, and
unindent read the view's selection and then run on the editor
buffer, which also owns undo.

FileDialog picks one path. It has no folder mode and no
multi-select. Tab titles are the file name. The dirty star is on
the status line. There is no per-tab close icon. File, Close
closes the active document. The window shows at most 32 documents.

The wrapper cannot set the font family, the font size, or
wrapping. The editor view is always monospace. The menu row is the
first child of the window because the wrapper has no title-bar
setter.

This editor does not open projects, run builds, talk to a language
server, load plugins, or show a message pane or a debugger.
