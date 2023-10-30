-- key event
--###########################################
--Играть сначала
  function keyreset() 
    gamereset(mygamelevel) 
  end  
  
-- Обработка движения
--###########################################

function gamekeyevent(kx1,kx2,ky1,ky2)
  if(manx>1 and manx<19 and many>1 and many<16) then
    
  --1 Стена, упирающийся ящик - нет движения!
if gamepad[many+ky1][manx+kx1]==1 then goto continue end  
if gamepad[many+ky1][manx+kx1]==3 and (gamepad[many+ky2][manx+kx2]==3 or gamepad[many+ky2][manx+kx2]==1) then 
    goto continue end  

-- Если движение есть - Сохранить информацию об откате
    UndoMen[0]=manx -- X
    UndoMen[1]=many -- Y
    UndoMen[2]=0 -- направление
    UndoMen[3]=gamepad[many][manx] -- ячека men
    UndoMen[4]=gamepad[many][manx+1] -- ячека+1
    UndoMen[5]=gamepad[many][manx+2] -- ячейка+2

--2 -движение свободное - поле
if gamepad[many+ky1][manx+kx1]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+kx1
    many=many+ky1
    gamepad[many][manx]=5
    goto continue
end    
    
--3 движение свободное - цель
if gamepad[many+ky1][manx+kx1]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+kx1
    many=many+ky1
    gamepad[many][manx]=6
    goto continue
end    

--4 перед нами свободный ящик, его можно двигать
if gamepad[many+ky1][manx+kx1]==3 and gamepad[many+ky2][manx+kx2]==0 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+kx1
    many=many+ky1
    gamepad[many][manx]=5
    gamepad[many+ky1][manx+kx1]=3
    goto continue
end    
 
--5 перед нами свободный ящик у цели, можно двигать
if gamepad[many+ky1][manx+kx1]==3 and gamepad[many+ky2][manx+kx2]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+kx1
    many=many+ky1
    gamepad[many][manx]=5
    gamepad[many+ky1][manx+kx1]=4
    goto continue
end    
 
 --6 свободный целевой ящик на цели и у цели
if gamepad[many+ky1][manx+kx1]==4 and gamepad[many+ky2][manx+kx2]==2 then  
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+kx1    
    many=many+ky1
    gamepad[many][manx]=6
    gamepad[many+ky1][manx+kx1]=4
    goto continue
end    
 
 --7 свободный целевой ящик на цели и у пустоты
if gamepad[many+ky1][manx+kx1]==4 and gamepad[many+ky2][manx+kx2]==0 then 
    if gamepad[many][manx]==6 then gamepad[many][manx]=2 else gamepad[many][manx]=0 end
    manx=manx+kx1   
    many=many+ky1
    gamepad[many][manx]=6
    gamepad[many+ky1][manx+kx1]=3
    goto continue
end    
end
::continue::
end



