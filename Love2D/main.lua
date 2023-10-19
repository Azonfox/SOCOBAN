﻿--[[############ SOKOBAN ####################
0 - пол     |  3 - ящик на свободном поле
1 - стена   |  4 - ящик стоит на цели
2 - цель    |  5 - MEN на свободном поле
            |  6 - MEN стоит на цели --]]
--###########################################
-- Начальная загрузка
function love.load()
  --Include
   --require "levels"  -- Все уровни
  require "testlevels" -- Тестовые уровни
  require "keyevent"   -- Движения игрока
  require "android"    -- для android
  --Переменные
  manx=1 --Координаты игрока XY
  many=1
  mygamelevel=1  -- начальный уровень
  keyMess=0 -- Для проверки выбора меню

  TileQ={}  -- Вырезенные спрайты 
  xblock=0  -- Считанный байт игрового поля
  kmen=0    -- для вращения игрока
  tileSize=32
  
  -- Координаты в пикселях поля стрелок управления
  ttx=0
  tty=0
  skey=3 --размер кнопки смартфона в клетках
  tkx0=19*tileSize --Начальная точка поля стрелок управления X
  tkwh=tileSize*skey
  tkx1=tkx0+tkwh 
  tkx2=tkx1+tkwh    
  tkx3=tkx2+tkwh   
  
  tky0=0+tileSize --Начальная точка поля стрелок управления Y
  tky1=tky0+tkwh  
  tky2=tky1+tkwh   
  tky3=tky2+tkwh
  
  -- Шрифт
  bungee_font = love.graphics.newFont("font.ttf", tileSize/2 )  
  -- Картинки
  TileSetPng=love.graphics.newImage("tileset.png")
  --TileSetPng=love.graphics.newImage("image64.png")
  TileSetPng:setFilter("nearest","linear")
  ----- Вырезаем спрайты игрового поля
  -- Игровое поле
  TileQ[0]=love.graphics.newQuad(0*tileSize,0*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[1]=love.graphics.newQuad(1*tileSize,0*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[2]=love.graphics.newQuad(2*tileSize,0*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[3]=love.graphics.newQuad(3*tileSize,0*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[4]=love.graphics.newQuad(4*tileSize,0*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  -- Men
  TileQ[5]=love.graphics.newQuad(0*tileSize,1*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[6]=love.graphics.newQuad(1*tileSize,1*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[7]=love.graphics.newQuad(2*tileSize,1*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[8]=love.graphics.newQuad(3*tileSize,1*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
  TileQ[9]=love.graphics.newQuad(4*tileSize,1*tileSize,tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
 
  -- Выставляем уровень изначально
  gamereset(mygamelevel) 
  --  Расчитываем и устанавливаем масштабирование
  success = love.window.setFullscreen( true,"desktop" )
  myscale=love.graphics.getHeight()/(16*tileSize)
  
end -- End LOAD

--###########################################
-- Функция установки игрового уровня по его номеру 
function gamereset(gamelevel)
  levelOK=0 -- Сброс флага выигрыша
   urad=0 uox=0 uoy=0 -- Сброс поворота игрока
   kmen=0
  -- Проверка номера уровня
  if gamelevel>maxlevel then gamelevel=maxlevel end
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
    if (mygamelevel<=maxlevel) then gamereset(mygamelevel) end
end --end gamemenu

--###########################################
-- Рабочий процесс
function love.update(dt)
  
  touchkey() 
  --for I=1,  100000  do  ttx=100000000*dt end -- Задержка :(
  
  -- Обработка клавиатуры
  function love.keyreleased(key)
    if (key == "right") then gamekeyevent(1,2,0,0)   kmen=1 end
    if (key == "left")  then gamekeyevent(-1,-2,0,0) kmen=2 end
    if (key == "down")  then gamekeyevent(0,0,1,2)   kmen=3 end
    if (key == "up")    then gamekeyevent(0,0,-1,-2) kmen=4 end  
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
  love.graphics.scale( myscale ) -- Масштабирование всего игрового поля
  
  for myi=1, 16 do
    for mxi=1,19 do
     xblock=(gamepad[myi][mxi]) 
     if xblock>=5 then -- направления игрока:
      -- Подкладываем Х под игрока на поле
      if(xblock==6) then love.graphics.draw(TileSetPng,TileQ[2],(mxi-1)*tileSize,(myi-1)*tileSize) end -- место 
      xblock=5+kmen -- учитываем направление движения
     end
      love.graphics.draw(TileSetPng,TileQ[xblock],(mxi-1)*tileSize,(myi-1)*tileSize)
    end
  end
  
  -- Печать номера уровня голубыми цифрами
  love.graphics.setFont( bungee_font )
  love.graphics.setColor(0,0,255,255) 
  love.graphics.print("Level  "..mygamelevel, tileSize*20, tileSize*12)
  
  -- Отладка Печать Y ---------------------------------------------------------------------
  love.graphics.setFont( bungee_font )
  love.graphics.setColor(0,255,0,255) 
  love.graphics.print("Y="..many, tileSize*20, tileSize*13)
  love.graphics.print("kMes="..keyMess, tileSize*20, tileSize*14)
  love.graphics.print(love.graphics.getWidth().." x "..love.graphics.getHeight(), tileSize*20, tileSize*15)  
  
  -- Если выигрыш то всё красное,
  -- иначе восстанавливаем фон
  if(flagOk~=0) then 
    love.graphics.setColor(255,0,0,255)
  else
    love.graphics.setColor(255,255,255,255)
  end 
  
  -- Рисуем Стрелки
  love.graphics.rectangle("fill",tkx1,tky0, tkwh, tkwh) -- ВВерх
  love.graphics.rectangle("fill",tkx1,tky2, tkwh, tkwh) -- Вниз
  love.graphics.rectangle("fill",tkx0,tky1, tkwh, tkwh) -- ВЛево
  love.graphics.rectangle("fill",tkx2,tky1, tkwh, tkwh) -- Вправо
  
  love.graphics.circle("fill",ttx,tty,20)
  
end  -- End DRAW