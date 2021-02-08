-- # UTIL
-- This file sets up helper functions for further loading in other functions!

Utils = {}


local scopes = {b = {vim.o, vim.bo}, w = {vim.o, vim.wo}}

-- You need to set the global variable, as well as either window or buffer variable to make sure everything works
-- Need to use this workaround to set options until simpler option interface is made in master
-- Takes in scope of operation, key of the option, and value to set the option as
-- Useful for settings that require you to set vim.b and vim.w manually
function Utils.opt (s, k, v)
  for _, scope in pairs(scopes[s]) do
    scope[k]=v
  end
end

return Utils
