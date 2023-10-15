-- key event
  -- Обработка движения
  function keyleft()
    if(manx>1) then
      manx=manx-1
      gamepad[many][manx]=5
    end
  end
  
  function keyright()
    if(manx<19) then
      manx=manx+1
      gamepad[many][manx]=5      
    end
  end
   
  function keyup()
    if (many>1) then
      many=many-1
      gamepad[many][manx]=5      
    end
  end
  
  function keydown()
    if(many<16) then
      many=many+1
      gamepad[many][manx]=5   
    end
  end  
  
  function keyreset() 
    gamereset(mygamelevel) 
  end  
  