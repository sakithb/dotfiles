config.load_autoconfig()

c.bindings.default = {}
c.colors.webpage.preferred_color_scheme = "dark"
c.completion.quick = False
c.confirm_quit = ["multiple-tabs", "downloads"]
c.content.autoplay = False
c.content.pdfjs = True
c.downloads.position = "bottom"
c.editor.command = ["nvim", "-c", "normal {line}G{column0}l", "--", "{file}"]
c.fileselect.folder.command = ["terminal-launch", "yazi", "--choosefile={}"]
c.fileselect.multiple_files.command = ["terminal-launch", "yazi", "--choosefile={}"]
c.fileselect.single_file.command = ["terminal-launch", "yazi", "--choosefile={}"]
c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.default_size = "16pt"
c.fonts.web.family.sans_serif = "Noto Sans"
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.fixed = "Noto Sans Mono"
c.fonts.web.family.standard = "Noto Sans"
c.fonts.web.size.default = 16
c.qt.workarounds.disable_hangouts_extension = True
c.tabs.show = "never"
c.url.default_page = "about:blank"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com?q={}",
    "gg": "https://google.com/search?q={}",
    "yt": "https://youtube.com/results?search_query={}",
}
c.url.start_pages = ["about:blank"]

config.source('gruvbox.py')
config.source('bindings.py')
