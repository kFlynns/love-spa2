-- module Space
local Space = {}
Space.__index = Space

local entities = {}

-- add entitiy
function Space.add_entity(entity)
  table.insert(entities, entity)
end

-- remove & free entity
function Space.remove_entity(entity)
  for e = 1, #entities do
    if entities[e] == entity
    then
      entities[e] = nil
      table.remove(entities, e)
      return
    end -- if
  end -- for
end -- function

-- update all stuff
function Space.update_game()
  Camera:update()
  Space.__draw_star_field()
  -- entities
  for e = 1, #entities do
    entities[e]:update()
  end -- for
  Space.__draw_hud()
end -- function


-- draw star background
function Space.__draw_star_field()
  
  local stars_width = 128
  local stars_height = 128
  local camera_position = Camera:get_position()
  
  MediaStore.clear_sprite_batch("stars")
  for y = 0, 380, stars_height do
    for x = 0, 640, stars_width do
      MediaStore.add_to_sprite_batch("stars", 1, x, y)
    end -- for x
  end -- for y
  MediaStore.flush_sprite_batch("stars")
  
  
  love.graphics.setColor(0.2, 0.2, 0.2)
  
  local grid_offset_y = 
    (camera_position.y - Screen.get_buffer_height() / 2) %
    (stars_height / 2)* -1
  local grid_offset_x = 
    (camera_position.x - Screen.get_buffer_width() / 2) %
    (stars_width / 2) * -1
    
  for x = grid_offset_x, Screen.get_buffer_width(), 64 do
    love.graphics.line(x, 0, x, Screen.get_buffer_height())
  end -- for x
  for y = grid_offset_y, Screen.get_buffer_height(), 64 do
    love.graphics.line(0, y, Screen.get_buffer_width(), y)
  end -- for y
  love.graphics.setColor(1,1,1)
  
end -- function

-- draw HUD to buffer
function Space.__draw_hud()
  love.graphics.draw(MediaStore.get_image("hud"), 0, 0)
  
  local player_ship = Player:get_ship()
  if player_ship
  then
    local ship_speed = player_ship:read_instruments()
    love.graphics.print(tostring(ship_speed) .. " km/h", 22, 43)
  end -- if
end -- function

return Space