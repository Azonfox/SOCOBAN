--[[
0 - пол
1 - стена
2 - цель
3 - ящик на свободном поле
4 - ящик стоит на цели
5 - MEN на свободном поле
6 - MEN стоит на цели
--]]

function love.load(arg)
 mARR={
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,0,0,1,0,0,0,0,0,0,0,0,0,0,
  0,0,1,1,1,0,0,3,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,3,0,3,0,1,0,0,0,0,0,0,0,0,0,
  1,1,1,0,1,0,1,1,0,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,0,1,1,0,1,1,1,1,1,0,0,2,2,1,
  1,0,3,0,0,3,0,0,0,0,0,0,0,0,0,0,2,2,1,1,1,1,1,1,0,1,1,1,0,1,5,1,1,0,0,2,2,1,
  0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
} 


  manx=12  --Координаты игрока
  many=12
  
  imageGround= love.graphics.newImage("Ground.png") 
  imageWall= love.graphics.newImage("Wall.png") 
  imageBox= love.graphics.newImage("Box.png") 
  imageXbox= love.graphics.newImage("Xbox.png") 
  imageMan= love.graphics.newImage("Man.png") 
  imageManX= love.graphics.newImage("ManX.png") 
  imageBoxOk= love.graphics.newImage("BoxOk.png") 
  
local adr=0
gamepad={}
for myi=1, 16 do
  gamepad[myi]={}
  for mxi=1,19 do
      adr=adr+1
      gamepad[myi][mxi]=mARR[adr]
  end
 end 
end

function love.update(dt)
  
  function love.keyreleased(key)
  if (key == "left") and (manx>1) then
      manx=manx-1
      gamepad[many][manx]=5
  end
  if (key == "right") and (manx<19) then
      manx=manx+1
      gamepad[many][manx]=5      
  end
  if (key == "up") and (many>1) then
      many=many-1
      gamepad[many][manx]=5      
  end  
  if (key == "down") and (many<16) then
      many=many+1
      gamepad[many][manx]=5      
  end   
  
 end
end
  
 
function love.draw()
  for myi=1, 16 do
    for mxi=1,19 do
     if(gamepad[myi][mxi]==0) then love.graphics.draw(imageGround,(mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==1) then love.graphics.draw(imageWall,(mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==3) then love.graphics.draw(imageBox, (mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==2) then love.graphics.draw(imageXbox, (mxi-1)*32,(myi-1)*32)end
     if(gamepad[myi][mxi]==4) then love.graphics.draw(imageBoxOk,(mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==5) then love.graphics.draw(imageMan, (mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==6) then love.graphics.draw(imageManX, (mxi-1)*32,(myi-1)*32) end
    end
  end 
end