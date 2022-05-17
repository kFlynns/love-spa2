-- class Camera
local Camera = setmetatable({}, {__index = Entity})
Camera.__index = Camera

-- constructor
function Camera.new()
	local self = setmetatable(Entity.new(), Camera)
  self.target_entity = nil
  self.zoom = 1.0
  self.speed = 0.0
	return self
end -- function

-- set entity to follow
function Camera:set_target(entity)
  self.target_entity = entity
end -- function

-- move camera to actual target
function Camera:update()
  if not self.target_entity
  then
    return
  end -- if
  local magnitude = self
    .position:magnitude(self.target_entity.position)
  self.velocity = self.position:normalize(
    self.target_entity.position,
    magnitude
  )
  self.speed = math.pow(magnitude / 200, 2)
  self:__update_physics()
end -- function

-- get camera position vector
function Camera:get_position()
  return self.position
end -- function


local camera = Camera.new()
return camera