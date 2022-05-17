-- class Vec2
local Vec2 = {}
Vec2.__index = Vec2

-- constructor
function Vec2.new(x, y)
  local self = {
    x = x or 0,
    y = y or 0
  }
  setmetatable(self, Vec2)
  return self
end -- function

-- convert tables and numbers to tables
function Vec2:create_table_from(value)
  if type(value) == 'number'
  then
    x = value
    y = value
  else
    x = value.x
    y = value.y
  end
  return {
    x = x,
    y = y
  }
end -- function

-- addition
function Vec2:__add(value)
  local value = Vec2:create_table_from(value)
  return Vec2.new(
    self.x + value.x,
    self.y + value.y
  )
end -- function

-- subtraction
function Vec2:__sub(value)
  local value = Vec2:create_table_from(value)
  return Vec2.new(
    self.x - value.x,
    self.y - value.y
  )
end -- function

-- multiplication
function Vec2:__mul(value)
  local value = Vec2:create_table_from(value)
  return Vec2.new(
    self.x * value.x,
    self.y * value.y
  )
end -- function

-- division
function Vec2:__div(value)
  local value = Vec2:create_table_from(value)
  return Vec2.new(
    self.x / value.x,
    self.y / value.y
  )
end -- function

-- distance to another 2d vector
function Vec2:magnitude(vec2)
  return math.sqrt(
    math.pow(
      vec2.x - self.x,
      2
    ) + math.pow(
      vec2.y - self.y,
      2
    )
  )
end -- function

function Vec2:normalize(vec2, magnitude)
  local m = magnitude
  if not magnitude
  then
    m = self:magnitude(vec2);
  end -- if
  if m > 0
  then
    return Vec2.new(
      (vec2.x - self.x) / m,
      (vec2.y - self.y) / m
    )
  end -- if
  return Vec2.new(0, 0)
end -- function

-- print
function Vec2:__tostring()
  return "x: " .. self.x .. ", y: " .. self.y
end -- function

return Vec2