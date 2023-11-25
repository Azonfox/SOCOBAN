android={}
function android.load()
  -- Сдвиг вправо для камеры смартфона
  androidtranslate=tileSize
  -- Координаты в пикселях поля стрелок управления
  --  изначально кружок от пальца не показываем.
  ttx=1000; tty=0;
  skey=3 --размер кнопки смартфона в клетках игрового поля (tileSize)
  
  --Начальная точка поля стрелок управления X
  tkx0=19*tileSize 
  tkwh=tileSize*skey
  tkx1=tkx0+tkwh 
  tkx2=tkx1+tkwh    
  tkx3=tkx2+tkwh  
  --Начальная точка поля стрелок управления Y
  tky0=tileSize 
  tky1=tky0+tkwh  
  tky2=tky1+tkwh   
  tky3=tky2+tkwh
  
  tmy1=tky3+tileSize  --Начальная точка поля Menu
  tmy2=tmy1+tkwh   
    -- картинки
    ArrowsPng=love.graphics.newImage("arrows.png")
end


--###########################################
-- Обработка нажатия в смартфоне
function love.touchpressed( id, tttx, ttty)
  -- переназначаем для показа кружка от пальца.
  -- делаем поправку на Сдвиг экрана вправо 
  ttx=tttx-mytranslate
  tty=ttty
  -- Коофициенты несовпадения TOUCH c экраном 
      ttx=ttx/myscale
      tty=tty/myscale
      -- определяем нажатую область как стрелки
      if  ttx>tkx2 and ttx<tkx3 and tty>tky1 and tty<tky2 then gamekeyevent(1,2,0,0)   kmen=1 end -- Right
      if  ttx>tkx0 and ttx<tkx1 and tty>tky1 and tty<tky2 then gamekeyevent(-1,-2,0,0) kmen=2 end -- Left
      if  ttx>tkx1 and ttx<tkx2 and tty>tky2 and tty<tky3 then gamekeyevent(0,0,1,2)   kmen=3 end -- Down
      if  ttx>tkx1 and ttx<tkx2 and tty>tky0 and tty<tky1 then gamekeyevent(0,0,-1,-2) kmen=4 end -- UP
      --if ttx>tkx0 and ttx<tkx1 and tty>tky3+tky1 and tty<tky3+tky2 then     gamemenu("menumsg") end
      -- Проверка кнопок меню
      if ttx>tkx0 and ttx<tkx1 and tty>tmy1 and tty<tmy2 then  undoload() end
      if ttx>tkx1 and ttx<tkx2 and tty>tmy1 and tty<tmy2 then  gamereset(mygamelevel) end
      if ttx>tkx2 and ttx<tkx3 and tty>tmy1 and tty<tmy2 then  gamemenu("MENU-touch") end
 end

--###########################################
-- Рисуем в смартфоне
function android.show()
  love.graphics.rectangle("line",tkx1,tky0, tkwh, tkwh) -- ВВерх
  love.graphics.rectangle("line",tkx1,tky2, tkwh, tkwh) -- Вниз
  love.graphics.rectangle("line",tkx0,tky1, tkwh, tkwh) -- ВЛево
  love.graphics.rectangle("line",tkx2,tky1, tkwh, tkwh) -- Вправо
    -- menu под стрелками
  love.graphics.rectangle("line",tkx0,tky3+tileSize, tkwh, tkwh) -- Левая
  love.graphics.rectangle("line",tkx0+tileSize*skey,tky3+tileSize, tkwh, tkwh) -- Средняя
  love.graphics.rectangle("line",tkx0+tileSize*skey*2,tky3+tileSize, tkwh, tkwh) -- Правая
  -- картинка стрелок
  love.graphics.draw(ArrowsPng,tileSize*19,tileSize*1)
  --точка от пальца смартфона
  love.graphics.circle("fill",ttx,tty,20) 
  
end
