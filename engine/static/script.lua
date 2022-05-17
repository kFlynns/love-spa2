-- module Script
local Script = {}
Script.__index = Script

local step = love.timer.getTime()
local ticker_set_on = 0.0
local ticker_message = nil

local timers = {}


-- set timer
-- @param function callback
-- @param number delay
function Script.timer(callback, delay)
  if not delay
  then
    error("set delay as argument")
  end -- if
  table.insert(timers, {
    execution_time = delay + step,
    f = callback
  })
end -- function


-- send ticker message
-- @param string message
function Script.ticker(message)
  ticker_message = message
  ticker_set_on = step
  love.audio.play(MediaStore.get_sound("ticker_beep"))
end -- function


-- update game's scripting engine
-- @param int time
function Script.update()

  step = love.timer.getTime()
  
  -- clear old ticker messages
  if ticker_message and step - ticker_set_on > 5
  then
    ticker_message = nil
    ticker_set_on = 0.0
  end -- if

  -- execute timers
  local removed_offset = 0
  for i = 1, #timers, 1 do
    if timers[i - removed_offset].execution_time < step
    then
      timers[i - removed_offset].f()
      timers[i - removed_offset] = nil
      table.remove(timers, i)
      removed_offset = removed_offset + 1
    end -- if
  end -- for
  
  Script.__draw()
  
end -- function


-- draw all stuff that needs to
function Script.__draw()
  
  if ticker_message and math.floor(step * 2) % 2 == 0
  then
    love.graphics.print(ticker_message, 130, 11)
  end -- if
end -- function

return Script