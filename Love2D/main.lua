-- from [LÖVE tutorial, part 2](http://www.headchant.com/2010/12/31/love2d-%E2%80%93-tutorial-part-2-pew-pew/)

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
  
  imageGround= love.graphics.newImage("Ground.png") 
  imageWall= love.graphics.newImage("Wall.png") 
  imageBox= love.graphics.newImage("Box.png") 
  imageXbox= love.graphics.newImage("Xbox.png") 
  imageMan= love.graphics.newImage("Man.png") 
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

function love.draw()
  for myi=1, 16 do
    for mxi=1,19 do
     if(gamepad[myi][mxi]==0) then love.graphics.draw(imageGround,(mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==1) then love.graphics.draw(imageWall,(mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==3) then love.graphics.draw(imageBox, (mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==2) then love.graphics.draw(imageXbox, (mxi-1)*32,(myi-1)*32)end
     if(gamepad[myi][mxi]==4) then love.graphics.draw(imageBoxOk,(mxi-1)*32,(myi-1)*32) end
     if(gamepad[myi][mxi]==5) then love.graphics.draw(imageMan, (mxi-1)*32,(myi-1)*32) end
    end
  end 
end