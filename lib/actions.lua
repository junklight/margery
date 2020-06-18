-- actions are things that can be stored in a memory location 
-- and triggered by pressing a key 
-- for the moment they are just one off actions (send a note, set a voltaage etc.)
-- in future I'd like them to be things like co-routines too 
-- so you can have sequences running (aside from the built in sequence heads)
-- there will be a mechanism like the output library to define your own as well 

local actionlist = { }

Actions = { 
  name="",
  fn = function() print("do something") end
  }

function Actions:add_action( itm )
  if not itm then 
    error("actions should exist")
  end
  if not itm.name then
    error("actions should have a name")
  end
  if  not itm.fn then 
    error("actions should have a function")
  end
  table.insert(actionlist,itm.name)
  self.__index = self 
  setmetatable(itm,self)
  return itm
end

function Actions:get_action_list()
  return actionlist
end
  

return Actions
