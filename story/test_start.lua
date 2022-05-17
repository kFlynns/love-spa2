local Section = {}


function Section.run()
  
  local player_ship_b = Ship.new("eagle", 100, 100)
  local player_ship_b = Ship.new("eagle", 130, 100)
  local player_ship_b = Ship.new("eagle", 160, 100)
  local player_ship = Ship.new("swallow")
 
  Script.timer(function()
    Camera:set_target(player_ship)
    player_ship:pilot_enter(Player)
    Radio.play("music_menu")
    Script.ticker("press x to accelerate, b to brake ...")
  end, 5)

  Script.timer(function()
    Script.ticker("... dpad down for quick travel mode ...")
  end, 10)
  
  Script.timer(function()
    Script.ticker("... shoulder axis for turning ...")
  end, 15)
  
  Script.timer(function()
    Script.ticker("... and left / right trigger for strafe.")  
  end, 20)
  
  Script.timer(function()
    Script.ticker("let's change the ship, commander")  
    player_ship_b:pilot_enter(Player)
    Camera:set_target(player_ship_b)
  end, 25)

end -- function


return Section
