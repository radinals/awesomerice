
local naughty = require("naughty")

return {
  increaseBrightness        =  function(n) os.execute("brightnessctl s ".. n .."%+") end,
  decreaseBrightness        =  function(n) os.execute("brightnessctl s ".. n .."%-") end,

  increaseAudioVolume       =  function(n) os.execute("pactl set-sink-volume @DEFAULT_SINK@ +" .. n .. "%") end,
  decreaseAudioVolume       =  function(n) os.execute("pactl set-sink-volume @DEFAULT_SINK@ -" .. n .. "%") end,
  toggleAudioMute           =  function()  os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,

  cmusNextTrack             =  function()  os.execute("cmus-remote --next") end,
  cmusPrevTrack             =  function()  os.execute("cmus-remote --prev") end,

  cmusPlayTrack             =  function()  os.execute("cmus-remote --play") end,
  musPauseTrack             =  function()  os.execute("cmus-remote --pause") end,
  cmusStopTrack             =  function()  os.execute("cmus-remote --stop") end,

  cmusRepeatTrack           =  function()  os.execute("cmus-remote --repeat") end,
  cmusShuffleTrack          =  function()  os.execute("cmus-remote --shuffle") end,

  cmusVolumeIncrease        =  function()  os.execute("cmus-remote --volume +1%") end,
  cmusVolumeDecrease        =  function()  os.execute("cmus-remote --volume -1%") end,

  toggle_notifications = function ()
          if (naughty.is_suspended()) then
            naughty.toggle();
            naughty.notify{
              title = "Notifications Settings Changed",
              text = "Enabling Notifications"
            }
            else
            naughty.notify{
              title = "Notifications Settings Changed",
              text = "Disabling Notifications"
            }
            naughty.toggle();
          end
        end,

}
