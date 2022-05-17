-- class Entity
local Entity = {}
Entity.__index = Entity

-- debug printing
function Entity:__tostring()
  return string.format(
    "speed: %f, x: %f, y: %f, vx: %f, vy: %f",
    self.speed, self.position.x, self.position.y,
    self.velocity.x, self.velocity.y
  )
end -- function

-- construct
function Entity.new(x, y)
  local self = {
    physics = nil,
    position = Vec2.new(),
    velocity = Vec2.new(),
    speed = 0,
    angle = 0
  }
  self.position.x = x or 0
  self.position.y = y or 0
  setmetatable(self, Entity)
  Space.add_entity(self)
  return self
end -- function

-- remove entity from game loop
function Entity:destroy()
  Space.remove_entity(self)
end -- function

-- translate entity
function Entity:__update_physics()
  if self:is_physics_body()
  then
    -- box2d
    self.angle = self.physics.body:getAngle()
    self.position.x = self.physics.body:getX()
    self.position.y = self.physics.body:getY()
  else
    -- own 2d vector
    self.position = self.position + (self.velocity * self.speed)
  end
end -- function

-- update entity instance
function Entity:update()
  if self.sprite
  then
    self.sprite:draw(self)
  end -- if
  self:__update_physics()
end -- function

-- returns true if entity is a physics body
function Entity:is_physics_body()
  return self.physics ~= nil
end -- function


-- make entity visible
-- @param string name
function Entity:set_sprite(name, has_physics)
  self.sprite = Sprite.new(name)
  if has_physics or false
  then
    self.physics = {}
    self.physics.body = love.physics.newBody(
      Physics,
      self.position.x,
      self.position.y,
      "dynamic"
    )
    -- free Vec2d object for performance
    self.position = {
      x = self.physics.body:getX(),
      y = self.physics.body:getY()
    }
    self.physics.shape = love
      .physics
      .newCircleShape(self.sprite.image:getWidth() / 2)
    self.physics.fixture = love
      .physics
      .newFixture(self.physics.body, self.physics.shape, 1)
  end -- if
end -- function


return Entity