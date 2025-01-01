local awful = require("awful")
local gears = require("gears")
local M = require("module.keybindings.modkeys")

local keybindings = {}

local function generateKeyTable(module)
  local bindings = require(module)
  local t = {}
  for _, keys in ipairs(bindings) do
    local group = keys.group
    for _, binding in ipairs(keys.bindings) do -- Correctly use `keys.bindings`
      if binding.button then
          t = gears.table.join( t,
            awful.button(binding.mod, binding.button, binding.press, nil)
          )
      else
        if binding.description then
          t = gears.table.join( t, awful.key(binding.mod, binding.key, binding.press, {description = binding.desc, group = group}))
        else
          t = gears.table.join( t, awful.key(binding.mod, binding.key, binding.press, {group = group}) )
        end
      end
    end
  end
  return t
end

keybindings.globalkeys = generateKeyTable("module.keybindings.globalkeys")
keybindings.clientkeys = generateKeyTable("module.keybindings.clientkeys")
keybindings.taglist_buttons = generateKeyTable("module.keybindings.taglistbuttons")
keybindings.mousebindings = generateKeyTable("module.keybindings.mousebuttons")
keybindings.tasklist_buttons = generateKeyTable("module.keybindings.tasklistbuttons")
keybindings.clientbuttons = generateKeyTable("module.keybindings.clientbuttons")

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
