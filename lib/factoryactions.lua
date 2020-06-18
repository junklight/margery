package.loaded["margery/lib/action"] = nil
local actions = require 'margery/lib/actions'

actions:add_action( { name="test", fn = function() print("test") end } )
actions:add_action( { name="test 2", fn = function() print("dos something else") end })