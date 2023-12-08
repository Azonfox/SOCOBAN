levcompl={}
 
 function levcompl.load()
 -- картинки
    LevComplPng=love.graphics.newImage("image/levcompl.png")
    compliteflag=false -- флаг окна выигрыша
    xgong=true -- гонг выигрыша звучит один раз
    -- учет пройденных уровней 1-да 0-нет
    for i=1, maxlevel do 
      levcompl[i]=0
    end  
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
    levcompl[mygamelevel]=1 -- учет пройденных уровней
  end
end

function levcompl.show()
  -- Печать метки пройденного уровня зеленым
  love.graphics.setFont( LevCompl_font )
  if levcompl[mygamelevel]==1 then
      love.graphics.setColor(0,250,0,255) 
  else
     love.graphics.setColor(150,150,0,255) 
  end
 love.graphics.print("*", tileSize*19+10, tileSize*14+4)

  -- Если выигрыш, то красим, иначе восстанавливаем цвета
  if compliteflag then 
    -- Выводим изображение окна выигрыша
    --love.graphics.setColor(255,255,255,255) -- цвет рисунка не меняем
    --love.graphics.draw(LevComplPng,tileSize*6,tileSize*4) --PNGокно
    
    -- ! Отказ от изображения в пользу встроенной графики линий и текста:
    local cpx=6 -- начальные координаты сообщения
    local cpy=5
    love.graphics.setColor(255,0,0,255) -- цвет рамки
    -- первая рамка
    love.graphics.setLineWidth( 10 )    -- толщина линии
    love.graphics.rectangle("line",tileSize*(cpx-1), tileSize*(cpy-1),
      tileSize*9,tileSize*8,20,20)     
    -- вторая рамка
    love.graphics.setLineWidth( 3 )    -- толщина линии
    love.graphics.rectangle("line",tileSize*(cpx-1)+10, tileSize*(cpy-1)+10,
      tileSize*9-20,tileSize*8-20,10,10)     
    -- Формируем надписи согласно пройденного уровня
      -- разделение на два блока проверок из-за настроек цвета
    love.graphics.setColor(255,100,0,255) -- цвет первой надписи
    love.graphics.setFont( LevCompl_font )
    if mygamelevel<maxlevel then -- уровень не последний?
      love.graphics.print("LEVEL", tileSize*(cpx+2), tileSize*cpy)
    else
      love.graphics.print("END LEVEL", tileSize*(cpx+0)+tileSize/2, tileSize*cpy)
    end
    love.graphics.print("COMLETED!", tileSize*(cpx+0)+tileSize/2, tileSize*(cpy+1))
    love.graphics.setColor(0,255,0,255) -- цвет последней надписи
    love.graphics.print("PRESS SPACE", tileSize*(cpx+0), tileSize*(cpy+3))
    if mygamelevel<maxlevel then -- уровень не последний?
      love.graphics.print("FOR  NEW", tileSize*(cpx+1), tileSize*(cpy+4))
      love.graphics.print("LEVEL ", tileSize*(cpx+2), tileSize*(cpy+5))
    else
      love.graphics.print("FOR RESTART", tileSize*(cpx+0), tileSize*(cpy+4))
      love.graphics.print("LEVEL ", tileSize*(cpx+2), tileSize*(cpy+5))
    end
    love.graphics.setColor(0,0,255,255)  -- красим поле игры    
 else
    love.graphics.setColor(255,255,255,255) -- или восстанавливаем
  end 
    
end  --levcompl.show()

-- Если есть окно выигрыша - выходим любой клавишей (см. pc.lua)
 function levcompl.key()
      if mygamelevel<maxlevel then mygamelevel=mygamelevel+1
        else mygamelevel=maxlevel end
      xgong=true -- Восстановить гонг для следующего уровня      
      compliteflag=false
      gamereset(mygamelevel)
      bgfill() -- заполняем фон за пределами стен
end    
