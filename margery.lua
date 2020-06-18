-- margery: memory surface 
-- 

package.loaded["margery/lib/factoryactions"] = nil
local factoryactions = require 'margery/lib/factoryactions'

package.loaded["margery/lib/menu"] = nil
local menu = require 'margery/lib/menu'

package.loaded["margery/lib/celleditor"] = nil
local celleditor = require 'margery/lib/celleditor'

package.loaded["margery/lib/action"] = nil
local actions = require 'margery/lib/actions'

package.loaded["margery/lib/memory"] = nil
local memory = require 'margery/lib/memory'

local g = grid.connect()
local grd = 1

local m = menu:new()
local ce = celleditor:new()
local cur_cell = nil
local cur_x = nil
local cur_y = nil
local edit_cell_name = ""

-- READ is 0, WRITE is 1 
local mode = 0

local blink_state = 0

ce:set_action_list(actions:get_action_list())
  
function blink_fn()
  blink_state = 1 - blink_state 
  if mode == 1 then 
    gridredraw()
  end
end
local blink_metro = metro.init(blink_fn,0.4)

function init()
  m:set_items({})
  blink_metro:start()
  gridredraw()
end

function do_escape() 
  mode = 0
end

function g.key(x, y, z)
  if x == 1 then 
    -- control strip 
    if y == 1 and z == 1 then 
      -- esc  return to read mode and no
      -- current cell and escape out of things
      do_escape()
    end
    if y == 7 and z == 1 then 
      if mode == 0 then mode = 1 else mode = 0 end
    end
  end
  if x > 2 and z == 1 then 
    cur_cell = memory:memory(1,x,y)
    cur_x = x
    cur_y = y
    if mode == 0 then 
      -- play cell 
    else 
      -- allow editing of actions
      edit_cell_name = "(" .. x .. "," .. y .. ")"
      ce:set_cell(edit_cell_name, cur_cell)
    end
  end
  gridredraw()
  redraw()
end

function gridredraw()
  g:all(0)
  -- going to try having left side as control strip 
  -- probably should be switchable later on 
  -- but for now hard codeed 
  -- (1,1) - esc key?
  -- play heads 
  for y = 2,4 do 
    g:led(1,y,4)
  end
  -- store or read mode 
  g:led(1,7,mode == 0 and 4 or 10)
  for x = 2,15 do 
    for y = 1,8 do
      if mode == 1 and cur_x == x and cur_y == y then 
        g:led(x,y,(blink_state == 1) and 15 or 6)
      else 
        g:led(x,y,memory:has_memory(1,x,y) and 6 or 0)
      end
    end
  end
  g:refresh()
end

function enc(n, delta)
  if (n == 2) then
    m:scroll(delta)
  end
  redraw()
end

function key(n,z)
  if n == 3 and z == 1 then 
    if mode == 0 then 
      -- do someething for read mode 
    else 
      ce:do_action()
    end
  end
  redraw()
end

function redraw()
  screen.clear()
  if mode == 1 then 
    ce:draw_screen(screen)
  else
    -- do something else 
  end
  screen.update()
end

function cleanup ()
  
end
