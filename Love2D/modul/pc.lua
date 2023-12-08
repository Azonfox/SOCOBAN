-- Версия для ПК с клавиатурой
pc={}

function pc.load()
    xscreen=true -- full screen
    xrighmenu=6 -- размер меню в клетках справа от игрового поля для ПК
    helpmess={
    "",
    "F3-NEXT",
    "F4-PREV",
    "F5-SOUND", 
    "F9-SCREEN",
    "F12-QUIT",
    "ENT-RESTART",
    "SPACE-UNDO"}
   if menuflag then helpmess[1]="F1-MENU" end
end

function pc.update(dt)
end

function pc.show()
  -- заливаем фон под меню
  --при выигрыше меняем цвет
  if compliteflag then love.graphics.setColor(0,0,255,0) 
    else love.graphics.setColor(255,255,255,255) end
  for myi=0,  love.graphics.getHeight()/tileSize/myscale do
    for mxi=19,love.graphics.getWidth()/tileSize/myscale do 
     love.graphics.draw(TileSetPng,TileQ[22],(mxi)*tileSize,(myi)*tileSize)
    end
  end
    -- ПЕЧАТЬ ДАННЫХ ИГРЫ
  -- подкладываем фон с рамкой под text
  love.graphics.setColor(100,0,0,150) 
  love.graphics.rectangle("fill",tileSize*19+4, tileSize*0+5,
      tileSize*6-7,tileSize*2-3,10,10)     
  love.graphics.setColor(0,0,0,255) 
  love.graphics.setLineWidth( 3 )    -- толщина линии
  love.graphics.rectangle("line",tileSize*19+4, tileSize*0+5,
      tileSize*6-7,tileSize*2-3,10,10)     
    -- Печать системного времени    
  love.graphics.setColor(25,25,50,255)
  love.graphics.setFont(time_font)
  love.graphics.print(os_time,tileSize*23+8, tileSize*1-9)
  -- печать названия игры  
  love.graphics.setFont( Name_font )
  love.graphics.setColor(200,200,0,255)
  love.graphics.print("BOXES", tileSize*19+12, tileSize*0+21)
  -- Печать версии    
  love.graphics.setColor(25,25,50,255)
  love.graphics.setFont(time_font)
  love.graphics.print("v "..gameversion,tileSize*19+14, tileSize*1+14)
    -- Печать автора    
  love.graphics.setColor(25,25,50,255)
  love.graphics.setFont(time_font)
  love.graphics.print("AzfoxGame",tileSize*19+10, tileSize*0+7)
  -- Печать сайта    
  love.graphics.setColor(25,25,50,255)
  love.graphics.setFont(time_font)
  love.graphics.print("AzfoxGame.my.cam",tileSize*19+1, tileSize*13+10)
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
  love.graphics.print(countstep, tileSize*20, tileSize*14+4)
  -- Печать номера уровня 
  love.graphics.setFont( Level_font )
  love.graphics.setColor(200,200,0,255) 
  love.graphics.print("LEVEL   "..mygamelevel, tileSize*19+10, tileSize*15-7)

  -- Печать справки по клавишам
  local textx=19
  --при выигрыше не показываем справку...
  if compliteflag then love.graphics.setColor(0,0,0,0) 
    else love.graphics.setColor(25,25,50,255) end
  love.graphics.setFont( Help_font )
  -- печать горячих клавиш
  for k,v in ipairs(helpmess) do
   love.graphics.print(helpmess[k], tileSize*textx+6, tileSize*(k+1))
  end
  
  if xsound==false then
   love.graphics.print("-NO", tileSize*textx+130, tileSize*5)
 else
   love.graphics.print("-YES", tileSize*textx+130, tileSize*5)
  end
end

 --###########################################
  -- Обработка клавиатуры, но
  -- в линукс utf8, поэтому берем не буквенные, а управляющие символы
  function love.keypressed(key)  -- keyreleased
    -- Если окно выигрыша отключаем и выходим
    if compliteflag and (key == " " or key == "space") 
      then levcompl.key(); return; end
    if compliteflag then return end
        
    if (key == "down")  then gamekeyevent(0,0,1,2)   kmen=0 end
    if (key == "up")    then gamekeyevent(0,0,-1,-2) kmen=1 end  
    if (key == "right") then gamekeyevent(1,2,0,0)   kmen=2 end
    if (key == "left")  then gamekeyevent(-1,-2,0,0) kmen=3 end
    if (key == " " or key == "space")  then  undoload() end -- восстанавливаем согласно откату   
    
    if (key == "f1")  and menuflag then  menu.gamemenu("Выберите режим:") end   
    if (key == "return")  then -- Уровень на начало
        local tmp=countstep  -- Не сбрасываем счетчик ходов
        gamereset(mygamelevel)         -- при сбросе уровня
        bgfill() -- заполняем фон за пределами стен
        countstep=tmp 
    end   
    
    if (key == "f3" and mygamelevel<maxlevel) then  
        mygamelevel=mygamelevel+1
        gamereset(mygamelevel)
        bgfill() -- заполняем фон за пределами стен
    end    
    if (key == "f4" and mygamelevel>1) then  
        mygamelevel=mygamelevel-1
        gamereset(mygamelevel) 
        bgfill() -- заполняем фон за пределами стен
    end    
   if key == "f5" then  
     if xsound then xsound=false else xsound=true end -- вкл\откл звук
   end 
    if key == "f9" then  love.window.setFullscreen(xscreen,"desktop")
      if xscreen then xscreen=false else xscreen=true end -- вкл\откл full-screen
    end
 
 if key == "f12" then  love.event.quit()  end -- Выход
end    
