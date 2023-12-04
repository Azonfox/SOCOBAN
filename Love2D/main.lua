-- 02-12-2023 HP
--[[############ SOKOBAN #################
0 - пол     |  3 - ящик на свободном поле
1 - стена   |  4 - ящик стоит на цели
2 - цель    |  5 - MEN на свободном поле
            |  6 - MEN стоит на цели --]]
--################################################################################################## 
-- Начальная загрузка
function love.load()
  -- Настройки
  debudsflag=false   -- используем отладку
  androidflag=false  -- версия для android, ИЛИ
      menuflag=false  -- меню
       pcflag=true  -- версия для ПК
  prorabflag=true   -- включить прораба в игру
  filesflag=true    -- вкл. файловую систему
  xsound=false       -- откл. звуки  
 
  --Include
  if androidflag then require "modul/android" end -- дополнения для запуска на смартфоне
  if pcflag then require "modul/pc" end -- дополнения для запуска на ПК
  if debudsflag  then require "modul/debugs"  end -- дополнения для отладки
  if prorabflag  then require "modul/prorab"  end -- учетчик-контроллер прораб :)
  if filesflag   then require "modul/files"   end -- Файлы
  if menuflag    then require "modul/menu"    end -- Меню
  require "modul/levels"  -- Все рабочие уровни
  --require "modul/testlevels" -- Тестовые уровни
  require "modul/keyevent"   -- Движения игрока
  require "modul/levcompl"   -- Проверка выигрыша и показ
  --Timer=require "lib/hump/timer"   -- Чужая Библиотека таймера
  
  -- Константы
  tileSize=32    -- размер ячейки и спрайта!
  --maxlevel находится в файлах массивов уровней
  -- Таблицы
  gamepad={} -- игровой уровень 19х16
  TileQ={}  -- Вырезенные спрайты 
  UndoMen={}  -- Таблица UNDO для отката
  DataTime={}  --время
  --Переменные
  countstep=0 --  проделано шагов
  manx=1 --Координаты игрока XY
  many=1
  mygamelevel=1  -- номер начального уровня
  xblock=0  -- Считанный байт игрового поля
  kmen=0    -- направление игрока вниз
  rkmen=0   -- не толкающий игрок 
  
  if androidflag then android.load() end
  if debudsflag  then debugs.load()  end
  if prorabflag  then prorab.load()  end
  if menuflag    then menu.load()    end
  if pcflag      then pc.load()      end
  levcompl.load()
  
  love.graphics.setDefaultFilter("nearest") -- сглаживаем пиксели
  
  -- Звуки
  Mstep=love.audio.newSource("sound/step.ogg","static")
  Mwall=love.audio.newSource("sound/wall.ogg","static")
  Mbox=love.audio.newSource("sound/box.ogg","static")
  Lgong=love.audio.newSource("sound/gong.ogg","static")
  -- Шрифт
  status_font = love.graphics.newFont("font/font.ttf", tileSize/4*3 )  
  Level_font  = love.graphics.newFont("font/font.ttf", tileSize)  
  time_font   = love.graphics.newFont("font/freemonobold.ttf", tileSize/5*3)  
  Name_font   = love.graphics.newFont("font/freemonobold.ttf", tileSize)
  -- Картинки
  TileSetPng=love.graphics.newImage("image/tileset3.png")
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
  if filesflag  then files.load() end
  bgfill() -- заполняем фон за пределами стен
  --timer = Timer() -- включить чужой таймер hump
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
   -- Замена пустого внешнего поля 0  вокруг стен на фон сcodefil
  function bgfill()
    -- (при наличии редактора УРОВНЕЙ возможна изначальная 
     ---прорисовка расширенным трехмерным тайлсетом) 
     -- или подготовить все уровни заранее...
   -- горизонтально...
   local codefill=99
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
      if(gamepad[myi][mxi]==0 or gamepad[myi][mxi]==codefill) 
         then gamepad[myi][mxi]=codefill else break end 
    end
    for myi=16,1,-1 do 
      if(gamepad[myi][mxi]==0 or gamepad[myi][mxi]==codefill) 
         then gamepad[myi][mxi]=codefill else break end 
    end   
   end  
end


--###########################################
--  Расчитываем и устанавливаем масштабирование 
function myscreen()
  -- Вначале расчитываем коофициент по высоте
  --success = love.window.setFullscreen(true,"desktop" )  -- см. CONF.LUA 
  --love.window.maximize() -- Распахиваем окно на весь экран (навсегда)
  myscale=love.graphics.getHeight()/(16*tileSize)
  -- Но если не входит по длине, пересчитываем масштаб
  if (love.graphics.getWidth()/myscale<((19+xrighmenu)*tileSize)) then 
        myscale=love.graphics.getWidth()/((19+xrighmenu)*tileSize) end
  -- Сдвиг экрана вправо для камеры смартфона 
  if androidflag then mytranslate = androidtranslate else mytranslate=0 end  
end

--###########################################
-- Функция установки игрового уровня по его номеру 
function gamereset(gamelevel)
  countstep=0 -- сброс счетчика шагов
  levelOK=0 -- Сброс флага выигрыша
   urad=0 uox=0 uoy=0 -- Сброс поворота игрока
   kmen=0 rkmen=0
  -- Проверка номера уровня
  if gamelevel>maxlevel then gamelevel=maxlevel end
  if gamelevel<1  then gamelevel=1  end
  --Формирование текущего уровня gamepad из mARR
  local adr=(gamelevel-1)*19*16
---  gamepad={}
   for myi=1, 16 do
    gamepad[myi]={}
    for mxi=1,19 do
      adr=adr+1
      gamepad[myi][mxi]=mARR[adr]
      if(gamepad[myi][mxi]==5) then manx=mxi many=myi end -- игрок
    end
   end 
    -- изначально сохраняем информацию об откате
    undosave()
end  -- End GAMERESET

 
--################################################################################################## 
-- Рабочий процесс
function love.update(dt)
  if debudsflag then debugs.update(dt) end
  if prorabflag then prorab.update(dt) end
  levcompl.update(dt) --Проверка выигрыша-есть ли вообще свободные ящики? 
  --формируем строку времени
  DataTime=os.date('*t')
  xhour=DataTime.hour
  xminut=DataTime.min
  if  xhour<10 then  xhour="0"..xhour  end
  if xminut<10 then xminut="0"..xminut end
  os_time=xhour..":"..xminut
end -- End UPDATE
  
  
  
  
  
--################################################################################################## 
-- Прорисовка игрового поля
function love.draw()
  love.graphics.scale( myscale ) -- Масштабирование всего игрового поля
 love.graphics.translate(mytranslate,0)  -- Сдвиг для камеры смартфона
 -- устанавливаем фон - зачем?
 love.graphics.setBackgroundColor(0,0,0,255)

  -- Заливаем фон под игровым полем
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
  --
  -- постоянное формирование игрового поля
  for myi=1, 16 do
    for mxi=1,19 do
     xblock=(gamepad[myi][mxi]) 
     if xblock>=5 and  xblock<11 then -- печать игрока:
     -- Подкладываем пол под игрока
      if(xblock==5) then love.graphics.draw(TileSetPng,TileQ[0],
            (mxi-1)*tileSize,(myi-1)*tileSize) end  
     -- Подкладываем Х (место для ящика) под игрока на поле
      if(xblock==6) then love.graphics.draw(TileSetPng,TileQ[2],
            (mxi-1)*tileSize,(myi-1)*tileSize) end  
      xblock=5+kmen+rkmen -- учитываем направление движения и толкание
     end
     -- собственно печать тайла в соответствии с картой
     if xblock<99 then
      love.graphics.draw(TileSetPng,TileQ[xblock],(mxi-1)*tileSize,
          (myi-1)*tileSize)
     end  
   end
  end
  
  -- ПЕЧАТЬ ДАННЫХ ИГРЫ
  -- подкладываем фон с рамкой под текст
  love.graphics.setColor(100,0,0,255) 
  love.graphics.rectangle("fill",tileSize*19+4, tileSize*0+10,
      tileSize*6-7,tileSize*1-15,10,10)     
  -- Печать системного времени    
  love.graphics.setColor(0,255,0,255)
  love.graphics.setFont(time_font)
  love.graphics.print(os_time,tileSize*23, tileSize*0+8)
  -- печать названия игры  
  love.graphics.setFont( Name_font )
  love.graphics.setColor(200,200,0,255)
  love.graphics.print("BOXES", tileSize*19, tileSize*0)
  -- ПЕЧАТЬ СТАТИСТИКИ
  -- подкладываем фон с рамкой под информацию
  love.graphics.setColor(100,0,0,150) 
  love.graphics.rectangle("fill",tileSize*19+4, tileSize*14,
      tileSize*6-7,tileSize*2-5,10,10)     
  love.graphics.setColor(0,0,0,255) 
  love.graphics.setLineWidth( 3 )    -- толщина линии
  love.graphics.rectangle("line",tileSize*19+4, tileSize*14,
      tileSize*6-7,tileSize*2-5,10,10)     
    -- Печать счетчика шагов
  love.graphics.setFont( status_font )
  love.graphics.setColor(150,150,0,255) 
  love.graphics.print("* "..countstep, tileSize*19+10, tileSize*14+4)
  -- Печать номера уровня 
  love.graphics.setFont( Level_font )
  love.graphics.setColor(200,200,00,255) 
  love.graphics.print("Level  "..mygamelevel, tileSize*19+10, tileSize*15-6)
  
  -- Печать SHOW из модулей, если они включены
  -- Внимание на порядок следования - зависят цвета при выигрыше
  if debudsflag then debugs.show() end   -- Отладочная информация
  if pcflag then pc.show() end           -- Отличия для ПК
  if androidflag then android.show() end -- Отличия для смартфона
  levcompl.show()        -- Если выигрыш. Вызываем именно отсюда!
  if prorabflag  then prorab.show() end  -- Рисуем полет Прораба 
  
end  -- End DRAW

function love.quit() -- При выходе из системы
 if filesflag  then files.quit() end
end