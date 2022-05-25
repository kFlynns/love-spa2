-- class Sprite
local Sprite = {}
Sprite.__index = Sprite

local Json = require 'engine/vendor/json'
local MediaStore = require 'engine/static/mediastore'

-- construtor
-- @param string name
function Sprite.new(name)
  local self = {
    image = MediaStore.get_image(name),
    aesprite_meta = Json:decode(love.filesystem.read(string.format(
      "aesprite/%s.json",
      name
    )))
  }
  self.image_offset_x = self.image:getWidth() / 2
  self.image_offset_y = self.image:getHeight() / 2
  setmetatable(self, Sprite)
  return self
end -- function


-- draw sprite an canvas
-- @param Entity entity
function Sprite:draw(entity)
  love.graphics.draw(
    self.image,
    entity.position.x,
    entity.position.y,
    entity.angle,
    1,
    1,
    self.image_offset_x,
    self.image_offset_y
  )
end -- function

return Sprite