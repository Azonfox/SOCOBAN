-- Функция МЕНЮ - заменить на графическое окно
menu={}

function menu.load()
  keyMess=0 -- Для проверки выбора меню
end

function menu.gamemenu(menumsg)
    buttons = {"Выход1","Далее2","Сначала3","Первый4", 
    escapebutton = 1, enterbutton = 4}
    keyMess=love.window.showMessageBox("SOCOBAN",menumsg,buttons)
    levelOK=0 
    if       keyMess==1 then  love.event.quit()           -- Выход
      elseif keyMess==2 then  mygamelevel=mygamelevel+1   -- Далее
      elseif keyMess==3 then  mygamelevel=mygamelevel     -- Сначала
      elseif keyMess==4 then  mygamelevel=1               -- Первый
    end
    if (mygamelevel<=maxlevel) then 
      gamereset(mygamelevel)
      bgfill() -- заполняем фон за пределами стен
    end
end --end gamemenu

