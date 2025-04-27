local Window = {}
Window.__index = Window

function Window.new(x, y)
    self = setmetatable({}, Window)
    self.x = x
    self.y = y

    return self
end

function Window:inWindow(inX, inY)
    return (inX < self.x and inY < self.y and inX > 0 and inY > 0)
end

return Window.new(800, 950)