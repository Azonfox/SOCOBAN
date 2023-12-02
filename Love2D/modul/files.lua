--Сохраняем\восстанавливаем:
files={}

function files.write()
  -- запись РАБОЧИХ данных в файл
  file=love.filesystem.newFile("test.dat")
  file:open('w') 
 --Если файл открылся, то пишем данные. Если не открылся, то
  -- при следующей загрузке игры будут данные по-умолчанию
  if file:isOpen() then
   -- table gamepad
   for myi=1, 16 do
    for mxi=1,19 do
       file:write(gamepad[myi][mxi]); file:write(",")
    end
   end 
   -- запись переменных
  file:write(countstep); file:write(",") --  проделано шагов
  file:write(manx); file:write(",")      --  координаты игрока
  file:write(many); file:write(",") 
  file:write(kmen); file:write(",")      -- направление игрока
  file:write(rkmen); file:write(",")     -- толкающий игрок
  file:write(mygamelevel); file:write(",")  --номер уровня
  file:write(filesb2n(xsound)); file:write(",")     --звук
  -- table undo
  for i=0, 10 do
    local tmp=UndoMen[i]
    if tmp==nil then tmp=100 end
     file:write(tmp); file:write(",")
  end
  file:close()
  end
end
    
function files.read()
  -- восстановление  данных
  -- Открываем файл для чтения и проверяем открытие
  file=love.filesystem.newFile("test.dat")
  file:open('r')
  --Если файл открылся, то считываем данные до конца файла
  if file:isOpen() then
       -- table gamepad
   for myi=1, 16 do
    for mxi=1,19 do
       gamepad[myi][mxi]=files.comread()
    end
   end 
        
   -- чтение переменных
  countstep=files.comread() --  проделано шагов
  manx=files.comread()      --  координаты игрока
  many=files.comread() 
  kmen=files.comread()      -- направление игрока
  rkmen=files.comread()     -- толкающий игрок
  mygamelevel=files.comread()  --номер уровня
  xsound=filesn2b(files.comread())  --звук
  -- table undo
  for i=0, 10 do
     local tmp=files.comread()
     if tmp==100 then tmp=nil end
     UndoMen[i]=tmp
  end
  
  file:close()
  end
end

function files.load()
  files.read()
end
function files.show()
  -- тест файловой системы
  love.graphics.print("f-"..mygamelevel.."-"..manx.."-"..many, tileSize*19+10, tileSize*12) 
end
function files.quit()  -- при выходе сохранить все
 files.write()
end

-- Несколько функций для удобства работы с файлами
-- функция возврващает 1 для true и  0 для false
function filesb2n(xbool)
  if xbool then return 1 else return 0 end
end
-- функция возвращает true для 1 и  false для 0
function filesn2b(xnumber)
  if xnumber==1 then return true else return false end
end

-- функция возвращает число из файла между запятыми
function files.comread()
    y=1; xxx=''
    for i=1, file:getSize() do
       x=file:read(1)
       if x~="," then -- накапливаем данные между разделителями
         xxx=xxx..x 
       else 
         return tonumber(xxx)
       end 
    end
end