levcompl={}
 
 function levcompl.load()
 -- картинки
    LevComplPng=love.graphics.newImage("levcompl.png")
    compliteflag=false -- флаг окна выигрыша
end


function levcompl.update(dt)
  -- Проверка выигрыша - есть ли вообще свободные ящики?
  levelOK=1
  for myi=1, 16 do
   for mxi=1,19 do
    -- если еще есть, то сбросим флаг
    if(gamepad[myi][mxi]==3) then 
        levelOK=0 
        flagOk=0 
    end 
   end
  end 
  
  -- Если выигрыш (флаг установлен), то 
  if(levelOK==1) then flagOk=flagOk+1  end
  -- Время красного поля перед Message. Плохо! Где *dt????????????
  --if(flagOk==20) then gamemenu("Поздравляем!\nВы\nвыиграли") end
  if(flagOk==20) then 
    compliteflag=true 
    kmen=0  rkmen=0   -- Men стоит прямо и не толкая 
  end
  
end


function levcompl.show()
  -- Если выигрыш то всё красное,
  -- иначе восстанавливаем  цвета
  if(flagOk~=0) then 
    love.graphics.setColor(255,0,0,255)
    love.graphics.draw(LevComplPng,tileSize*6,tileSize*4)
  else
    love.graphics.setColor(255,255,255,255)
  end 

end  

 function levcompl.key()
    -- Если есть окно выигрыша - выходим любой клавишей pc.lua
    if compliteflag==true then 
      if mygamelevel<maxlevel then  
           mygamelevel=mygamelevel+1
      else mygamelevel=1
      end
      compliteflag=false
      gamereset(mygamelevel) 
    end  
end    
