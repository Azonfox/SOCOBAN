-- Версия для ПК с клавиатурой
pc={}

 --###########################################
  -- Обработка клавиатуры, но
  -- в линукс utf8, поэтому берем не буквенные, а управляющие символы
  function love.keyreleased(key)
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
  if key == "f12" then  love.event.quit()  end -- Выход
end    


function pc.load()
    Help_font  = love.graphics.newFont("font.ttf", tileSize/4*3) 
    xrighmenu=9 -- размер меню справа от игрового поля для ПК
end

function pc.update(dt)
end

function pc.show()
  local textx=19
  -- Печать справки по клавишам
  love.graphics.setFont( Help_font )
  love.graphics.setColor(0,100,0,255) 
  love.graphics.print("  -HELP-",       tileSize*textx, tileSize*0)
  love.graphics.print("F1-MENU",        tileSize*textx, tileSize*1)
  love.graphics.print("F2-GAME OVER",   tileSize*textx, tileSize*2)
  love.graphics.print("F3-NEXT",        tileSize*textx, tileSize*3)
  love.graphics.print("F4-PREV",        tileSize*textx, tileSize*4)
  love.graphics.print("F12-QUIT",       tileSize*textx, tileSize*5)
  love.graphics.print("SPACE-UNDO",     tileSize*textx, tileSize*6)
end