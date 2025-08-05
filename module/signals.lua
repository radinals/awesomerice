local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local manageClient = function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end
  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end

end

local iconPath = "/usr/share/icons/gnome/256x256/"

local fallbackIcons = function(c)
    local cairo = require("lgi").cairo
    local default_icon = iconPath.."apps/utilities-terminal.png"
    if c and c.valid and not c.icon then
        local s = gears.surface(default_icon)
        local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
        local cr = cairo.Context(img)
        cr:set_source_surface(s, 0, 0)
        cr:paint()
        c.icon = img._native
    end
end

local at_titlebar_request = function(c)
  print("INREQ")
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      c:emit_signal("request::activate", "titlebar", {raise = true})
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c) : setup {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
      { -- Title
        align  = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton (c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton   (c),
      awful.titlebar.widget.ontopbutton    (c),
      awful.titlebar.widget.closebutton    (c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end

return {

  {
    call = screen.connect_signal,
    signal="property::geometry",
    callback=function(s) beautiful.set_wallpaper(s) end
  },

  {
    call = awful.screen.connect_for_each_screen,
    signal=nil,
    callback= function(s) beautiful.at_screen_connect(s) end
  },

  {
    call = client.connect_signal,
    signal="manage",
    callback=function (c) manageClient(c) end
  },

  {
    call = client.connect_signal,
    signal="focus",
    callback=function(c) c.border_color = beautiful.border_focus end
  },

  {
    call = client.connect_signal,
    signal="unfocus",
    callback=function(c) c.border_color = beautiful.border_normal end
  },

  {
    call = client.connect_signal,
    signal="request::titlebars",
    callback=function(c) at_titlebar_request(c) end
  },

  {
    call = client.connect_signal,
    signal = "manage",
    callback = function (c) fallbackIcons(c) end
  }

}
