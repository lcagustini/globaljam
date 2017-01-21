local map = {}

function map:init()
    for i=1,15,1 do
        map[i] = createTower(math.random(800), math.random(600))
    end
    map.paths = getPaths()
end

function createTower(x0, y0)
    return {x = x0, y = y0}
end

function getPaths()
    local paths = {}
    paths.colors = {}
    paths[1] = {200,600, 200,500, 400,500, 400,200, 800,200}
    paths.colors[1] = {0,255,0}
    paths[2] = {450,600, 450,400, 100,400, 100,250, 150,250, 150,0}
    paths.colors[2] = {255,0,0}
    return paths
end

return map
