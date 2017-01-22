require "src/lib/table"

local seenColors = {}

function newWave(track, speed, scale, color)
    wave = {}
    wave.track = track
    wave.pathTable = getPathTable(track)
    wave.speed = speed
    wave.img = {}
    files = love.filesystem.getDirectoryItems("assets/"..color)
    for i=1,#files do
        wave.img[i] = love.graphics.newImage("assets/"..color.."/"..files[i])
    end
    wave.sound = love.audio.newSource("assets/sound/"..color..".wav", "stream")
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

function updateWaves(waves, waveTable, currentTime, dt)
    --Verifica se existe uma nova onda para ser solta
    if #waveTable > 0 then
        if waveTable[1].releaseTime <= currentTime then
            local nWave = newWave(waveTable[1].track, waveTable[1].speed, 0.6, waveTable[1].color)
            table.insert(waves, nWave) --Solta nova onda
            if not table.contains(seenColors, waveTable[1].color) then
                table.insert(seenColors, waveTable[1].color)
                nWave.sound:setLooping(true)
                nWave.sound:play()
            end
            table.remove(waveTable, 1)
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

--Desenha ondas
function drawWaves(waves, gametime)
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
