Menu = { 
    items = {} ,
    cline = 1,
    topline = 1,
  }
  
function Menu:new(o)
  o = o or {} 
  self.__index = self
  setmetatable(o,self)
  return o
end

function Menu:scroll(delta)
  self.cline = self.cline + delta 
    if self.cline < 1 then 
      self.cline = 1
    end
    if self.cline > 6 then
      self.cline = 6
    end
    if self.cline > (#self.items + 1) then
      self.cline = (#self.items + 1)
    end
    if self.cline >  4 and self.topline + 6 <= (#self.items + 1) then 
      self.cline = 4
      self.topline = self.topline + 1 
    end
    if self.cline <  2 and self.topline > 1 then 
      self.cline = 2
      self.topline = self.topline - 1 
    end
end    

function Menu:set_items(itms)
  self.items = itms
  self.cline = 1
  self.topline = 1
end

function Menu:draw_screen(header,screen)
  screen.move(10,10)
  screen.text(header)
  for i=1,6 do
      local n = self.topline + (i - 1)
      if n > (#self.items + 1) then 
        return 
      end
      local line = "-"
      if i == self.cline then
        screen.level(15)
      else
        screen.level(4)
      end
      screen.move(10,10*(i + 1))
      if n <= #self.items then
        screen.text(self.items[n])
      else
        screen.text("add action...")
      end
    end
end

return Menu