local awful = require("awful")
local gears = require("gears")
local M = require("module.modkeys")

local keybindings = {}

local function generateKeyTable(module)
  local bindings = require(module)
  local t = {}
  for _, keys in ipairs(bindings) do
    local group = keys.group
    for _, binding in ipairs(keys.bindings) do -- Correctly use `keys.bindings`
      if binding.button then
        if binding.press and bindings.release then
          t = gears.table.join( t,
            awful.button(binding.mod, binding.button, bindings.press, binding.release)
          )
        elseif bindings.release then
          t = gears.table.join( t,
            awful.button(binding.mod, binding.button, nil, binding.release)
          )
        else
          t = gears.table.join( t,
            awful.button(binding.mod, binding.button, binding.press, nil)
          )
        end
      else
        t = gears.table.join( t,
          awful.key(binding.mod, binding.key, binding.action, {description = binding.desc, group = group}
          )
        )
      end
    end
  end
  return t
end

keybindings.globalkeys = generateKeyTable("module.bindings")
keybindings.clientkeys = generateKeyTable("module.clientkeys")
keybindings.taglist_buttons = generateKeyTable("module.taglistbuttons")
keybindings.mousebindings = generateKeyTable("module.mousebuttons")
keybindings.tasklist_buttons = generateKeyTable("module.tasklistbuttons")
keybindings.clientbuttons = generateKeyTable("module.clientbuttons")

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