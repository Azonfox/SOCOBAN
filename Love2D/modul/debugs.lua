debugs={}

function debugs.load()
  xdt=0.02 -- для тестирования задержек
end

function debugs.update(dt)
  xdt=math.floor(1/dt) -- test dt
end

function debugs.show()
-- печать отладочной инфоормации
  love.graphics.setFont( Debugs_font )
  love.graphics.setColor(0,255,0,255) 
  love.graphics.print("Scale-"..myscale, tileSize*19+10, tileSize*13) 
  love.graphics.print("FPS-"..xdt, tileSize*23, tileSize*13+16)     
  love.graphics.print(love.graphics.getWidth().." x "
      ..love.graphics.getHeight(), tileSize*19+10, tileSize*13+16) 
 
    -- тест файловой системы
  love.graphics.print("file-NXY-"..mygamelevel.."-"..manx.."-"..many,
      tileSize*19+10, tileSize*12+16) 
   
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
end


