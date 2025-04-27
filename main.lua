
local myWindow = require("src/window")
local Movement = require("src/movement")

require("src/map")
local myMap = Map.new(16, 16, 50)
local myBar = Map.new(16, 2, 50)

require("src/player")
local myPlayer = Player.new(2, 6)
myPlayer:putOnMap(myMap)
local myObject = Player.new(9, 9)
myObject:putOnMap(myMap)

local mouse = {x = nil, y = nil, gridX = nil, gridY = nil}

function love.load()
  love.window.setMode(myWindow.x, myWindow.y)
end

function love.update(dt)
  mouse.x, mouse.y = love.mouse.getPosition()
  mouse.gridX = math.floor(mouse.x/myMap.cellSize) + 1
  mouse.gridY = math.floor(mouse.y/myMap.cellSize) + 1

  if myWindow:inWindow(mouse.x, mouse.y) then
    path, totalCost = Movement.findPath(myMap.cells, myPlayer.x, myPlayer.y, mouse.gridX, mouse.gridY)
    print(totalCost)
  end
  
end

function love.mousepressed(_, _, btn)
  if btn ~= 1 then
    return
  end

  local validNode

  if myMap:inMap(mouse.gridX, mouse.gridY) and myMap.cells[mouse.gridX][mouse.gridY].contents == nil then
    for _, node in ipairs(path) do
      if node.c <= myPlayer.rspeed then
        validNode = node
      else
        break
      end
    end
    myPlayer:movePlayer(myMap, validNode.x, validNode.y)
  end

end

function love.draw()

  Movement.drawPath(path, myPlayer, myMap.cellSize)

  myMap:draw(0, 0)

  myBar:draw(0, 850)

  

  

end

