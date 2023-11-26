levcompl={}
 
 function levcompl.load()
 -- картинки
    LevComplPng=love.graphics.newImage("image/levcompl.png")
    LevCompl_font  = love.graphics.newFont("font/font.ttf", tileSize*2)  
    compliteflag=false -- флаг окна выигрыша
    xgong=true -- гонг выигрыша звучит один раз
end


function levcompl.update(dt)
  -- Проверка выигрыша - есть ли вообще свободные ящики?
  compliteflag=true 
  for myi=1, 16 do
   for mxi=1,19 do
    -- если еще есть, то сбросим флаг
    if(gamepad[myi][mxi]==3) then compliteflag=false end 
   end
  end 
  -- Если выигрыш (флаг установлен), то поздрвления
  if compliteflag then 
    if xsound and xgong then Lgong:play(); xgong=false end
    kmen=0  rkmen=0   -- Men стоит прямо и не толкая 
  end
end

function levcompl.show()
  -- Если выигрыш, то красим, иначе восстанавливаем цвета
  if compliteflag then 
    love.graphics.setColor(255,255,255,255)
    love.graphics.draw(LevComplPng,tileSize*6,tileSize*4) -- окно
    love.graphics.setColor(0,100,0,255)
    --love.graphics.setFont( LevCompl_font )
    --love.graphics.print(" CONGRATULATIONS! ", tileSize*2, tileSize*8)
  else
    love.graphics.setColor(255,255,255,255)
  end 
end  

-- Если есть окно выигрыша - выходим любой клавишей (см. pc.lua)
 function levcompl.key()
      if mygamelevel<maxlevel then mygamelevel=mygamelevel+1
        else mygamelevel=maxlevel end
      xgong=true -- Восстановить гонг для следующего уровня      
      compliteflag=false
      gamereset(mygamelevel) 
end    
