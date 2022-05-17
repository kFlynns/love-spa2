-- module InputHub
local InputHub = {}
InputHub.__index = InputHub

-- all connected joysticks
local joysticks = love.joystick.getJoysticks()

-- pilot infos for ships
local ship_input = {
  accelerate = false,
  brake = false,
  torge = 0.0,
  shift_left = false,
  shift_right = false,
  quick_travel = 0.0
}

-- called from game loop
function InputHub.update()
  
  -- reset ship inputs
  ship_input = {
    accelerate = false,
    brake = false,
    torge = 0.0,
    shift_left = false,
    shift_right = false,
    quick_travel = 0.0
  }
  InputHub.__handle_Hids_for_ships()
  
end -- function


-- event if joystick added durring game - read new
function love.joystickadded()
  joysticks = love.joystick.getJoysticks()
end -- function


-- take input from all gamepads / joysticks and keyboards
function InputHub.__handle_Hids_for_ships()
  
  -- for i = 1, #joysticks do
  
    -- local joystick = joysticks[1]
    
    -- rotate left
    -- local left_trigger = joystick:getGamepadAxis("triggerleft")
    local left_trigger = 0
    if love.keyboard.isDown("a")
    then
      left_trigger = 1.0
    end -- if
    if left_trigger > .1
    then
      ship_input.torge = left_trigger * -1
    end -- if
    
    -- rotate right
    -- local right_trigger = joystick:getGamepadAxis("triggerright")
    local right_trigger = 0
    if love.keyboard.isDown("d")
    then
      right_trigger = 1.0
    end -- if
    if right_trigger > .1
    then
      ship_input.torge = right_trigger
    end -- if
    
    -- shift left / right
    -- if joystick:isGamepadDown("leftshoulder") or love.keyboard.isDown("q")
    if love.keyboard.isDown("q")
    then
      ship_input.shift_left = true
    end -- if
    -- if joystick:isGamepadDown("rightshoulder") or love.keyboard.isDown("e")
    if love.keyboard.isDown("e")
    then
      ship_input.shift_right = true
    end -- if
      
    -- quick travel
    -- if joystick:isGamepadDown("dpdown") or love.keyboard.isDown("space")
    if love.keyboard.isDown("space")
    then
      ship_input.quick_travel = 1.0
    end -- if
    -- speed up / down
    -- if joystick:isGamepadDown("a") or love.keyboard.isDown("w")
    if love.keyboard.isDown("w")
    then
      ship_input.accelerate = true
    end -- if
    -- if joystick:isGamepadDown("b") or love.keyboard.isDown("s")
    if love.keyboard.isDown("s")
    then
      ship_input.brake = true
    end -- if
    
  -- end -- for
  
end -- function



-- get infos for ships
function InputHub.get_ship_input()
  return ship_input
end -- function


return InputHub
