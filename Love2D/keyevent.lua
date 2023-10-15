-- key event
  -- Обработка движения
  function keyleft()
    if(manx>1) then
      manx=manx-1
      gamepad[many][manx]=5
    end
  end
  --[[
  function keyright()
    if(manx<19) then
      manx=manx+1
      gamepad[many][manx]=5      
    end
  end
 --]]  
  function keyup()
    if (many>1) then
      many=many-1
      gamepad[many][manx]=5      
    end
  end
  
  function keydown()
    if(many<16) then
      many=many+1
      gamepad[many][manx]=5   
    end
  end  
  
  function keyreset() 
    gamereset(mygamelevel) 
  end  
  
  --------------------------------------
  function keyright()
    if(manx<19) then
      
  --1 Стена, упирающийся ящик - нет движения!
if gamepad[many][manx+1]==1 then goto continue end  
if gamepad[many][manx+1]==3 and (gamepad[many][manx+2]==3 or gamepad[many][manx+2]==1) then goto continue end  

--2 -движение свободное - поле
if gamepad[many][manx+1]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+1
    gamepad[many][manx]=5
    goto continue
end    
    
--3 движение свободное - цель
if gamepad[many][manx+1]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+1
    gamepad[many][manx]=6
    goto continue
end    

--4 перед нами свободный ящик, его можно двигать
if gamepad[many][manx+1]==3 and gamepad[many][manx+2]==0 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+1
    gamepad[many][manx]=5
    gamepad[many][manx+1]=3
    goto continue
end    
 
--5 перед нами свободный ящик у цели, можно двигать
if gamepad[many][manx+1]==3 and gamepad[many][manx+2]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+1
    gamepad[many][manx]=5
    gamepad[many][manx+1]=4
    goto continue
end    
 
 --6 свободный целевой ящик на цели и у цели
if gamepad[many][manx+1]==4 and gamepad[many][manx+2]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+1
    gamepad[many][manx]=6
    gamepad[many][manx+1]=4
    goto continue
end    
 
 --7 свободный целевой ящик на цели и у пустоты
if gamepad[many][manx+1]==4 and gamepad[many][manx+2]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+1
    gamepad[many][manx]=6
    gamepad[many][manx+1]=3
    goto continue
end    
end
::continue::

end
  