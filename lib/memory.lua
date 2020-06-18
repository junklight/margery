
local cells = {} 

local Cell = {
  actionparams = {},
  actionnames = {}
} 

function Cell:new()
  o = {} 
  self.__index = self 
  setmetatable(o,self)
  return o
end

function Cell:has_actions()
  return #self.actionnames > 0
end

function Cell:actions()
  return self.actionnames
end

function Cell:add_action(name,params)
  table.insert(self.actionnames,name)
end

Memory = { } 

function Memory:has_memory(page,x,y)
  -- always make any page requested 
  if not cells[page] then 
    cells[page] = {}
  end
  if not cells[page][x] then 
    return false
  end
  if not cells[page][x][y] then
    return false
  end
  return cells[page][x][y]:has_actions() 
end

function Memory:memory(page,x,y)
  if not cells[page] then 
    cells[page] = {}
  end
  if not cells[page][x] then 
    cells[page][x] = {} 
  end
  if not cells[page][x][y] then
    cells[page][x][y] = Cell:new() 
  end
  return cells[page][x][y] 
end

function Memory:test()
  for page,pages in pairs(cells) do
    for x,row in pairs(pages) do 
      for y,v in pairs(row) do 
        print(page,x,y)
      end
    end
  end
end



return Memory