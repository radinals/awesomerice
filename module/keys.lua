local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local M = require("module.modkeys")

local keybindings = {}

local bindings = require("module.bindings")

for _, keys in ipairs(bindings) do
  local group = keys.group
  for _, binding in ipairs(keys.bindings) do
    keybindings.globalkeys = gears.table.join(
      keybindings.globalkeys,
      awful.key(
        binding.mod, binding.key, binding.action,
        {description = binding.desc, group=group}
      )
    )
  end
end

keybindings.mousebindings = gears.table.join(
  awful.button({ }, 3, function () beautiful.mainmenu:toggle() end),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
)

keybindings.clientkeys = gears.table.join(
  awful.key({ M.MOD,           }, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),

  awful.key({ M.MOD, M.SHIFT   }, "c",      function (c) c:kill()                         end,
    {description = "close", group = "client"}),

  awful.key({ M.MOD, M.CONTROL }, "space",  awful.client.floating.toggle                     ,
    {description = "toggle floating", group = "client"}),

  awful.key({ M.MOD, M.CONTROL }, "Return", function (c) c:swap(awful.client.getmaster()) end,
    {description = "move to master", group = "client"}),

  awful.key({ M.MOD,           }, "o",      function (c) c:move_to_screen()               end,
    {description = "move to screen", group = "client"}),

  awful.key({ M.MOD,           }, "t",      function (c) c.ontop = not c.ontop            end,
    {description = "toggle keep on top", group = "client"}),

  awful.key({ M.MOD,           }, "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end ,
    {description = "minimize", group = "client"}),

  awful.key({ M.MOD,           }, "m",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end ,
    {description = "(un)maximize", group = "client"}),

  awful.key({ M.MOD, M.CONTROL }, "m",
    function (c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end ,
    {description = "(un)maximize vertically", group = "client"}),

  awful.key({ M.MOD, M.SHIFT   }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end ,
    {description = "(un)maximize horizontally", group = "client"})
)


keybindings.taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),

  awful.button({ M.MOD }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),

  awful.button({ }, 3, awful.tag.viewtoggle),

  awful.button({ M.MOD }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),

  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

keybindings.tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
      "request::activate",
      "tasklist",
      {raise = true}
      )
    end
  end),

  awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),

  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
  end),

  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
  end)
)

keybindings.clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ M.MOD }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ M.MOD }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  keybindings.globalkeys = gears.table.join(keybindings.globalkeys,
    -- View tag only.
    awful.key({ M.MOD }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ M.MOD, M.CONTROL }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ M.MOD, M.SHIFT }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ M.MOD, M.CONTROL, M.SHIFT }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

return keybindings
