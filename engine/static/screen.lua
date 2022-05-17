-- module Screen
local Screen = {}
Screen.__index = Screen

local window_width
local window_height
local buffer_width = 640
local buffer_height = 380
local buffer
local shader
  
-- create frame buffer
-- @param number width
-- @param number height
function Screen.init(width, height)
  window_width = width
  window_height = height
  if not buffer
  then
    buffer = love.graphics.newCanvas(buffer_width, buffer_height)
  end -- if
end -- function

-- begin frame
function Screen.begin()
  love.graphics.setCanvas(buffer)
end -- function

-- print buffer to screen
function Screen.flip()
  love.graphics.setCanvas()
  love.graphics.draw(buffer, 0, 0, 0, window_width / buffer_width, window_height / buffer_height)
end -- function

-- get the width of the screen buffer
function Screen.get_buffer_width()
  return buffer_width
end -- function

-- get the height of the screen buffer
function Screen.get_buffer_height()
  return buffer_height
end -- function

return Screen