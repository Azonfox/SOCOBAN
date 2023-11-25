-- Версия для ПК с клавиатурой
pc={}

function pc.load()
    Help_font  = love.graphics.newFont("font.ttf", tileSize/4*3) 
    xrighmenu=6 -- размер меню в клетках справа от игрового поля для ПК
end

function pc.update(dt)
end

function pc.show()
  local textx=19
  -- Печать справки по клавишам
  love.graphics.setFont( Help_font )
  love.graphics.setColor(100,100,0,255)
  
  local helpmess={
    "  -HELP-",
    "F1-MENU",
    "F2-GAME OVER",
    "F3-NEXT",
    "F4-PREV",
    "F5-SOUND",
    "F12-QUIT",
    "SPACE-UNDO"}
  for k,v in ipairs(helpmess) do
   love.graphics.print(helpmess[k], tileSize*textx, tileSize*k)
  end
  if xsound==false then
   love.graphics.print("-NO", tileSize*textx+130, tileSize*6)
 else
   love.graphics.print("-YES", tileSize*textx+130, tileSize*6)
  end
end

 --###########################################
  -- Обработка клавиатуры, но
  -- в линукс utf8, поэтому берем не буквенные, а управляющие символы
  function love.keyreleased(key)
    levcompl.key() -- Если окно выигрыша - выходим
    
    if (key == "down")  then gamekeyevent(0,0,1,2)   kmen=0 end
    if (key == "up")    then gamekeyevent(0,0,-1,-2) kmen=1 end  
    if (key == "right") then gamekeyevent(1,2,0,0)   kmen=2 end
    if (key == "left")  then gamekeyevent(-1,-2,0,0) kmen=3 end
    if (key == " " or key == "space")  then  undoload() end -- восстанавливаем согласно откату   
    
    if (key == "f1")  then  gamemenu("Выберите режим:") end   
    if (key == "f2")  then  gamereset(mygamelevel) end   -- уровень на начало
    if (key == "f3" and mygamelevel<maxlevel) then  
        mygamelevel=mygamelevel+1
        gamereset(mygamelevel) 
    end    
    if (key == "f4" and mygamelevel>1) then  
        mygamelevel=mygamelevel-1
        gamereset(mygamelevel) 
    end    
   if key == "f5" then  
     if xsound then xsound=false else xsound=true end -- вкл\откл звук
   end 
 if key == "f12" then  love.event.quit()  end -- Выход
end    

