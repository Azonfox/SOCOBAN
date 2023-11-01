-- key event
--###########################################
--Играть сначала
  function keyreset() 
    gamereset(mygamelevel) 
  end  
 
--###########################################
-- Функция UNDO MEN - сохранение 
function undosave()
  UndoMen[0]=manx -- координаты мена
  UndoMen[1]=many
  UndoMen[2]=gamepad[many][manx]   -- men
  UndoMen[3]=gamepad[many][manx+1] -- R+1
  UndoMen[5]=gamepad[many][manx-1] -- L-1
  UndoMen[7]=gamepad[many+1][manx] -- D+1
  UndoMen[9]=gamepad[many-1][manx] -- U+1
  
  -- Обработка ошибок выхода за игровое поле!!!
  if manx>17 then UndoMen[4]=nil else  UndoMen[4]=gamepad[many][manx+2] end -- R+2 
  if manx<3  then UndoMen[6]=nil else  UndoMen[6]=gamepad[many][manx-2] end -- L-2  
  if many>14 then UndoMen[8]=nil else  UndoMen[8]=gamepad[many+2][manx] end-- D+2   
  if many<3  then UndoMen[10]=nil else UndoMen[10]=gamepad[many-2][manx] end-- U+2   
end
---- Функция GET UNDO MEN - восстановление 
  function undoload() 
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
    
      -- Обработка ошибок выхода за игровое поле!!!
    if UndoMen[4]  then gamepad[many][manx+2]=UndoMen[4] end -- R+2 
    if UndoMen[6]  then gamepad[many][manx-2]=UndoMen[6] end -- L-2  
    if UndoMen[8]  then gamepad[many+2][manx]=UndoMen[8] end -- D+2   
    if UndoMen[10] then gamepad[many-2][manx]=UndoMen[10] end-- U+2   
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
  undosave()

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



