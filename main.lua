local timer = {}
local mapper = require("map")

local map = mapper.new(16, 16, .1)

mapper.gen(map)

function love.load()
  timer.t = 1/60
  timer.dt = 0
end

function love.update(dt)
  timer.dt = timer.dt + dt
  if timer.dt > timer.t then
    -- game loop
    timer.dt = timer.dt - timer.t
  end
end

function love.keypressed(key, sc, isrepeat)
  if key == "space" then
    mapper.clear(map)
    mapper.gen(map)
  end
end


function love.draw()
  love.graphics.print("Ship Shooty Game",400, 16)
  mapper.draw(map)
end