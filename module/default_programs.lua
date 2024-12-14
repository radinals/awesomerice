local program = {}

program.terminal = "st"
program.editor = os.getenv("EDITOR") or "vi"
program.editor_cmd = program.terminal .. " -e " .. program.editor
program.powermenu = "dm-power"
program.calculator = "qalculate-gtk"
program.xmouseless = "xmouseless"
program.windowswitcher = "WinSwitcher"
program.runprompt = "dmenu_run -c -i -g 3 -bw 1 -l 20 -p 'RUN:'"
program.eclipse = "eclipse"
program.tmux = program.terminal .. " -e " .. "tmux_start"

return program
