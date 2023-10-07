--[[
проверка механики игрового поля в виде одномерного массива
0 - пол
1 - стена
2 - цель
3 - ящик на свободном поле
4 - ящик стоит на цели
5 - MEN на свободном поле
6 - MEN стоит на цели
--]]

-- начальные установки
local bbb={0,5,0,2,2,3,2,2,0,0,1} --Начальное игровое поле
manx=2  --men X,  Y тут не учавствует
for i=1, #bbb do io.write(bbb[i]) end -- печатаем исходное поле
io.write("\n")

--Цикл нескольких нажатий вправо ----------------------------
for stepright=1, 8 do
-- В цикле обработка каждого движения вправо
-- Варианты:

--1 Стена, упирающийся ящик - нет движения!
if bbb[manx+1]==1 then goto continue end  
if bbb[manx+1]==3 and (bbb[manx+2]==3 or bbb[manx+2]==1) then goto continue end  

--2 -движение свободное - поле
if bbb[manx+1]==0 then 
    if bbb[manx]==6 then bbb[manx]=2 else bbb[manx]=0 end
    manx=manx+1
    bbb[manx]=5
    goto continue
end    
    
--3 движение свободное - цель
if bbb[manx+1]==2 then  
    if bbb[manx]==6 then bbb[manx]=2 else bbb[manx]=0 end
    manx=manx+1
    bbb[manx]=6
    goto continue
end    

--4 перед нами свободный ящик, его можно двигать
if bbb[manx+1]==3 and bbb[manx+2]==0 then  
    if bbb[manx]==6 then bbb[manx]=2 else bbb[manx]=0 end
    manx=manx+1
    bbb[manx]=5
    bbb[manx+1]=3
    goto continue
end    
 
--5 перед нами свободный ящик у цели, можно двигать
if bbb[manx+1]==3 and bbb[manx+2]==2 then  
    if bbb[manx]==6 then bbb[manx]=2 else bbb[manx]=0 end
    manx=manx+1
    bbb[manx]=5
    bbb[manx+1]=4
    goto continue
end    
 
 --6 свободный целевой ящик на цели и у цели
if bbb[manx+1]==4 and bbb[manx+2]==2 then  
    if bbb[manx]==6 then bbb[manx]=2 else bbb[manx]=0 end
    manx=manx+1
    bbb[manx]=6
    bbb[manx+1]=4
    goto continue
end    
 
 --7 свободный целевой ящик на цели и у пустоты
if bbb[manx+1]==4 and bbb[manx+2]==0 then 
    if bbb[manx]==6 then bbb[manx]=2 else bbb[manx]=0 end
    manx=manx+1
    bbb[manx]=6
    bbb[manx+1]=3
    goto continue
end    

--------------------------------------------------------
::continue::
for i=1, #bbb do io.write(bbb[i]) end -- исходное поле
io.write("\n")
end

--[[
05022322001
00522322001
00062322001
00026322001
00022542001
00022064001
00022026301
00022022531
00022022531
--]]
