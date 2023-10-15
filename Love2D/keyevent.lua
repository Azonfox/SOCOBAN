-- key event
  function keyreset() 
    gamereset(mygamelevel) 
  end  
  
  
  -- Обработка движения
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
  
  
  
  
--------------------------------------
  function keyleft()
    if(manx>1) then
      
  --1 Стена, упирающийся ящик - нет движения!
if gamepad[many][manx-1]==1 then goto continue end  
if gamepad[many][manx-1]==3 and (gamepad[many][manx-2]==3 or gamepad[many][manx-2]==1) then goto continue end  

--2 -движение свободное - поле
if gamepad[many][manx-1]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx-1
    gamepad[many][manx]=5
    goto continue
end    
    
--3 движение свободное - цель
if gamepad[many][manx-1]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx-1
    gamepad[many][manx]=6
    goto continue
end    

--4 перед нами свободный ящик, его можно двигать
if gamepad[many][manx-1]==3 and gamepad[many][manx-2]==0 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx-1
    gamepad[many][manx]=5
    gamepad[many][manx-1]=3
    goto continue
end    
 
--5 перед нами свободный ящик у цели, можно двигать
if gamepad[many][manx-1]==3 and gamepad[many][manx-2]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx-1
    gamepad[many][manx]=5
    gamepad[many][manx-1]=4
    goto continue
end    
 
 --6 свободный целевой ящик на цели и у цели
if gamepad[many][manx-1]==4 and gamepad[many][manx-2]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx-1
    gamepad[many][manx]=6
    gamepad[many][manx-1]=4
    goto continue
end    
 
 --7 свободный целевой ящик на цели и у пустоты
if gamepad[many][manx-1]==4 and gamepad[many][manx-2]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx-1
    gamepad[many][manx]=6
    gamepad[many][manx-1]=3
    goto continue
end    
end
::continue::
end

  --------------------------------------
  function keyup()
    if(many>1) then
      
  --1 Стена, упирающийся ящик - нет движения!
if gamepad[many-1][manx]==1 then goto continue end  
if gamepad[many-1][manx]==3 and (gamepad[many-2][manx]==3 or gamepad[many-2][manx]==1) then goto continue end  

--2 -движение свободное - поле
if gamepad[many-1][manx]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many-1
    gamepad[many][manx]=5
    goto continue
end    
    
--3 движение свободное - цель
if gamepad[many-1][manx]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many-1
    gamepad[many][manx]=6
    goto continue
end    

--4 перед нами свободный ящик, его можно двигать
if gamepad[many-1][manx]==3 and gamepad[many-2][manx]==0 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many-1
    gamepad[many][manx]=5
    gamepad[many-1][manx]=3
    goto continue
end    
 
--5 перед нами свободный ящик у цели, можно двигать
if gamepad[many-1][manx]==3 and gamepad[many-2][manx]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many-1
    gamepad[many][manx]=5
    gamepad[many+1][manx]=4
    goto continue
end    
 
 --6 свободный целевой ящик на цели и у цели
if gamepad[many-1][manx]==4 and gamepad[many-2][manx]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many-1
    gamepad[many][manx]=6
    gamepad[many-1][manx]=4
    goto continue
end    
 
 --7 свободный целевой ящик на цели и у пустоты
if gamepad[many-1][manx]==4 and gamepad[many-2][manx]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many-1
    gamepad[many][manx]=6
    gamepad[many-1][manx]=3
    goto continue
end    
end
::continue::
end

 --------------------------------------
  function keydown()
    if(many<16) then
      
  --1 Стена, упирающийся ящик - нет движения!
if gamepad[many+1][manx]==1 then goto continue end  
if gamepad[many+1][manx]==3 and (gamepad[many+2][manx]==3 or gamepad[many+2][manx]==1) then goto continue end  

--2 -движение свободное - поле
if gamepad[many+1][manx]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many+1
    gamepad[many][manx]=5
    goto continue
end    
    
--3 движение свободное - цель
if gamepad[many+1][manx]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many+1
    gamepad[many][manx]=6
    goto continue
end    

--4 перед нами свободный ящик, его можно двигать
if gamepad[many+1][manx]==3 and gamepad[many+2][manx]==0 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many+1
    gamepad[many][manx]=5
    gamepad[many+1][manx]=3
    goto continue
end    
 
--5 перед нами свободный ящик у цели, можно двигать
if gamepad[many+1][manx]==3 and gamepad[many+2][manx]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many+1
    gamepad[many][manx]=5
    gamepad[many+1][manx]=4
    goto continue
end    
 
 --6 свободный целевой ящик на цели и у цели
if gamepad[many+1][manx]==4 and gamepad[many+2][manx]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many+1
    gamepad[many][manx]=6
    gamepad[many+1][manx]=4
    goto continue
end    
 
 --7 свободный целевой ящик на цели и у пустоты
if gamepad[many+1][manx]==4 and gamepad[many+2][manx]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    many=many+1
    gamepad[many][manx]=6
    gamepad[many+1][manx]=3
    goto continue
end    
end
::continue::
end


