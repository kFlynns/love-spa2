-- class Camera
local Camera = setmetatable({}, {__index = Entity})
Camera.__index = Camera

-- constructor
function Camera.new()
	local self = setmetatable(Entity.new(), Camera)
  self.target_entity = nil
  self.zoom = 1.0
  self.speed = 0.0
  self.buffer_offset_x = Screen.get_buffer_width() / 2
  self.buffer_offset_y = Screen.get_buffer_height() / 2
	return self
end -- function

-- set entity to follow
function Camera:set_target(entity)
  self.target_entity = entity
end -- function

-- move camera to actual target and translate space
function Camera:start_record()
  love.graphics.push()
  love.graphics.translate(
    -self.position.x + self.buffer_offset_x, 
    -self.position.y + self.buffer_offset_y
  )
  if not self.target_entity then
    return
  end -- if
  local magnitude = self
    .position
    :magnitude(self.target_entity.position)
    
  self.velocity = self.position:normalize(
    self.target_entity.position,
    magnitude
  )
  --[[
  love.graphics.push()
  love.graphics.translate(
    self.buffer_offset_x, 
    self.buffer_offset_y
  )
  
  love.graphics.pop()
  ]]
  love.graphics.rotate(self.target_entity.angle or 0)
  self.speed = math.pow(magnitude / 200, 2) * 1000
  self:__update_physics()
end -- function

-- restore space translation
function Camera:stop_record()
	love.graphics.pop()
end -- function

-- get camera position vector
function Camera:get_position()
  return self.position
end -- function


local camera = Camera.new()
return camera