
-- Load file, call object wave constructor, add wave to the waves table
function loadF(filename)
  table_waves = {}
  file = io.open(filename, "r")
  if file then
    for line in file:lines() do
      local releaseTime, track, speed = line:match("(%d+%p%d+) (%d+) (%d+)")
      table.insert(table_waves, createWave(releaseTime, track, speed))
    end
  end
  file:close()
  
  return table_waves
end

-- Create object wave
function createWave(releaseTime, track, speed)
  wave = {}
  wave.releaseTime = tonumber(releaseTime)
  wave.track = tonumber(track)
  wave.speed = tonumber(speed)
  if wave.track == 1 then wave.color = "amarelo"
  elseif wave.track == 2 then wave.color = "verde"
  elseif wave.track == 3 then wave.color = "laranja"
  elseif wave.track == 4 then wave.color = "azul"
  elseif wave.track == 5 then wave.color = "vermelho" end
  return wave
end

--- Print table content
function printtable(table)
  for i=1,#table do
    print(table[i].releaseTime, table[i].track, table[i].speed)
  end
end
