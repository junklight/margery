CellEditor = { 
    cell = {} ,
    cline = 1,
    topline = 1,
    headerline = "",
    actionlist = {}, 
    -- mode 0 is just displaying 
    -- mode 1 is adding an action displaying 
    -- popup mmenu
    mode = 0 
    
  }
  
function CellEditor:new(o,actionlist)
  o = o or {} 
  self.__index = self
  setmetatable(o,self)
  self.actionlist = actionlist
  return o
end

function CellEditor:set_action_list(actionlist)
  self.actionlist = actionlist 
end

function CellEditor:scroll(delta)
  self.cline = self.cline + delta 
    if self.cline < 1 then 
      self.cline = 1
    end
    if self.cline > 6 then
      self.cline = 6
    end
    if self.cline > (#self.cell.actionnames + 1) then
      self.cline = (#self.cell.actionnames + 1)
    end
    if self.cline >  4 and self.topline + 6 <= (#self.cell.actionnames + 1) then 
      self.cline = 4
      self.topline = self.topline + 1 
    end
    if self.cline <  2 and self.topline > 1 then 
      self.cline = 2
      self.topline = self.topline - 1 
    end
end    

function CellEditor:set_cell(headerline,mem)
  self.cell = mem
  self.headerline = headerline
  self.cline = 1
  self.topline = 1
  self.selected_action = -1
end

function CellEditor:draw_screen(screen)
  if self.cell.actionnames == nil then
    return
  end
  screen.move(10,10)
  screen.level(15)
  screen.text(self.headerline)
  screen.line_width(1)
  screen.move(5,13)
  screen.line(340,13)
  screen.stroke()
  for i=1,6 do
    local n = self.topline + (i - 1)
    if n > (#self.cell.actionnames + 1) then 
      break 
    end
    local line = "-"
    local setaction = false
    if i == self.cline then
      screen.level(15)
      setaction = true
    else
      screen.level(4)
    end
    screen.move(10,10*(i + 1))
    if n <= #self.cell.actionnames then
      screen.text(self.cell.actionnames[n])
      if setaction then 
        self.selected_action = n
      end
    else
      screen.text("add action...")
      self.selected_action = -1
    end
  end
  if self.mode == 1 then 
    -- display popup 
    -- 128x64
    screen.level(0)
    screen.rect(20,5,100,60)
    screen.fill()
    screen.level(7)
    for idx = 1,#self.actionlist do 
      screen.move(23,5 + (10*idx))
      screen.text(self.actionlist[idx])
    end
  end
end


function CellEditor:do_action()
  if self.mode == 0 then 
    if self.selected_action == -1 then 
      self.mode = 1
    else 
      -- edit an action 
      
    end
  else
    self.mode = 0
  end
end


return CellEditor