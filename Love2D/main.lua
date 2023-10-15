--[[ SOKOBAN
0 - пол
1 - стена
2 - цель
3 - ящик на свободном поле
4 - ящик стоит на цели
5 - MEN на свободном поле
6 - MEN стоит на цели
--]]

-- Начальная загрузка
function love.load()
 -- require "levels"
  require "keyevent"
  
  
  -- Два тестовых поля для отладки выигрыша
  mARR={
0,1,0,0,0,0,5,0,0,0,3,0,0,0,2,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,
0,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
1,1,1,0,1,0,1,1,0,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,0,1,1,0,1,1,1,1,1,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,1,1,1,0,1,0,1,1,0,0,0,0,1,
0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,1,0,2,0,3,5,0,0,0,3,0,0,0,2,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,
0,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,
1,1,1,0,1,0,1,1,0,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,0,1,1,0,1,1,1,1,1,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,1,1,1,0,1,0,1,1,0,0,0,0,1,
0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
}
  
  
  
  
  --Координаты игрока
  manx=1 
  many=1
  mygamelevel=1  -- начальный уровень
  
    bungee_font = love.graphics.newFont("font.ttf", 30 )  
  
  -- Картинки
  imageGround= love.graphics.newImage("Ground.png") 
  imageWall= love.graphics.newImage("Wall.png") 
  imageBox= love.graphics.newImage("Box.png") 
  imageXbox= love.graphics.newImage("Xbox.png") 
  imageMan= love.graphics.newImage("Man.png") 
  imageManX= love.graphics.newImage("ManX.png") 
  imageBoxOk= love.graphics.newImage("BoxOk.png") 
  
  gamereset(mygamelevel)
  
end

function gamereset(gamelevel)
  levelOK=0 
--Формирование текущего уровня gamepad
if gamelevel>50 then gamelevel=50 end
if gamelevel<1  then gamelevel=1  end
local adr=(gamelevel-1)*19*16
gamepad={}
 for myi=1, 16 do
  gamepad[myi]={}
  for mxi=1,19 do
    adr=adr+1
    gamepad[myi][mxi]=mARR[adr]
    if(gamepad[myi][mxi]==5) then manx=mxi many=myi end -- игрок
  end
 end 
end

function love.update(dt)
  -- Обработка движения
  function love.keyreleased(key)
    if (key == "left")  then keyleft()  end
    if (key == "right") then keyright() end
    if (key == "up")    then keyup()    end  
    if (key == "down")  then keydown()  end
    if (key == " " or key == "space")  then  gamereset(mygamelevel) end   
    if (key == "return" and mygamelevel<50) then  
      mygamelevel=mygamelevel+1
      gamereset(mygamelevel) 
    end    
  end
   
  -- Проверка выигрыша - есть ли свободные ящики?
  levelOK=1
  for myi=1, 16 do
   for mxi=1,19 do
    if(gamepad[myi][mxi]==3) then levelOK=0 end -- сли еще есть, то сбросим флаг
   end
  end 
    -- Если выигрыш - флаг установлен, то
   if(levelOK==1) then 
    -- переходим на следующий уровень, до 50
    -- лучше с задержкой - - пока нет
    --[[
    if (mygamelevel<50) then  
      mygamelevel=mygamelevel+1
      gamereset(mygamelevel) 
    end 
    --]]
  end
end
  
 -- Прорисовка
function love.draw()
  for myi=1, 16 do
    for mxi=1,19 do
     if(gamepad[myi][mxi]==0) then love.graphics.draw(imageGround,(mxi-1)*32,(myi-1)*32) end -- пол
     if(gamepad[myi][mxi]==1) then love.graphics.draw(imageWall,  (mxi-1)*32,(myi-1)*32) end -- стена
     if(gamepad[myi][mxi]==2) then love.graphics.draw(imageXbox,  (mxi-1)*32,(myi-1)*32) end -- место
     if(gamepad[myi][mxi]==3) then love.graphics.draw(imageBox,   (mxi-1)*32,(myi-1)*32) end -- ящик
     if(gamepad[myi][mxi]==4) then love.graphics.draw(imageBoxOk, (mxi-1)*32,(myi-1)*32) end -- уст.ящик
     if(gamepad[myi][mxi]==5) then love.graphics.draw(imageMan,   (mxi-1)*32,(myi-1)*32) end -- дядя
     if(gamepad[myi][mxi]==6) then love.graphics.draw(imageManX,  (mxi-1)*32,(myi-1)*32) end -- дядя на Х поле
    end
  end 
  
      -- Печать номера уровня
  love.graphics.setFont( bungee_font )
  love.graphics.setColor(0,0,255,255) -- голубой
  love.graphics.print(mygamelevel, 3, 3)
  -- Восстановливаем фон
  love.graphics.setColor(255,255,255,255)
    -- Если выигрыш то все красное
   if(levelOK==1) then 
    love.graphics.setColor(255,0,0,255)
   end 
  
end