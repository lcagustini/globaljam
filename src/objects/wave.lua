function newWave(track, speed, scale, color)
	wave = {}
	wave.track = track
	wave.pathTable = getPathTable(track)
	wave.x = wave.pathTable[1]
	wave.y = wave.pathTable[2]
	wave.speed = speed
	wave.img = {}
    for i=1,60,1 do
        wave.img[i] = love.graphics.newImage("assets/"..color.."/ONDA1000"..string.format("%02d",i)..".png")
    end
	--
	wave.currentStep = 1;
	wave.currentDistance = 0;
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
			table.insert(waves, newWave(waveTable[1].track, waveTable[1].speed, 0.5, "amarelo")) --Solta nova onda
			table.remove(waveTable, 1)
		end
	end

	--Atualiza posição das ondas e seu step atual
	for i=1, #waves do
		--Atualiza posição
		movementSize = waves[i].speed*dt
		waves[i].x = waves[i].x + movementSize*waves[i].currentDirection[1]
		waves[i].y = waves[i].y + movementSize*waves[i].currentDirection[2]
		
		--Atualiza step
		waves[i].currentDistance = waves[i].currentDistance + movementSize;
		if waves[i].currentDistance >= waves[i].finalDistance then
			waves[i].currentStep = waves[i].currentStep+1
			if (waves[i].currentStep)*2 > #(waves[i].pathTable)-1 then
				table.remove(waves, i)
			else
				waves[i].currentDistance = 0
				waves[i].currentDirection = getWaveDirection(waves[i].pathTable, waves[i].currentStep)
				waves[i].finalDistance = getWaveDistance(waves[i].pathTable, waves[i].currentStep)
			end
		end
	end

end

--Desenha ondas
function drawWaves(waves, gametime)
    love.graphics.setColor(255, 255, 255)
    for i = 1, #waves do
        local k = math.ceil(60*gametime % 60)
        love.graphics.draw(waves[i].img[k], waves[i].x, waves[i].y, math.atan(waves[i].currentDirection[2]/waves[i].currentDirection[1]), waves[i].scale, waves[i].scale, (waves[i].img[k]:getWidth()*waves[i].scale)/2, (waves[i].img[k]:getWidth()*waves[i].scale)/2)
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
