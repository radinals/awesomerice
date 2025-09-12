local p = {}

p.terminal = "st"
p.editor = os.getenv("EDITOR") or "vi"
p.editor_cmd = p.terminal .. " -e " .. p.editor
p.powermenu = "dm-power"
p.calculator = "qalculate-gtk"
p.xmouseless = "xmouseless"
p.windowswitcher = "WinSwitcher"
p.runprompt = "dmenu_run -c -i -g 3 -np -bw 1 -l 20 -p 'RUN'"
p.sound_player = "dm-sounds"
p.tmux = p.terminal .. " -e " .. "tmux_start"
p.screenshot_tool = "dm-screenshot"
p.intelij = "IntelIj-IDE"
p.rider = "RiderIDE-2025.1.1"
p.android_studio = "android-studio"
p.dbeaver = "dbeaver"
p.mysqlworkbench = "mysql-workbench"
p.vscode = "code"
p.godot = 'godot'
-- p.eclipse = "eclipse"

return p
