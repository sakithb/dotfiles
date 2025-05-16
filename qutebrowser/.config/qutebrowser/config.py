config.load_autoconfig()
config.source('gruvbox.py')

#config.bind()

c.colors.webpage.preferred_color_scheme = "dark"
c.confirm_quit = ["multiple-tabs", "downloads"]
c.content.autoplay = False
c.content.pdfjs = True
c.downloads.position = "bottom"
c.fileselect.folder.command = ["terminal-launch", "ranger", "--choosedir={}"]
c.fileselect.multiple_files.command = ["terminal-launch", "ranger", "--choosefiles={}"]
c.fileselect.single_file.command = ["terminal-launch", "ranger", "--choosefile={}"]
c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.default_size = "16pt"
c.fonts.web.family.sans_serif = "Noto Sans"
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.fixed = "Noto Sans Mono"
c.fonts.web.family.standard = "Noto Sans"
c.fonts.web.size.default = 16
c.qt.workarounds.disable_hangouts_extension = True
c.scrolling.smooth = True
c.tabs.position = "left"
c.tabs.width = "30%"
c.tabs.show = "switching"
