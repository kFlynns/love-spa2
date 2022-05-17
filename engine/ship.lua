-- class Ship
local Ship = setmetatable({}, {__index = Entity})
Ship.__index = Ship

-- ship model data
local ship_models = {
  swallow = {
    mass = 250,
    angular_damping = 0.2,
    linear_damping = 0.1,
    engine_force = 20000.0,
    brake_force = 10000.0,
    torge_force = 800.0,
    quick_travel_factor = 3.0
  },
  eagle =  {
    mass = 150,
    angular_damping = 0.2,
    linear_damping = 0.2,
    engine_force = 60000.0,
    brake_force = 20000.0,
    torge_force = 800.0,
    quick_travel_factor = 6.0
  },
}

-- constructor
-- @param string ship_model
function Ship.new(ship_model, x, y)
  
  if not ship_models[ship_model]
  then
    error("ship model \"" .. ship_model .. "\" is unknown.")
  end -- if
  
	local self = setmetatable(Entity.new(x or 0, y or 0), Ship)
  self:set_sprite(
    ship_model, -- image/{name}.png
    true -- has physics
  )
  
  local m = ship_models[ship_model]
  local body = self.physics.body
  body:setMass(m.mass)
  body:setAngularDamping(m.angular_damping)
  body:setLinearDamping(m.linear_damping)
  
  self.engine_force = m.engine_force
  self.brake_force = m.brake_force
  self.torge_force = m.torge_force
  self.quick_travel_factor = m.quick_travel_factor
  self.pilot = nil
	return self
  
end -- function


-- update ship
function Ship:update()
  if self.pilot
  then
    self:__control()
  end --if
  -- draw here because update is overridden
  self.sprite:draw(self)
  self:__update_physics()
end


-- let pilot enter this ship
-- @param Pilot pilot
function Ship:pilot_enter(pilot)
  pilot:leave_ship()
  self.pilot = pilot
  self.pilot:enter_ship(self)
end -- function

-- let pilot leaves this ship
function Ship:pilot_leave()
  self.pilot = nil
end -- function


-- take pilot input
-- @param table ship_input
function Ship:__control()

  local ship_input = self.pilot.get_commands()
  local body = self.physics.body
  local angle = body:getAngle()
  
  body:applyTorque(self.torge_force * ship_input.torge)

  if ship_input.shift_left
  then
    body:applyLinearImpulse(math.cos(angle + 1.57) * 22, math.sin(angle + 1.57) * 22)
  end -- if
  
  if ship_input.shift_right
  then
    body:applyLinearImpulse(math.cos(angle - 1.57) * 22, math.sin(angle - 1.57) * 22)
  end -- if
  
  
  local quick_travel = ship_input.quick_travel * self.quick_travel_factor
  if quick_travel == 0
  then
    quick_travel = 1.0
  end -- if
  
  if ship_input.accelerate
  then
    
    local engine_sound = MediaStore.get_sound("engine")
    if quick_travel > 1.0
    then
      engine_sound = MediaStore.get_sound("engine_full")
    end -- if
    if not engine_sound:isPlaying()
    then
      love.audio.play(engine_sound)
    end -- if
    
    body:applyForce(
      math.cos(angle) * self.engine_force * quick_travel,
      math.sin(angle) * self.engine_force * quick_travel
    )
  end -- if
  
  if ship_input.brake
  then
    body:applyForce(
      math.cos(angle) * self.brake_force * -1 * quick_travel,
      math.sin(angle) * self.brake_force * -1 * quick_travel
    )
  end -- if
  
end -- function



function Ship:read_instruments()
  local traveled_distance = 0
  local time_gone = 0
  if self.last_position
  then
    traveled_distance = self.last_position:magnitude(self.position) / 16
    time_gone = love.timer.getTime() - self.last_step
  else

  end -- if
  self.last_step = love.timer.getTime()
  self.last_position = Vec2.new(
    self.position.x,
    self.position.y
  )
  
  return math.floor(traveled_distance / time_gone * 3.6)
  
end -- function

return Ship