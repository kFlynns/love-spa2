#!/usr/bin/env lua
require 'symbols'
local width, height = 1280, 1280 / 16 * 9
local video
local game_state

-- load event
function love.load()
  
  love.window.setTitle('Space Patrol Aviator 2')
  love.window.setMode(width, height, {
    resizable = true,
    vsync = true,
    msaa = 0,
    fullscreen = false
  })

  love.graphics.setLineStyle("rough")
  love.graphics.setBackgroundColor(47 / 255, 5 / 255, 53 / 255)
  love.graphics.setDefaultFilter("linear", "nearest", 0)
  Screen.init(width, height)
  MediaStore.init()
  
  love.graphics.setFont(MediaStore.get_font())
  love.physics.setMeter(16)
  
  video = love.graphics.newVideo("video/quokka_splash.ogv")
  video:play()
  game_state = 'game'
  Story.load("test_start")
  
end -- function


-- window was reseized - update screen size
function love.resize(new_width, new_height)
  width = new_width
  height = new_height
  Screen.init(new_width, new_height)
end -- function


-- update world
function love.update(delta)
  InputHub.update()
  Physics:update(delta)
end -- function


-- draw event
function love.draw()
  Screen.begin()
  if game_state == 'video'
  then
    love.graphics.draw(video, 0, 10, 0, 0.5)
    if not video:isPlaying()
    then
      game_state = 'game'
    end -- if
  elseif game_state == 'game'
  then
    Space.update_game()
  end -- if
  Script.update()
  Screen.flip()
end -- function
