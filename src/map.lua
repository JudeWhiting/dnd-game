require("src/cell")

Map = {}
Map.__index = Map

function Map.new(w, h, cs)
  local self = setmetatable({}, Map)
  self.width = w
  self.height = h
  self.cells = {}
  self.cellSize = cs

  for i = 1, self.width do
    table.insert(self.cells, {})
    for j = 1, self.height do
      table.insert(self.cells[i], Cell.new())
    end
  end


  return self
end

function Map:inMap(inX, inY)
  return (inX <= self.width and inY <= self.height and inX >= 1 and inY >= 1)
end

function Map:draw(offsetX, offsetY)
  for i = 1, self.width do
    for j = 1, self.height do
      local currentCell = self.cells[i][j]
      currentCell:draw(i*self.cellSize - self.cellSize + offsetX, j*self.cellSize - self.cellSize + offsetY, self.cellSize)
    end
  end
end