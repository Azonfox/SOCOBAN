prorab={}
function prorab.load()
  rng=0     -- переход прораба
  frng=true -- флаг показа прораба
  timerng=0 -- время бездействия до появления прораба
  prx1=1 pry1=1 -- начальные координаты прораба
end

function prorab.update(dt)
   --при длительном бездействии появляется прораб
   if timerng<1000 then frng=false timerng=timerng+1
   else frng=true end
  if compliteflag then frng=false end
   prx1,pry1=prorab.run(prx1,pry1) -- случайно перемещаем прораба
end

function prorab.show()
  if frng then love.graphics.draw(TileSetPng,TileQ[23],prx1,pry1) end
end

 -- новые координаты - случайно перемещаем прораба
function prorab.run(prx,pry)
 if rng>500 then 
   prxk=love.math.random(-1,1) 
   pryk=love.math.random(-1,1) 
   if prxk==0 then prxk=1 end -- проверка на зависание прораба
   if pryk==0 then pryk=1 end
   rng=0
 else 
   rng=rng+1
 end
 -- проверка выхода за пределы игрового поля
 if prx<10  then prx=20   prxk=1  end
 if prx>love.graphics.getWidth()/myscale-tileSize*2 
     then prx=love.graphics.getWidth()/myscale-tileSize*2  prxk=-1 end
 if pry<10  then pry=20   pryk=1  end
 if pry>love.graphics.getHeight()/myscale-tileSize*2 
     then pry=love.graphics.getHeight()/myscale-tileSize*2  pryk=-1 end 
 -- формируем координаты прораба
 prx=prx+love.math.random(0,1)*prxk/1 --10
 pry=pry+love.math.random(0,1)*pryk/1 
return prx,pry,prxk,pryk
end -- end prorab
