-- module MediaStore
local MediaStore = {}
MediaStore.__index = MediaStore

local image_font_name = 'font_small'
local image_font_glyphs = " !\"#$%&'()*+,-./0123456789:;<=>?@abcdefghijklmnopqrstuvwxyz[\\]^_"
local image_font
local images = {}
local sprite_batches = {}
local sprite_batch_quads = {}
local sounds = {}


-- clear sprite batch
function MediaStore.clear_sprite_batch(image_name)
  sprite_batches[image_name]:clear()
end -- function

-- flush and draw batch to screen
function MediaStore.flush_sprite_batch(image_name)
  sprite_batches[image_name]:flush()
  -- auto draw?
  love.graphics.draw(sprite_batches[image_name])
end -- function


-- add tile from atlas to sprite batch
-- @param string image_name
-- @param number quad
-- @param number x
-- @param number y
function MediaStore.add_to_sprite_batch(image_name, quad, x, y)
  sprite_batches[image_name]:add(
    sprite_batch_quads[image_name][quad],
    x,
    y
  )
end -- function

-- create sprite batch it if needed
-- @param string image_name
-- @param table[Quad] quads
-- @param string usage
function MediaStore.create_sprite_batch(image_name, quads, usage)
  if not sprite_batches[image_name]
  then
    local sprite_batch = love.graphics.newSpriteBatch(
      MediaStore.get_image(image_name),
      #quads,
      usage or "static"
    )
    sprite_batch_quads[image_name] = quads
    sprite_batches[image_name] = sprite_batch
  end -- if
end -- function


-- return image and load it if needed
-- @param string name
function MediaStore.get_image(name, sprite_batch_size)
  if not images[name]
  then
    images[name] = love.graphics.newImage(string.format(
      'image/%s.png',
      name
    ))
  end -- if
  return images[name]
end -- function


-- e.g. load image font and return it
function MediaStore.get_font()
  if not image_font
  then
    image_font = love.graphics.newImageFont(
      string.format(
        'image/%s.png',
        image_font_name
      ),
      image_font_glyphs
    )
  end -- if
  return image_font
end -- function
   
   
-- return sound and load it if needed
-- @param string name
function MediaStore.get_sound(name)
  if not sounds[name]
  then
    sounds[name] = love.audio.newSource(string.format(
      'sound/%s.mp3',
      name
    ), "static")
    -- images[name]:setFilter
  end -- if
  return sounds[name]
end -- function


-- init MediaStore
function MediaStore.init()
    
    -- todo: refactor
    local stars_width = 128
    local stars_height = 128
    
    -- create sprite batches
    MediaStore.create_sprite_batch(
      "stars", {
        love.graphics.newQuad(
          0, 0,
          stars_width,
          stars_height,
          stars_width,
          stars_height
        ) 
      }
    )
  
end -- function




return MediaStore