-- module Radio
local Radio = {}
Radio.__index = Radio

-- start music
-- @param string song
function Radio.play(song)
  local song =  MediaStore.get_sound(song)
  love.audio.play(song)
end -- function

return Radio