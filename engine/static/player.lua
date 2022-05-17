-- module Player
local Player = setmetatable({}, {__index = Pilot})
Player.__index = Player

-- the player is a pilot, reach inputs from HID to ship
function Player:get_commands()
  return InputHub.get_ship_input()
end -- function

-- return ship if player sits in a ship, otherwise false
function Player:get_ship()
  if not self.ship
  then
    return false
  end -- if
  return self.ship
end -- function

return Player