-- class Sprite
local Sprite = {}
Sprite.__index = Sprite

local Json = require 'engine/vendor/json'
local MediaStore = require 'engine/static/mediastore'

-- construtor
-- @param string name
function Sprite.new(name)
  local self = {
    display_x = 0,
    display_y = 0,
    image = MediaStore.get_image(name),
    aesprite_meta = Json:decode(love.filesystem.read(string.format(
      "aesprite/%s.json",
      name
    )))
  }
  self.image_offset_x = self.image:getWidth() / 2
  self.image_offset_y = self.image:getHeight() / 2
  self.screen_offset_x = Screen.get_buffer_width() / 2
  self.screen_offset_y = Screen.get_buffer_height() / 2 
  setmetatable(self, Sprite)
  return self
end -- function


-- draw sprite an canvas
-- @param Entity entity
function Sprite:draw(entity)
  
  local camera_position = Camera:get_position()
  self.display_x = entity.position.x - camera_position.x + self.screen_offset_x
  self.display_y = entity.position.y - camera_position.y + self.screen_offset_y
  love.graphics.draw(
    self.image,
    self.display_x,
    self.display_y,
    entity.angle,
    1,
    1,
    self.image_offset_x,
    self.image_offset_y
  )
end -- function

return Sprite