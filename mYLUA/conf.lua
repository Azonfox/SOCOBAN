-- Мои старые нстройки
function love.conf(c)
  c.title = "File Test"
  local window = c.screen or c.window -- love 0.9 renamed "screen" to "window"
  c.window.usedpiscale=false  -- noFULL screen
  c.window.width = 640
  c.window.height = 512
end
 

