require "src/lib/table"
require "src.lib.table_file"

local wave = {}

local waveImg = {}

function newWave(track, speed, scale, color)
    wave = {}
    wave.track = track
    wave.pathTable = getPathTable(track)
    wave.speed = speed
    wave.img = {}
    for i=1, #(waveImg[color]) do
        wave.img[i] = waveImg[color][i]
    end
    wave.sound = love.audio.newSource("assets/sound/"..color..".mp3", "stream")
    wave.x = wave.pathTable[1]
    wave.y = wave.pathTable[2]
    --
    wave.currentStep = 1;
    wave.currentDistance = 1;
    wave.currentDirection = getWaveDirection(wave.pathTable, 1)
    wave.finalDistance = getWaveDistance(wave.pathTable, 1)

    --
    wave.scale = scale
    return wave
end

function wave:init(level, waveImg0)
    self.waveTable = loadF("src/levels/"..level)
    self.seenColors = {}
    waveImg = waveImg0
end

function wave:update(waves, currentTime, dt)
    --Verifica se existe uma nova onda para ser solta
    if #self.waveTable > 0 then
        if self.waveTable[1].releaseTime +4 <= currentTime then
            local nWave = newWave(self.waveTable[1].track, self.waveTable[1].speed, 0.6, self.waveTable[1].color)
            table.insert(waves, nWave) --Solta nova onda
            if not table.contains(self.seenColors, self.waveTable[1].color) then
                table.insert(self.seenColors, self.waveTable[1].color)
                nWave.sound:setLooping(true)
                --nWave.sound:play()
            end
            table.remove(self.waveTable, 1)
        end
    end

    local removal = {}
    --Atualiza posição das ondas e seu step atual
    for i=1, #waves do
        --Atualiza posição
        movementSize = waves[i].speed*dt
        waves[i].x = waves[i].x + movementSize*waves[i].currentDirection[1]
        waves[i].y = waves[i].y + movementSize*waves[i].currentDirection[2]

        --Atualiza step
        waves[i].currentDistance = waves[i].currentDistance + movementSize;
        if waves[i].currentDistance >= waves[i].finalDistance then
            local distanceCorrection = waves[i].currentDistance-waves[i].finalDistance
            waves[i].x = waves[i].x - distanceCorrection*waves[i].currentDirection[1]
            waves[i].y = waves[i].y - distanceCorrection*waves[i].currentDirection[2]
            waves[i].currentStep = waves[i].currentStep+1
            if (waves[i].currentStep)*2+1 > #(waves[i].pathTable) then
                removal[#removal+1] = i
            else
                waves[i].currentDistance = 0
                waves[i].currentDirection = getWaveDirection(waves[i].pathTable, waves[i].currentStep)
                waves[i].finalDistance = getWaveDistance(waves[i].pathTable, waves[i].currentStep)
            end
        end
    end
    for i=1, #removal do
        table.remove(waves, removal[i])
    end
end

function wave:emptyWaveTable()
    if #self.waveTable == 0 then
        return true
    end
    return false
end

--Desenha ondas
function wave:render(waves, gametime)
    love.graphics.setColor(255, 255, 255)
    for i = 1, #waves do
        local k = math.ceil(#waves[i].img*gametime % #waves[i].img)
        local waveRotation = math.atan(waves[i].currentDirection[2]/waves[i].currentDirection[1])
        if waves[i].currentDirection[2] < 0 and waves[i].currentDirection[1] < 0 then
            waveRotation = math.pi + waveRotation
        end
        if waves[i].currentDirection[2] > 0 and waves[i].currentDirection[1] < 0 then
            waveRotation = math.pi + waveRotation
        end
        if waves[i].currentDirection[2] == 0 and waves[i].currentDirection[1] < 0 then
            waveRotation = math.pi
        end
        love.graphics.draw(waves[i].img[k], waves[i].x, waves[i].y, waveRotation, waves[i].scale, waves[i].scale, waves[i].img[k]:getWidth(), waves[i].img[k]:getHeight()/2)
    end
end

--Retorna a pathTable de um track
function getPathTable(track)
    return map.paths[track]
end

--Retorna ângulo da reta entre o ponto atual e o próximo ponto da pathTable
function getWaveDirection(pathTable, currentStep)
    --Pega deslocamento horizontal/vertical
    directionVec = {pathTable[currentStep*2+1]-pathTable[currentStep*2-1], pathTable[currentStep*2+2]-pathTable[currentStep*2]}
    --Normaliza vetor de direcao
    directionVecMod = math.sqrt(directionVec[1]*directionVec[1] + directionVec[2]*directionVec[2])
    directionVec[1] = directionVec[1]/directionVecMod
    directionVec[2] = directionVec[2]/directionVecMod
    return directionVec
end

--Retorna a o tamanho da reta entre o ponto atual e o próximo ponto da pathTable
function getWaveDistance(pathTable, currentStep)
    return math.sqrt((pathTable[currentStep*2-1]-pathTable[currentStep*2+1])*(pathTable[currentStep*2-1]-pathTable[currentStep*2+1])+(pathTable[currentStep*2]-pathTable[currentStep*2+2])*(pathTable[currentStep*2]-pathTable[currentStep*2+2]))
end

return wave
