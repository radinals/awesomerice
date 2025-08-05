local p = {}

p.terminal = "st"
p.editor = os.getenv("EDITOR") or "vi"
p.editor_cmd = p.terminal .. " -e " .. p.editor
p.powermenu = "dm-power"
p.calculator = "qalculate-gtk"
p.xmouseless = "xmouseless"
p.windowswitcher = "WinSwitcher"
p.runprompt = "dmenu_run -c -i -g 3 -np -bw 1 -l 20 -p 'RUN'"
p.idemenu = "ide-menu"
p.tmux = p.terminal .. " -e " .. "tmux_start"

return p
