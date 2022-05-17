-- class Pilot
local Pilot = {}
Pilot.__index = Pilot

-- constructor
function Pilot.new()
  local self = {
    ship = nil
  }
  setmetatable(self, Pilot)
  return self
end -- function

-- ships asks here for commands
-- this method must be overridden by a real pilot
function Pilot:get_commands()
  return {
    acclerate = false,
    brake = false,
    torge = 0.0,
    shift_left = false,
    shift_right = false,
    quick_travel = 0.0
  }
end -- function

-- set ship if pilot enter
function Pilot:enter_ship(ship)
  self.ship = ship
end -- function

-- leave ship if pilot has one
function Pilot:leave_ship()
  if self.ship == nil
  then
    return
  end -- if
  self.ship:pilot_leave()
end -- function

return Pilot
