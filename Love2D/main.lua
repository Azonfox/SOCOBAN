--[[############ SOKOBAN ####################
0 - пол     |  3 - ящик на свободном поле
1 - стена   |  4 - ящик стоит на цели
2 - цель    |  5 - MEN на свободном поле
            |  6 - MEN стоит на цели --]]
--###########################################
-- Начальная загрузка
function love.load()
  --Include
  -- require "levels"  -- Все уровни
  require "Testlevels" -- Тестовые уровни
  require "keyevent"   -- Движения игрока
  --Переменные
  manx=1 --Координаты игрока XY
  many=1
  mygamelevel=1  -- начальный уровень
  keyMess=0 -- Для проверки выбора меню
  -- для вращения игрока
  urad=0 uox=0 uoy=0 
  imageMan=1 -- спрайти игрока
  
  -- Шрифт
  bungee_font = love.graphics.newFont("font.ttf", 30 )  
  -- Картинки
  imageGround=  love.graphics.newImage("/Sprites/SB_00.png") 
  imageWall=    love.graphics.newImage("/Sprites/SB_01.png") 
  imageXbox=    love.graphics.newImage("/Sprites/SB_02.png") 
  imageBox=     love.graphics.newImage("/Sprites/SB_03.png") 
  imageBoxOk=   love.graphics.newImage("/Sprites/SB_04.png") 
 
  imageManX=     love.graphics.newImage("/Sprites/SB_05.png") -- Спит
  imageManR=     love.graphics.newImage("/Sprites/SB_06.png") 
  imageManL=     love.graphics.newImage("/Sprites/SB_07.png") 
  imageManD=     love.graphics.newImage("/Sprites/SB_08.png") 
  imageManU=     love.graphics.newImage("/Sprites/SB_09.png") 

  -- Выставляем уровень изначально
  gamereset(mygamelevel) 
end -- End LOAD

--###########################################
-- Функция установки игрового уровня по его номеру 
function gamereset(gamelevel)
  levelOK=0 -- Сброс флага выигрыша
   urad=0 uox=0 uoy=0 -- Сброс повороьа игрока
  -- Проверка номера уровня
  if gamelevel>50 then gamelevel=50 end
  if gamelevel<1  then gamelevel=1  end
  
  --Формирование текущего уровня gamepad из mARR
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
end  -- End GAMERESET

--###########################################
-- Функция МЕНЮ 
function gamemenu(menumsg)
    buttons = {"Выход1","Далее2","Сначала3","Первый4", escapebutton = 1, enterbutton = 4}
    keyMess=love.window.showMessageBox("SOCOBAN",menumsg,buttons)
    levelOK=0 
    if       keyMess==1 then  love.event.quit()           -- Выход
      elseif keyMess==2 then  mygamelevel=mygamelevel+1   -- Далее
      elseif keyMess==3 then  mygamelevel=mygamelevel     -- Сначала
      elseif keyMess==4 then  mygamelevel=1               -- Первый
    end
    if (mygamelevel<50) then gamereset(mygamelevel) end
end --end gamemenu

--###########################################
-- Рабочий процесс
function love.update(dt)
  -- Обработка клавиатуры
  function love.keyreleased(key)
    if (key == "left")  then gamekeyevent(-1,-2,0,0) imageMan=1 end
    if (key == "right") then gamekeyevent(1,2,0,0)   imageMan=2 end
    if (key == "up")    then gamekeyevent(0,0,-1,-2) imageMan=3 end  
    if (key == "down")  then gamekeyevent(0,0,1,2)   imageMan=4 end
    if (key == " " or key == "space")  then  gamemenu("Выберите режим:") end   
    if (key == "q" and mygamelevel<50) then  
        mygamelevel=mygamelevel+1
        gamereset(mygamelevel) 
    end    
  end
   
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
  if(levelOK==1) then flagOk=flagOk+1 end
  -- Время красного поля перед Message. Где *dt???
  if(flagOk==20) then gamemenu("Поздравляем!\nВы\nвыиграли") end
end -- End UPDATE
  
--########################################### 
 -- Прорисовка игрового поля
function love.draw()
  love.graphics.scale( 1 ) -- Масштабирование всего игрового поля
  for myi=1, 16 do
    for mxi=1,19 do
     if(gamepad[myi][mxi]==0) then love.graphics.draw(imageGround,(mxi-1)*32,(myi-1)*32) end -- пол
     if(gamepad[myi][mxi]==1) then love.graphics.draw(imageWall,  (mxi-1)*32,(myi-1)*32) end -- стена
     if(gamepad[myi][mxi]==2) then love.graphics.draw(imageXbox,  (mxi-1)*32,(myi-1)*32) end -- место
     if(gamepad[myi][mxi]==3) then love.graphics.draw(imageBox,   (mxi-1)*32,(myi-1)*32) end -- ящик
     if(gamepad[myi][mxi]==4) then love.graphics.draw(imageBoxOk, (mxi-1)*32,(myi-1)*32) end -- уст.ящик
     if(gamepad[myi][mxi]==5) or (gamepad[myi][mxi]==6) then -- дядя
       -- Ложим под дядю спрайт цели под ящик(крест), если он нужен (=6)
       if(gamepad[myi][mxi]==6) then love.graphics.draw(imageXbox,  (mxi-1)*32,(myi-1)*32) end -- место  
       if(imageMan==1) then love.graphics.draw(imageManL,(mxi-1)*32,(myi-1)*32) end 
       if(imageMan==2) then love.graphics.draw(imageManR,(mxi-1)*32,(myi-1)*32) end 
       if(imageMan==3) then love.graphics.draw(imageManU,(mxi-1)*32,(myi-1)*32) end 
       if(imageMan==4) then love.graphics.draw(imageManD,(mxi-1)*32,(myi-1)*32) end 
      end
    end
  end 
  
  -- Печать номера уровня голубыми цифрами
  love.graphics.setFont( bungee_font )
  love.graphics.setColor(0,0,255,255) 
  love.graphics.print("Level  "..mygamelevel, 620, 5)
  
  -- Отладка Печать Y ---------------------------------------------------------------------
  love.graphics.setFont( bungee_font )
  love.graphics.setColor(0,255,0,255) 
  love.graphics.print("Y="..many, 620, 40)
  love.graphics.print("kMes="..keyMess, 620, 80)
  -- Если выигрыш то всё красное,
  -- иначе восстанавливаем фон
  if(flagOk~=0) then 
    love.graphics.setColor(255,0,0,255)
  else
    love.graphics.setColor(255,255,255,255)
  end 
end  -- End DRAW