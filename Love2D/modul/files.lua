--Сохраняем при выходе из игры и
-- восстанавливаем уровень игры при старте, если возможно
files={}

-- запись РАБОЧИХ данных в файл
function files.write()
  file=love.filesystem.newFile("test.dat")
  file:open('w') 
 --Если файл открылся, то пишем данные. Если не открылся, то
  -- при следующей загрузке игры будут данные по-умолчанию
  if file:isOpen() then
   -- table gamepad
   local tmp99
   for myi=1, 16 do
    for mxi=1,19 do
       tmp99=gamepad[myi][mxi]
       if tmp99==99 then tmp99=0 end
       file:write(tmp99); file:write(",")
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
    
-- восстановление  данных
function files.read()
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
  files.read() -- читаем при загрузке игры
end

function files.quit()  
 files.write() -- при выходе из игры сохранить все данные
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

-- функция возвращает число из файла данных между запятыми
function files.comread()
    y=1; xxx=''
    for i=1, file:getSize() do
       x=file:read(1)
       if x~="," then -- накапливаем данные между разделителями
         xxx=xxx..x 
       else 
         return tonumber(xxx) -- возвращаем ЧИСЛО
       end 
    end
end
