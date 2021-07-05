-- map gen

local function movePointer(map, pointer)
  local d = math.ceil(math.random()*4)
  
  if d%2 == 0 then
    return d == 2 and pointer-map.w or pointer+map.w
  else
    return d == 1 and pointer-1 or pointer+1
  end
end

local map = {}

map.new = function(tw, th, n)
  local w, h = love.graphics.getDimensions()
  return {
    w = math.floor(w/tw), 
    h = math.floor(h/th),
    tw = tw, 
    th = th, 
    tile_count = math.floor(w/tw)*math.floor(h/th),
    water_level = n
  }
end

map.clear = function(map)
  for i = 1, map.tile_count do
    map[i] = nil
  end
end

map.gen = function(map)
  math.randomseed(os.clock())
  
  local center_x = math.floor(map.w/2)
  local center_y = math.floor(map.h/2)
  local total_cells = math.floor(map.tile_count*map.water_level)
  local painted = 0
  local pointer = (center_y-1)*map.w+center_x
  
  local function paint(pointer, total)
    if painted < total_cells then
      if not map[pointer] then
        map[pointer] = 1
        painted = painted + 1
      end
      paint(movePointer(map, pointer), total)
    end
  end
  
  paint(pointer, total_cells)
  
end

map.draw = function(map)
  for i = 1, map.tile_count do
    
    
    local color = map[i] and {0.4, 0.4, 1.0} or {0.4, 1.0, 0.4}
    
    
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", (i%map.w)*map.tw, math.floor((i-1)/map.w)*map.th, map.tw, map.th)
  end
end


return map