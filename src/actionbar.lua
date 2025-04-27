local ActionBar = {}
ActionBar.__index = ActionBar

function ActionBar.new()
    local self = setmetatable({}, ActionBar)
    self.width = 16
    self.height = 2
end