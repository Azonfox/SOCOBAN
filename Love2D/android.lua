-- Работа с сенсорным экраном смартфона
 function touchkey() 
   local touches = love.touch.getTouches()
   if touches[1] ~= nil then
      ttx,tty = love.touch.getPosition(touches[1])
      --love.touchpressed(id,ttx,tty)
      
      ttx=ttx*2/3
      tty=tty*2/3
            
      if  ttx>tkx2 and ttx<tkx3 and tty>tky1 and tty<tky2 then gamekeyevent(1,2,0,0)   kmen=1 end -- Right
      if  ttx>tkx0 and ttx<tkx1 and tty>tky1 and tty<tky2 then gamekeyevent(-1,-2,0,0) kmen=2 end -- Left
      if  ttx>tkx1 and ttx<tkx2 and tty>tky2 and tty<tky3 then gamekeyevent(0,0,1,2)   kmen=3 end -- Down
      if  ttx>tkx1 and ttx<tkx2 and tty>tky0 and tty<tky1 then gamekeyevent(0,0,-1,-2) kmen=4 end -- UP
      
     -- for I=1,  10000000  do  ttx=100000000*dt end -- Задержка :(
   end
end
