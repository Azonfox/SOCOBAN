-- Изучение шрифтов
function love.load()
  xfont=32 -- общий размер шрифта и его настройка
  font1  = love.graphics.newFont("freefont/FreeMono.ttf", xfont) 
  font2  = love.graphics.newFont("freefont/FreeMonoBold.ttf", xfont) 
  font3  = love.graphics.newFont("freefont/FreeMonoBoldOblique.ttf", xfont) 
  font4  = love.graphics.newFont("freefont/FreeMonoOblique.ttf", xfont) 
  font5  = love.graphics.newFont("freefont/FreeSans.ttf", xfont) 
  font6  = love.graphics.newFont("freefont/FreeSansBold.ttf", xfont) 
  font7  = love.graphics.newFont("freefont/FreeSansBoldOblique.ttf", xfont) 
  font8  = love.graphics.newFont("freefont/FreeSansOblique.ttf", xfont) 
  font9  = love.graphics.newFont("freefont/FreeSerif.ttf", xfont) 
  font10 = love.graphics.newFont("freefont/FreeSerifBold.ttf", xfont) 
  font11 = love.graphics.newFont("freefont/FreeSerifBoldItalic.ttf", xfont) 
  font12 = love.graphics.newFont("freefont/FreeSerifItalic.ttf", xfont) 
end
--------------------------------------------------------
function love.draw()
  love.graphics.setBackgroundColor(0,0,0,255)
  love.graphics.setColor(255,100,0,255)
  
  love.graphics.setFont( font1 )
  love.graphics.print("1 - FreeMono *", 30, xfont*1)  

  love.graphics.setFont( font2 )
  love.graphics.print("2 - FreeMonoBold *", 30, xfont*2)  

  love.graphics.setFont( font3 )
  love.graphics.print("3 - FreeMonoBoldOblique *", 30, xfont*3)  

  love.graphics.setFont( font4 )
  love.graphics.print("4 - FreeMonoOblique *", 30, xfont*4)  

  love.graphics.setFont( font5 )
  love.graphics.print("5 - FreeSans", 30, xfont*5)  

  love.graphics.setFont( font6 )
  love.graphics.print("6 - FreeSansBold *", 30, xfont*6)  

  love.graphics.setFont( font7 )
  love.graphics.print("7 - FreeSansBoldOblique *", 30, xfont*7)  

  love.graphics.setFont( font8 )
  love.graphics.print("8 - FreeSansOblique *", 30, xfont*8)  

  love.graphics.setFont( font9 )
  love.graphics.print("9 - FreeSerif *", 30, xfont*9)  

  love.graphics.setFont( font10)
  love.graphics.print("10- FreeSerifBold *", 30, xfont*10)  

  love.graphics.setFont( font11)
  love.graphics.print("11- FreeSerifBoldItalic *", 30, xfont*11)  

  love.graphics.setFont( font12)
  love.graphics.print("12- FreeSerifItalic *", 30, xfont*12)  

end

function love.keypressed(key)  -- keyreleased
  if key == "f1" then  end 
  if key == "f12" then  love.event.quit() end -- Выход
end 
