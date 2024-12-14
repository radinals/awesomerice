return {
  increaseBrightness  =  function(n) os.execute("brightnessctl s ".. n .."%+") end,
  decreaseBrightness  =  function(n) os.execute("brightnessctl s ".. n .."%-") end,
  increaseAudioVolume =  function(n) os.execute("pactl set-sink-volume @DEFAULT_SINK@ +" .. n .. "%") end,
  decreaseAudioVolume =  function(n) os.execute("pactl set-sink-volume @DEFAULT_SINK@ -" .. n .. "%") end,
  toggleAudioMute     =  function()  os.execute("pactl set-sink-mute @DEFAULT_SINK@ toggle") end
}
