-- Изучение файловой системы для sokoban
function love.load()
  xfont=32
  Level_font  = love.graphics.newFont("font.ttf", xfont) 
  
  tabtest1={10,2,3,44,555,6,7,8,9,0,0123.1456} -- эталон, по умолчанию
  xxx={} -- рабочие переменные в таблице
  --считаем размер таблицы tabtest1 как эталон
  ylen=0
  for _,_ in pairs(tabtest1) do
    ylen=ylen+1
  end
  -- восстановление  данных
  -- Открываем файл для чтения и проверяем открытие
  file=love.filesystem.newFile("test.dat")
  file:open('r')
  --Если файл открылся, то считываем данные до конца файла
  if file:isOpen() then
    
    y=1;   xxx[1]=''
    for i=1, file:getSize() do
       x=file:read(1)
       if x~="," then -- накапливаем данные между разделителями
         xxx[y]=xxx[y]..x 
       else 
         y=y+1  -- у - это адрес данных в таблице и общий размер-1
         xxx[y]=''
       end 
    end
    y=y-1 -- уточняем размер данных из файла после цикла
    
    -- тест целостности файла, если менее необходимых цифр,
     --   то ставим по умолчанию ( имеем таблицу для этого)
     if y<ylen then xxx=tabtest1 end 
     file:close()
 
 else -- Если файла нет
    -- то ставим по умолчанию ( имеем таблицу tabtest1 для этого)
    xxx=tabtest1; y=0
  end
end

-- при выходе сохранить все  в файле
function love.quit()  
  -- запись РАБОЧИХ данных ххх в файл
  file=love.filesystem.newFile("test.dat")
  file:open('w') 
 --Если файл открылся, то пишем данные. Если не открылся, то
  -- при следующей загрузке игры будут данные по-умолчанию
  if file:isOpen() then
    for i=1, ylen do  --ipairs(xxx) все врямя добавляет данные :(
       file:write(xxx[i])
       file:write(",") --разделяем данные в файле
    end
    file:close()
  end
end





--############################################################################


function love.keypressed(key)  -- keyreleased
  if key == "f1" then  xxx[1]=xxx[1]+1   end -- Изменяем ххх
  if key == "f7" then  love.event.quit() end -- Выход
end 

function love.update(dt)
  xxx[10]=dt -- изменяем ххх
end

function love.draw()
  love.graphics.setBackgroundColor(0,0,255,255)
  love.graphics.setFont( Level_font )
  -- выводим рабочий массив xxx
  love.graphics.setColor(0,255,0,255)
  love.graphics.print("xxx:",      10, xfont*0)
  love.graphics.setColor(255,0,0,255)
  love.graphics.print("1="..xxx[1], 10, xfont*1)
  love.graphics.print("2="..xxx[2], 10, xfont*2)
  love.graphics.print("3="..xxx[3], 10, xfont*3)
  love.graphics.print("4="..xxx[4], 10, xfont*4)
  love.graphics.print("5="..xxx[5], 10, xfont*5)
  love.graphics.print("6="..xxx[6], 10, xfont*6)
  love.graphics.print("7="..xxx[7], 10, xfont*7)
  love.graphics.print("8="..xxx[8], 10, xfont*8)
  love.graphics.print("9="..xxx[9], 10, xfont*9)
  love.graphics.print("10="..xxx[10], 10,xfont*10)
  love.graphics.print("11="..xxx[11], 10,xfont*11)
    
  love.graphics.setColor(0,255,0,255)
  love.graphics.print("Y="..y,        300,xfont*1)
  love.graphics.print("YLEN="..ylen,  300,xfont*2)
    
  love.graphics.setColor(255,100,0,255)
  love.graphics.print("F1-new xxx[1]", 300, xfont*5)  
  love.graphics.print("F7-quit",        300, xfont*7)  
end

