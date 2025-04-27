Cell = {}
Cell.__index = Cell

function Cell.new()
    self = setmetatable({}, Cell)
    self.contents = nil

    return self
end

function Cell:draw(x, y, size)
    if self.contents == nil then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", x, y, size, size)
    else
        love.graphics.setColor(self.contents.color)
        love.graphics.rectangle("fill", x, y, size, size)
    end
end