debugs={}

function debugs.load()
  xdt=0.02 -- для тестирования задержек
end


function debugs.update(dt)
  xdt=math.floor(1/dt) -- test dt
end

function debugs.show()
-- печать характеристик экрана - размеров и полученного масштаба
  love.graphics.setFont( status_font )
  love.graphics.setColor(0,255,0,255) 
  love.graphics.print(love.graphics.getWidth().." x "
      ..love.graphics.getHeight(), tileSize*20, tileSize*14+10) 
  love.graphics.print("scale-"..myscale, tileSize*20, tileSize*10+10) 
  
   --[[
 -- Отладка Печать Y ---------------------------------------------------------------------
  love.graphics.setFont( bungee_font )
  love.graphics.setColor(0,255,0,255) 
  --love.graphics.print("Y="..many, tileSize*20, tileSize*13)
  love.graphics.print("kMes="..keyMess, tileSize*20, tileSize*13)
 
 -- Вывод UNDO массива в строку
  love.graphics.print(" X_Y__M_+X+___-X-__+Y+__-Y-",tileSize, tileSize*14) 
  for i,v in pairs(UndoMen) do
       love.graphics.print(UndoMen[i], tileSize+i*30, tileSize*15)     
  end
  --]]
 love.graphics.print(xdt, tileSize*25, tileSize*14+10)     

end
