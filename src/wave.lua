function newWave(track, speed, scale, color)
	wave = {}
	wave.track = track
	wave.trackTable = getTrackTable(track)
	wave.x = wave.trackTable[1].x
	wave.y = wave.trackTable[1].y
	wave.speed = speed
	
	--
	wave.currentStep = 1;
	wave.currentDistance = 0;
	wave.direction = getWaveDirection(wave.trackTable[1], wave.trackTable[2])
	wave.finalDistance = getWaveDistance(wave.trackTable[1], wave.trackTable[2])
	
	--
    wave.img = {}
    for i=1,60,1 do
        wave.img[i] = love.graphics.newImage("assets/"..color.."/ONDA1000"..string.format("%02d",i)..".png")
    end
	wave.scale = scale
	return wave
end

function updateWaves(waves, waveTable, currentTime, dt)
	--Verifica se existe uma nova onda para ser solta
	if #waveTable > 0 then
		if waveTable[1].releaseTime <= currentTime then
			print("kk")
			table.insert(waves, newWave(waveTable[1].track, waveTable[1].speed, 1, "amarelo")) --Solta nova onda
			table.remove(waveTable, 1)
		end
	end

	--Atualiza posição das ondas e seu step atual
	for i=1, #waves do
		--Atualiza posição
		movementSize = waves[i].speed*dt
		if waves[i].direction=="right" then
			waves[i].x = waves[i].x + movementSize
		elseif waves[i].direction=="left" then
			waves[i].x = waves[i].x - movementSize
		elseif waves[i].direction=="down" then
			waves[i].y = waves[i].y + movementSize
		elseif waves[i].direction=="right" then
			waves[i].y = waves[i].x - movementSize
		end
		
		--Atualiza step
		waves[i].currentDistance = waves[i].currentDistance + movementSize;
		if waves[i].currentDistance >= waves[i].finalDistance then
			waves[i].currentStep = waves[i].currentStep+1
			if waves[i].currentStep > #(waves[i].trackTable)-1 then
				table.remove(waves, i)
			else
				waves[i].currentDistance = 0
				waves[i].direction = getWaveDirection(waves[i].trackTable[waves[i].currentStep], waves[i].trackTable[waves[i].currentStep+1])
				waves[i].finalDistance = getWaveDistance(waves[i].trackTable[waves[i].currentStep], waves[i].trackTable[waves[i].currentStep+1])
			end
		end
	end

end


function drawWaves(waves, gametime)
    love.graphics.setColor(255, 255, 255)
    for i = 1, #waves do
        love.graphics.draw(waves[i].img[math.ceil(60*gametime % 60)], waves[i].x, waves[i].y, 0, waves[i].scale, waves[i].scale)
    end
end

--Colocar trackTables certas
function getTrackTable(track)
	testTrackTable = {{x=100, y=100}, {x=100, y=150}, {x=200, y=150}, {x=200, y=450}}
	return testTrackTable
end

function getWaveDirection(p1, p2)
	if p1.x-p2.x < 0 then return "right" end
	if p1.x-p2.x > 0 then return "left" end
	if p1.y-p2.y < 0 then return "down" end
	if p1.y-p2.y > 0 then return "up" end
end

function getWaveDistance(p1, p2)
	if p1.x-p2.x == 0 then return math.abs(p1.y-p2.y)
	else return math.abs(p1.x-p2.x) end
end
