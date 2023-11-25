﻿-- 25-11-2023 HP
--[[############ SOKOBAN #################
0 - пол     |  3 - ящик на свободном поле
1 - стена   |  4 - ящик стоит на цели
2 - цель    |  5 - MEN на свободном поле
            |  6 - MEN стоит на цели --]]
--################################################################################################## 
-- Начальная загрузка
function love.load()
  -- Настройки
  debudsflag=true    -- используем отладку
  androidflag=true  -- версия для android
  prorabflag=true  
  --Include
  if androidflag then require "android" end -- дополнения для запуска на смартфоне
  if debudsflag  then require "debugs"  end -- дополнения для отладки
  if prorabflag  then require "prorab"  end -- учетчик-контроллер прораб :)
  
  
  require "levels"  -- Все рабочие уровни
  --require "testlevels" -- Тестовые уровни
  require "keyevent"   -- Движения игрока
  love.graphics.setDefaultFilter("nearest") -- сглаживаем пиксели
  
  -- Константы
  tileSize=32    -- размер ячейки и спрайта!
    
  --Переменные
  manx=1 --Координаты игрока XY
  many=1
  mygamelevel=1  -- номер начального уровня
  keyMess=0 -- Для проверки выбора меню

  TileQ={}  -- Вырезенные спрайты 
  UndoMen={}  -- Таблица UNDO для отката
  xblock=0  -- Считанный байт игрового поля
  kmen=0    -- направление игрока
  rkmen=0   -- не толкающий игрок 
  xsound=true  -- вкл. звуки
  
  if androidflag then android.load() end
  if debudsflag then debugs.load() end
  if prorabflag then prorab.load() end
  
  -- Звуки
  Mstep=love.audio.newSource("step.ogg","static")
  Mwall=love.audio.newSource("wall.ogg","static")
  Mbox=love.audio.newSource("box.ogg","static")
  -- Шрифт
  status_font = love.graphics.newFont("font.ttf", tileSize/2 )  
  Level_font  = love.graphics.newFont("font.ttf", tileSize)  
  -- Картинки
  TileSetPng=love.graphics.newImage("tileset2.png")
  --TileSetPng:setFilter("nearest","linear") -- см выше love.graphics.setDefaultFilter
  -- Вырезаем спрайты - Игровое поле
  QuadTile( 0,0,0);  QuadTile( 1,1,0);  QuadTile( 2,2,0) 
  QuadTile( 3,3,0);  QuadTile( 4,4,0);  QuadTile(21,5,0); 
  QuadTile(22,6,0);  QuadTile(23,7,0);
    -- Вырезаем спрайты - Men
  QuadTile(5,0,1);   QuadTile(6,1,1);   QuadTile(7,2,1); 
  QuadTile(8,3,1);   QuadTile(9,4,1);   QuadTile(10,5,1);
  QuadTile(11,6,1);   QuadTile(12,7,1);
  -- Выставляем уровень изначально
  gamereset(mygamelevel) 
  myscreen() -- Расчитываем экран и масштаб
end -- End LOAD

--###########################################??????????
-- Функция для удобного сокращения длины записей Quad
function QuadTile(n,x,y)
  TileQ[n]=love.graphics.newQuad(x*tileSize,y*tileSize,
    tileSize,tileSize,TileSetPng:getWidth(),TileSetPng:getHeight())
end

--###########################################??????????
-- При изменении окна пересчитываем масштаб
function love.resize()
  myscreen()
end

--###########################################
--  Расчитываем и устанавливаем масштабирование 
function myscreen()
  -- Вначале по высоте
  --success = love.window.setFullscreen(true,"desktop" )  -- см. CONF.LUA 
  myscale=love.graphics.getHeight()/(16*tileSize)
  -- Но если не входит по длине, пересчитываем масштаб
  if (love.graphics.getWidth()/myscale<((19+9+1)*tileSize)) then 
        myscale=love.graphics.getWidth()/((19+9+1)*tileSize) end
  -- Сдвиг экрана вправо для камеры смартфона 
  if androidflag then mytranslate = androidtranslate else mytranslate=0 end  
end

--###########################################
-- Функция установки игрового уровня по его номеру 
function gamereset(gamelevel)
  levelOK=0 -- Сброс флага выигрыша
   urad=0 uox=0 uoy=0 -- Сброс поворота игрока
   kmen=0 rkmen=0
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
   
   
   -- Замена пустого внешнего поля 0  вокруг стен на фон 11
    -- (при наличии редактора УРОВНЕЙ возможна изначальная прорисовка расширенным трехмерным тайлсетом)
   -- горизонтально...
   local codefill=222
   for myi=1,16 do
    for mxi=1,19 do 
      if(gamepad[myi][mxi]==0) then gamepad[myi][mxi]=codefill else break end 
    end
    for mxi=19,1,-1 do 
      if(gamepad[myi][mxi]==0) then gamepad[myi][mxi]=codefill else break end 
    end   
   end    
   -- .. и вертикально
    for mxi=1,19 do
    for myi=1,16 do 
      if(gamepad[myi][mxi]==0 or gamepad[myi][mxi]==codefill) then gamepad[myi][mxi]=codefill else break end 
    end
    for myi=16,1,-1 do 
      if(gamepad[myi][mxi]==0 or gamepad[myi][mxi]==codefill) then gamepad[myi][mxi]=codefill else break end 
    end   
   end  
    
    -- изначально сохраняем информацию об откате
    undosave()
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
  -- Обработка клавиатуры, но
  -- в линукс utf8, поэтому берем не буквенные, а управляющие символы
  function love.keyreleased(key)
    if (key == "down")  then gamekeyevent(0,0,1,2)   kmen=0 end
    if (key == "up")    then gamekeyevent(0,0,-1,-2) kmen=1 end  
    if (key == "right") then gamekeyevent(1,2,0,0)   kmen=2 end
    if (key == "left")  then gamekeyevent(-1,-2,0,0) kmen=3 end
    if (key == " " or key == "space")  then  gamemenu("Выберите режим:") end   
    if (key == "return" and mygamelevel<50) then  
        mygamelevel=mygamelevel+1
        gamereset(mygamelevel) 
    end    
    if (key == "f1")  then  undoload() end   -- восстанавливаем согласно откату
    if (key == "f2")  then  gamereset(mygamelevel) end   -- уровень на начало
    
  end


--################################################################################################## 
-- Рабочий процесс
function love.update(dt)
  if debudsflag then debugs.update(dt) end
  if prorabflag then prorab.update(dt) end
    
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
  -- Время красного поля перед Message. Плохо! Где *dt??????????????????????????????
  if(flagOk==20) then gamemenu("Поздравляем!\nВы\nвыиграли") end
end -- End UPDATE
  
  
  
  
  
--################################################################################################## 
-- Прорисовка игрового поля
function love.draw()
  love.graphics.scale( myscale ) -- Масштабирование всего игрового поля
 love.graphics.translate(mytranslate,0)  -- Сдвиг для камеры смартфона
 -- устанавливаем фон - зачем?
 love.graphics.setBackgroundColor(0,0,0,255)

  -- Заливаем фон под игровым полем, 
  --mxi=-1 это учитываем пустой столбец слева для камеры смартфона...???
  for myi=0, love.graphics.getHeight()/tileSize/myscale do
     for mxi=-1,love.graphics.getWidth()/tileSize/myscale do 
        love.graphics.draw(TileSetPng,TileQ[21],(mxi)*tileSize,(myi)*tileSize)
    end
  end  
    -- и заливаем фон под меню
  for myi=0,  love.graphics.getHeight()/tileSize/myscale do
    for mxi=19,love.graphics.getWidth()/tileSize/myscale do 
     love.graphics.draw(TileSetPng,TileQ[22],(mxi)*tileSize,(myi)*tileSize)
    end
  end
  
  -- постоянное формирование игрового поля
  for myi=1, 16 do
    for mxi=1,19 do
     xblock=(gamepad[myi][mxi]) 
     if xblock>=5 and  xblock<11 then -- печать игрока:
     -- Подкладываем пол под игрока
      if(xblock==5) then love.graphics.draw(TileSetPng,TileQ[0],(mxi-1)*tileSize,(myi-1)*tileSize) end  
     -- Подкладываем Х (место для ящика) под игрока на поле
      if(xblock==6) then love.graphics.draw(TileSetPng,TileQ[2],(mxi-1)*tileSize,(myi-1)*tileSize) end  
      xblock=5+kmen+rkmen -- учитываем направление движения и толкание
     end
     -- собственно печать тайла в соответствии с картой
     if xblock<100 then
      love.graphics.draw(TileSetPng,TileQ[xblock],(mxi-1)*tileSize,(myi-1)*tileSize)
     end  
   end
  end
  
  -- Печать номера уровня голубыми цифрами
  love.graphics.setFont( Level_font )
  love.graphics.setColor(0,0,255,255) 
  love.graphics.print("Level  "..mygamelevel, tileSize*20, tileSize*15)
  
  if debudsflag then debugs.show() end
  
  -- Если выигрыш то всё красное,
  -- иначе восстанавливаем  цвета
  if(flagOk~=0) then 
    love.graphics.setColor(255,0,0,255)
  else
    love.graphics.setColor(255,255,255,255)
  end 
  
  if androidflag then android.show() end -- Рисуем Стрелки >>>>>>>>
  if prorabflag  then prorab.show() end  -- Рисуем Рораба >>>>>>>>>
  
end  -- End DRAW