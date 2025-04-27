
local Movement = {}
Movement.adj = 2
Movement.diag = 3

function Movement.findPath(grid, startX, startY, goalX, goalY)
    local width = #grid[1]
    local height = #grid

    -- Cost to reach each cell
    local cost = {}
    local cameFrom = {}
    for x = 1, height do
        cost[x] = {}
        cameFrom[x] = {}
        for y = 1, width do
            cost[x][y] = math.huge
        end
    end

    -- Directions with new costs
    local directions = {
        {dx=0, dy=1, cost=2},     -- Down
        {dx=1, dy=0, cost=2},     -- Right
        {dx=0, dy=-1, cost=2},    -- Up
        {dx=-1, dy=0, cost=2},    -- Left
        {dx=1, dy=1, cost=3},     -- Down-Right
        {dx=1, dy=-1, cost=3},    -- Up-Right
        {dx=-1, dy=1, cost=3},    -- Down-Left
        {dx=-1, dy=-1, cost=3},   -- Up-Left
    }

    local open = { {x = startX, y = startY, cost = 0} }
    cost[startX][startY] = 0

    while #open > 0 do
        table.sort(open, function(a, b) return a.cost < b.cost end)
        local current = table.remove(open, 1)

        if current.x == goalX and current.y == goalY then
            break
        end

        for _, dir in ipairs(directions) do
            local nx, ny = current.x + dir.dx, current.y + dir.dy
            if grid[nx] and grid[nx][ny] and (grid[nx][ny].contents == nil) then
                local newCost = cost[current.x][current.y] + dir.cost
                if newCost < cost[nx][ny] then
                    cost[nx][ny] = newCost
                    cameFrom[nx][ny] = {x = current.x, y = current.y}
                    table.insert(open, {x = nx, y = ny, cost = newCost})
                end
            end
        end
    end

    -- Reconstruct path
    local path = {}
    local cx, cy = goalX, goalY

    if not cameFrom[cx][cy] then
        return nil, math.huge
    end

    while cx and cy and (cx ~= startX or cy ~= startY) do
        print(cx .. cy)
        table.insert(path, 1, {x = cx, y = cy, c = cost[cx][cy]})
        local prev = cameFrom[cx][cy]
        cx, cy = prev.x, prev.y
    end
    table.insert(path, 1, {x = startX, y = startY, c = 0})

    return path, cost[goalX][goalY]
end


function Movement.drawPath(path, player, cellSize)
    local currentCost = 0
    love.graphics.setColor(1, 1, 1, 0.5)
    if path then
        for _, node in ipairs(path) do
            if node.c <= player.rspeed then
                love.graphics.rectangle("fill", node.x*cellSize - cellSize, node.y*cellSize - cellSize, cellSize, cellSize)
            else
                love.graphics.setColor(1, 0, 0, 0.7)
                love.graphics.rectangle("fill", node.x*cellSize - cellSize, node.y*cellSize - cellSize, cellSize, cellSize)
            end
        end
      end
end

return Movement