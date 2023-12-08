-- Версия для ПК с клавиатурой
pc={}

function pc.load()
    xscreen=true -- full screen
    Help_font  = love.graphics.newFont("font/font.ttf", tileSize/4*3) 
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
  -- Печать справки по клавишам
  local textx=19
  love.graphics.setColor(25,25,50,255)
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
