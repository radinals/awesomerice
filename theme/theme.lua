local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local hotkeys_popup = require("awful.hotkeys_popup")
local keys   = require("module.keys")
local menubar = require("menubar")
local defaults = require("module.default_programs")

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/theme"
theme.wallpaper                                 = theme.dir .. "/wp.png"
theme.font                                      = "Droid Sans 9"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#EA6F81"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#1A1A1A"
theme.bg_focus                                  = "#313131"
theme.bg_urgent                                 = "#1A1A1A"
theme.border_width                              = dpi(1)
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#7F7F7F"
theme.border_marked                             = "#CC9393"
theme.tasklist_bg_focus                         = "#1A1A1A"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
--theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
--theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
--theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
--theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
--theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
--theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
--theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
--theme.layout_max                                = theme.dir .. "/icons/max.png"
--theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
--theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
-- theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
-- theme.widget_battery                            = theme.dir .. "/icons/battery.png"
-- theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
-- theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
-- theme.widget_mem                                = theme.dir .. "/icons/mem.png"
-- theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
-- theme.widget_temp                               = theme.dir .. "/icons/temp.png"
-- theme.widget_net                                = theme.dir .. "/icons/net.png"
-- theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
-- theme.widget_music                              = theme.dir .. "/icons/note.png"
-- theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
-- theme.widget_vol                                = theme.dir .. "/icons/vol.png"
-- theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
-- theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
-- theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
-- theme.widget_mail                               = theme.dir .. "/icons/mail.png"
-- theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = dpi(3)
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

theme.notification_font = "monospace 10"
theme.notification_bg = "#202020"
theme.notification_fg = theme.fg_normal
theme.notification_border_width = dpi(16)
theme.notification_shape = gears.shape.rounded_rect
theme.notification_border_color = "#FFFFFF"
theme.notification_max_width = dpi(300)
theme.notification_max_height = dpi(80)

theme.set_wallpaper = function(s)
  -- Wallpaper
  if theme.wallpaper then
    local wallpaper = theme.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

local getWidget = function (widget, ...)
  local success, mywidget = pcall(require, widget)
  if (success) then
    return mywidget{...}
  else
    return wibox.widget.textbox("[ERROR]")
  end
end

-- Create a textclock widget
local separator = wibox.widget.textbox("   ")

local clock_widget = wibox.widget{
  format = '%a %b %d, %H:%M',
  font = theme.font,
  widget = wibox.widget.textclock,
  fg = accent_color,
}

local battery_widget = getWidget("theme.awesome-wm-widgets.battery-widget.battery",{ show_current_level=true })
local cmus_widget = getWidget("theme.awesome-wm-widgets.cmus-widget.cmus")

awful.util.tagnames = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" }

theme.at_screen_connect = function(s)
  -- Wallpaper
  theme.set_wallpaper(s)
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
  -- Each screen has its own tag table.

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)

  s.mylayoutbox:buttons(
    gears.table.join(
      awful.button({ }, 1, function () awful.layout.inc( 1) end),
      awful.button({ }, 3, function () awful.layout.inc(-1) end),
      awful.button({ }, 4, function () awful.layout.inc( 1) end),
      awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = keys.taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = keys.tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
      s.mylayoutbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      separator,
      cmus_widget,
      separator,
      battery_widget,
      separator,
      clock_widget,
    },
  }

end

theme.awesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", defaults.terminal .. " -e man awesome" },
  { "edit config", defaults.editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

theme.mainmenu = awful.menu({ items = {
    { "awesome", theme.awesomemenu, theme.awesome_icon },
    { "open terminal", defaults.terminal }
  }
})

menubar.utils.terminal = defaults.terminal -- Set the terminal for applications that require it

return theme
