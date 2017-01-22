
local tower = {}

function tower:getTowers()
    local towers = {}
    --Creates towers
    
      towers[1] = {x = 170, y = 120}
      towers[2] = {x = 250, y = 380}
      towers[3] = {x = 360, y = 440}
      towers[4] = {x = 370, y = 212}
      towers[5] = {x = 550, y = 337}
      towers[6] = {x = 650, y = 450}
      towers[7] = {x = 650, y = 75}
      towers[8] = {x = 750, y = 225}
    
    return towers
end

return tower