-- margery: memory surface 
-- 

package.loaded["margery/lib/menu"] = nil
local menu = require 'margery/lib/menu'

local g = grid.connect()
local grd = 1

local m = menu:new()


a_lines = { 
   "blah blah",
   "testing testing",
   "zoop",
   "dddddd ddddd",
   "this that etc",
   "plop",
   "plap",
   "giant"
  }
  
b_lines = { 
   "zip",
   "zap",
   "bling bling",
   "dup dup dup",

  }

function init()
  m:set_items(a_lines)
  gridredraw()
end

function g.key(x, y, z)
  if y == 1 and x < 3 and z == 1 then 
    if x == 1 then 
      grd = 1
      m:set_items( a_lines )
    elseif x == 2 then 
      grd = 2
      m:set_items( b_lines )
    end
  end
  gridredraw()
  redraw()
end

function gridredraw()
  g:all(0)
  g:led(grd,1,10)
  g:refresh()
end

function enc(n, delta)
  if (n == 2) then
    m:scroll(delta)
  end
  redraw()
end

function key(n,z)
  
  redraw()
end

function redraw()
  screen.clear()
  m:draw_screen(screen)
  screen.update()
end

function cleanup ()
  
end
