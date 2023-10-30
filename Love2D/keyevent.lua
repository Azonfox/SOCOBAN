-- key event
--###########################################
--Играть сначала
  function keyreset() 
    gamereset(mygamelevel) 
  end  
 
--###########################################
-- Функция UNDO MEN - сохранение 
function setundomen()
 if many>2 and manx>2 and manx<18 and many<15 then -- затычка ошибок выхода за игровое поле!!!
  UndoMen[0]=manx -- координаты мена
  UndoMen[1]=many
  UndoMen[2]=gamepad[many][manx]   -- men
  UndoMen[3]=gamepad[many][manx+1] -- R+1
  UndoMen[4]=gamepad[many][manx+2] -- R+2
  UndoMen[5]=gamepad[many][manx-1] -- L-1
  UndoMen[6]=gamepad[many][manx-2] -- L-2  
  UndoMen[7]=gamepad[many+1][manx] -- D+1
  UndoMen[8]=gamepad[many+2][manx] -- D+2  
  UndoMen[9]=gamepad[many-1][manx] -- U+1
  UndoMen[10]=gamepad[many-2][manx] -- U+2  
 end
end
---- Функция GET UNDO MEN - восстановление 
  function getundomen() 
    manx=UndoMen[0] 
    many=UndoMen[1]
    gamepad[many][manx]  =UndoMen[2] -- men
    gamepad[many][manx+1]=UndoMen[3] -- R+1
    gamepad[many][manx+2]=UndoMen[4] -- R+2
    gamepad[many][manx-1]=UndoMen[5] -- L-1
    gamepad[many][manx-2]=UndoMen[6] -- L-2  
    gamepad[many+1][manx]=UndoMen[7] -- D+1
    gamepad[many+2][manx]=UndoMen[8] -- D+2  
    gamepad[many-1][manx]=UndoMen[9] -- U+1
    gamepad[many-2][manx]=UndoMen[10] -- U+2 
end


-- Обработка движения
--###########################################
function gamekeyevent(kx1,kx2,ky1,ky2)
  if(manx>1 and manx<19 and many>1 and many<16) then
    
  --1 Стена, упирающийся ящик - нет движения!
if gamepad[many+ky1][manx+kx1]==1 then goto continue end  -- стена
if gamepad[many+ky1][manx+kx1]==3 and (gamepad[many+ky2][manx+kx2]==4 or gamepad[many+ky2][manx+kx2]==3 or gamepad[many+ky2][manx+kx2]==1) then 
    goto continue end  -- ящик с упором
if gamepad[many+ky1][manx+kx1]==4 and (gamepad[many+ky2][manx+kx2]==4 or gamepad[many+ky2][manx+kx2]==3 or gamepad[many+ky2][manx+kx2]==1) then 
    goto continue end  -- ящик на цели с упором

-- Если движение есть - Сохранить информацию об откате
  setundomen()

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



