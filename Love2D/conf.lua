function love.conf(c)
  c.title = "Shooter"
  local window = c.screen or c.window -- love 0.9 renamed "screen" to "window"
  window.width = 600
  window.height = 400
end
