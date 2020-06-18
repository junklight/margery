package.loaded["margery/lib/action"] = nil
local actions = require 'margery/lib/actions'

one = actions:add_action( { name="test", fn = function() print("test") end } )
two = actions:add_action( { name="test 2", fn = function() print("dos something else") end })