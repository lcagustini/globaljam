
-- Load file, call object wave constructor, add wave to the waves table
function loadF(filename)
  table_waves = {}
  file = io.open(filename, "r")
  if file then
    for line in file:lines() do
      local time, track, speed = line:match("(%d+) (%d+) (%d+) (%s+)")
      table.insert(table_waves, createWave(time, track, speed))
    end
  end
  file:close()
  
  return table_waves
end

-- Create object wave
function createWave(time, track, speed)
  wave = {}
  wave.time = time
  wave.track = track
  wave.speed = speed
  return wave
end

--- Print table content
function printtable(table)
  for i=1,#table do
    print(table[i].time, table[i].track, table[i].speed)
  end
end
