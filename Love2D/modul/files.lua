--[[
Сохраняем восстанавливаем:

  countstep=0 --  проделано шагов
  manx=1 --Координаты игрока XY
  many=1
  mygamelevel=1  -- номер начального уровня
  keyMess=0 -- Для проверки выбора меню

  gamepad={} -- игровой уровень 19х16
  UndoMen={}  -- Таблица UNDO для отката
  kmen=0    -- направление игрока вниз
  rkmen=0   -- не толкающий игрок 

  xsound -- вкл.откл звук  true-false


--]]


files={}

function files.write()
  -- тест файловой системы - запись данных
  file=love.filesystem.newFile("test.dat")
  file:open('w') 
  --file:write(tostring(mygamelevel),2)
  --file:write(filesb2n(xsound),1)
  test={1,2,3,4,5,6,7,8,9,0}
  file:write(tostring(test))
  
end
  
function files.read()
  -- тест файловой системы - запись данных
  file=love.filesystem.newFile("test.dat")
  file:open('r') 
  mygamelevel=tonumber(file:read(2),10)
  xsound=filesn2b(file:read(1))
end

function files.load()
  local test={}
  for line in love.filesystem.lines("test.dat") do
    table.insert(test,line)
  end
  files.write()

--  files.read() --восстановление 
end

function files.update(dt)
end

function files.show()
  -- тест файловой системы
  love.graphics.print("file-"..mygamelevel, tileSize*19+10, tileSize*12) 
end

function files.quit()  -- при выходе сохранить все
 files.write()
end

-- Несколько функций для удобства работы с файлами
-- функция возврващает 1 для true и  0 для false
function filesb2n(xbool)
  if xbool then return 1 else return 0 end
end
-- функция возврващает true для 1 и  false для 0
function filesn2b(xnumber)
  if xnumber==1 then return true else return false end
end

function tostring_n(xnumber,count)
  local xstr
  return tostring(xnumber)
end
  