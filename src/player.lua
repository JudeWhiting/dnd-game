Player = {}
Player.__index = Player

function Player.new(x, y)
  local self = setmetatable({}, Player)
  self.x = x
  self.y = y
  self.speed = 12
  self.rspeed = 12
  self.color = {0, 1, 0}

  return self
end

function Player:putOnMap(map)
  map.cells[self.x][self.y].contents = self
end

function Player:movePlayer(map, newX, newY)
  map.cells[self.x][self.y].contents = nil
  self.x = newX
  self.y = newY
  self:putOnMap(map)
end